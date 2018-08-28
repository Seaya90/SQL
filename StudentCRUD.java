package com.mystudy.ojdbc_CRUD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.TreeMap;

//JDBC를 이용한 DB 프로그래밍 방법
//0. JDBC 라이브러리 개발환경 설정(빌드경로에 등록)
//1. JDBC 드라이버 로딩
//2. DB연결  - Connection 객체 생성 <-DriverManager
//3. Statement문 실행(SQL문 실행)
//4. SQL 실행 결과에 대한 처리
//   -SELECT : 조회(검색) 데이타 결과 값에 대한 처리
//   -INSERT, UPDATE, DELETE : int값(건수) 처리
//5. 클로징 처리에 의한 자원 반납
//////////////////////////////////////
public class StudentCRUD {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	StudentCRUD() {
		try {
			//1. JDBC 드라이버 로딩
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//SELECT : ID
	public void dispData(String id) {
		try {
			//2. DB연결  - Connection 객체 생성 <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " WHERE ID = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			//4. SQL 실행 결과에 대한 처리
			//primary key 조회 결과 : 0, 1
			if (rs.next()) {
				
				String str = "";
				str += rs.getString(1) + "\t";
				str += rs.getString(2) + "\t";
				str += rs.getInt(3) + "\t";
				str += rs.getInt(4) + "\t";
				str += rs.getInt(5) + "\t";
				str += rs.getInt(6) + "\t";
				str += rs.getDouble(7);
				System.out.println(str);
			} else {
				System.out.println(id + "-데이타 없음");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
		}

	}
	
	public StudentVO selectId(String id) {
		StudentVO stu = null;
		
		try {
			//2. DB연결  - Connection 객체 생성 <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " WHERE ID = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			//4. SQL 실행 결과에 대한 처리
			//primary key 조회 결과 : 0, 1
			if (rs.next()) {
				stu = new StudentVO(id,
						rs.getString("NAME"),
						rs.getInt("KOR"),
						rs.getInt("ENG"),
						rs.getInt("MATH")
						);
				/*
				stu = new StudentVO(id,
						rs.getString("NAME"),
						rs.getInt("KOR"),
						rs.getInt("ENG"),
						rs.getInt("MATH"),
						rs.getInt("TOT"),
						rs.getDouble("AVG")
						);
				*/
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			closeConnStmtRs(conn, pstmt, rs);
			/*
			try {
				if (rs != null) {
					rs.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			*/
		}

		return stu;
	}
	
	//전체 데이타 조회
	public ArrayList<StudentVO> selectAll() {
		ArrayList<StudentVO> list = null;
		
		try {
			//2. DB연결  - Connection 객체 생성 <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " ORDER BY ID "; 
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			//4. SQL문 실행 결과에 대한 처리
			list = new ArrayList<>(); 
			while (rs.next()) {
				/* DB에 있는 데이타를 그대로 VO에 저장
				StudentVO vo = new StudentVO(
						rs.getString("ID"),
						rs.getString("NAME"),
						rs.getInt("KOR"),
						rs.getInt("ENG"),
						rs.getInt("MATH"),
						rs.getInt("TOT"),
						rs.getDouble("AVG")
						);
				*/
				/* DB에 있는 데이타를 VO에서 tot, avg 계산처리
				StudentVO vo = new StudentVO(
						rs.getString("ID"),
						rs.getString("NAME"),
						rs.getInt("KOR"),
						rs.getInt("ENG"),
						rs.getInt("MATH")
						);
				*/
				int kor = rs.getInt("KOR");
				int eng = rs.getInt("ENG");
				int math = rs.getInt("MATH");
				int tot = kor + eng + math;
				double avg = tot * 10 / 3 / 10.0;
				StudentVO vo = new StudentVO(
						rs.getString("ID"),
						rs.getString("NAME"),
						kor, eng, math, tot, avg
						);
				
				list.add(vo);
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			closeConnStmtRs(conn, pstmt, rs);
		}
		return list;
	}
	
	
	private void closeConnStmtRs(Connection conn,
			PreparedStatement pstmt, ResultSet rs) {
		
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	private void closeConnStmt(Connection conn,
			PreparedStatement pstmt) {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	//(실습-개인적)전체 데이타 조회 : <id, VO>
	public TreeMap<String, StudentVO> selectAllMap() {
		TreeMap<String, StudentVO> stus = null;
		
		
		
		
		return stus;
	}
	
	//(실습)이름으로 조회-이름 중복 데이타 있을 가능성 있음
	
	//DB에 데이타 입력
	public int insertData(String id, String name, 
			int kor, int eng, int math, int tot, double avg) {
		int cnt = 0;
		
		try {
			//2. DB연결  - Connection 객체 생성 <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "INSERT INTO STUDENT ";
			sql += "       (ID, NAME, KOR, ENG, MATH, TOT, AVG) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";
			//3-1. SQL 문장 실행 준비
			pstmt = conn.prepareStatement(sql);
			
			//3-2. SQL 문장의 ? 위치에 값 매칭
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setInt(3, kor);
			pstmt.setInt(4, eng);
			pstmt.setInt(5, math);
			pstmt.setInt(6, tot);
			pstmt.setDouble(7, avg);
			
			//3-3 준비된 SQL문장 실행 처리
			cnt = pstmt.executeUpdate();
			
			//4. SQL 실행 결과에 대한 처리
			System.out.println("처리건수: " + cnt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			closeConnStmt(conn, pstmt);
			/*
			try {
				if (pstmt != null) {
					pstmt.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			try {
				if (conn != null) {
					conn.close();
				}
			} catch (SQLException e) {
				e.printStackTrace();
			}
			*/
		}
		
		return cnt;
	}
	
	//StudentVO 데이타를 받아서 입력
	public int insertData(StudentVO stu) {
		int result = 0;
		
		try {
			//2. DB연결  - Connection 객체 생성 <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "INSERT INTO STUDENT ";
			sql += "       (ID, NAME, KOR, ENG, MATH, TOT, AVG) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";
			//3-1. SQL 문장 실행 준비
			pstmt = conn.prepareStatement(sql);
			
			//3-2. SQL 문장의 ? 위치에 값 매칭
			pstmt.setString(1, stu.getId());
			pstmt.setString(2, stu.getName());
			pstmt.setInt(3, stu.getKor());
			pstmt.setInt(4, stu.getEng());
			pstmt.setInt(5, stu.getMath());
			pstmt.setInt(6, stu.getTot());
			pstmt.setDouble(7, stu.getAvg());
			
			//3-3. SQl 실행
			result = pstmt.executeUpdate();
			
			//4. SQl 실행결과 값에 대한 처리 - 값 리턴 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			closeConnStmt(conn, pstmt);	
		}
		
		return result;
	}
	
	//(실습-개인적)updateName : ID, NAME 값을 받아서 ID로 조회해서 NAME 값 수정
	
	//(실습)updateJumsu : ID, KOR, ENG, MATH 값을 받아서 ID로 찾고, 
	//     KOR,ENG,MATH,TOT,AVG 값 수정(TOT, AVG 계산처리)
	
	//(실습)updateTotAvg : ID 값을 받아서 TOT, AVG 값 수정처리
	
	//StudentVO 데이타를 받아서 수정
	public int updateData(StudentVO stu) {
		int result = 0;
		
		try {
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			String sql = "";
			sql += "UPDATE STUDENT ";
			sql += "   SET NAME = ? ";
			sql += "     , KOR = ? ";
			sql += "     , ENG = ? ";
			sql += "     , MATH = ? ";
			//sql += "     , AAA = ? ";
			sql += "     , TOT = ? ";
			sql += "     , AVG = ? ";
			sql += " WHERE ID = ? ";
			
			pstmt = conn.prepareStatement(sql);
			
			int i = 0;
			pstmt.setString(++i, stu.getName()); //1
			pstmt.setInt(++i, stu.getKor());     //2
			pstmt.setInt(++i, stu.getEng());     //3
			pstmt.setInt(++i, stu.getMath());    //4
			//pstmt.setInt(++i, stu.getAaa());     //5
			pstmt.setInt(++i, stu.getTot());     //6
			pstmt.setDouble(++i, stu.getAvg());  //7
			pstmt.setString(++i, stu.getId());   //8
			
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//id값 받아서 삭제
	public int deleteData(String id) {
		int result = 0;
		
		try {
			//DB연결
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			String sql = "";
			sql += "DELETE FROM STUDENT WHERE ID = ?";
			
			//SQL문장 준비
			pstmt = conn.prepareStatement(sql);
			
			//SQL 값 설정
			pstmt.setString(1, id);
			
			//SQL 문장 실행
			result = pstmt.executeUpdate();
			
			//SQL 실행 결과에 대한 처리 - 값 리턴
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//(실습) StudentVO 데이타를 받아서 삭제(ID값으로)
	
	//(실습-개인적)이름 값 받아서 삭제
	

}













