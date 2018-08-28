package com.mystudy.ojdbc_CRUD;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.TreeMap;

//JDBC�� �̿��� DB ���α׷��� ���
//0. JDBC ���̺귯�� ����ȯ�� ����(�����ο� ���)
//1. JDBC ����̹� �ε�
//2. DB����  - Connection ��ü ���� <-DriverManager
//3. Statement�� ����(SQL�� ����)
//4. SQL ���� ����� ���� ó��
//   -SELECT : ��ȸ(�˻�) ����Ÿ ��� ���� ���� ó��
//   -INSERT, UPDATE, DELETE : int��(�Ǽ�) ó��
//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
//////////////////////////////////////
public class StudentCRUD {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	StudentCRUD() {
		try {
			//1. JDBC ����̹� �ε�
			Class.forName("oracle.jdbc.OracleDriver");
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}
	
	//SELECT : ID
	public void dispData(String id) {
		try {
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " WHERE ID = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			//4. SQL ���� ����� ���� ó��
			//primary key ��ȸ ��� : 0, 1
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
				System.out.println(id + "-����Ÿ ����");
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " WHERE ID = ? ";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			
			//4. SQL ���� ����� ���� ó��
			//primary key ��ȸ ��� : 0, 1
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
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
	
	//��ü ����Ÿ ��ȸ
	public ArrayList<StudentVO> selectAll() {
		ArrayList<StudentVO> list = null;
		
		try {
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "SELECT ID, NAME, KOR, ENG, MATH, TOT, AVG ";
			sql += "  FROM STUDENT ";
			sql += " ORDER BY ID "; 
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			//4. SQL�� ���� ����� ���� ó��
			list = new ArrayList<>(); 
			while (rs.next()) {
				/* DB�� �ִ� ����Ÿ�� �״�� VO�� ����
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
				/* DB�� �ִ� ����Ÿ�� VO���� tot, avg ���ó��
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
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
	//(�ǽ�-������)��ü ����Ÿ ��ȸ : <id, VO>
	public TreeMap<String, StudentVO> selectAllMap() {
		TreeMap<String, StudentVO> stus = null;
		
		
		
		
		return stus;
	}
	
	//(�ǽ�)�̸����� ��ȸ-�̸� �ߺ� ����Ÿ ���� ���ɼ� ����
	
	//DB�� ����Ÿ �Է�
	public int insertData(String id, String name, 
			int kor, int eng, int math, int tot, double avg) {
		int cnt = 0;
		
		try {
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "INSERT INTO STUDENT ";
			sql += "       (ID, NAME, KOR, ENG, MATH, TOT, AVG) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";
			//3-1. SQL ���� ���� �غ�
			pstmt = conn.prepareStatement(sql);
			
			//3-2. SQL ������ ? ��ġ�� �� ��Ī
			pstmt.setString(1, id);
			pstmt.setString(2, name);
			pstmt.setInt(3, kor);
			pstmt.setInt(4, eng);
			pstmt.setInt(5, math);
			pstmt.setInt(6, tot);
			pstmt.setDouble(7, avg);
			
			//3-3 �غ�� SQL���� ���� ó��
			cnt = pstmt.executeUpdate();
			
			//4. SQL ���� ����� ���� ó��
			System.out.println("ó���Ǽ�: " + cnt);
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
	
	//StudentVO ����Ÿ�� �޾Ƽ� �Է�
	public int insertData(StudentVO stu) {
		int result = 0;
		
		try {
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "INSERT INTO STUDENT ";
			sql += "       (ID, NAME, KOR, ENG, MATH, TOT, AVG) ";
			sql += "VALUES (?, ?, ?, ?, ?, ?, ?) ";
			//3-1. SQL ���� ���� �غ�
			pstmt = conn.prepareStatement(sql);
			
			//3-2. SQL ������ ? ��ġ�� �� ��Ī
			pstmt.setString(1, stu.getId());
			pstmt.setString(2, stu.getName());
			pstmt.setInt(3, stu.getKor());
			pstmt.setInt(4, stu.getEng());
			pstmt.setInt(5, stu.getMath());
			pstmt.setInt(6, stu.getTot());
			pstmt.setDouble(7, stu.getAvg());
			
			//3-3. SQl ����
			result = pstmt.executeUpdate();
			
			//4. SQl ������ ���� ���� ó�� - �� ���� 
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
			closeConnStmt(conn, pstmt);	
		}
		
		return result;
	}
	
	//(�ǽ�-������)updateName : ID, NAME ���� �޾Ƽ� ID�� ��ȸ�ؼ� NAME �� ����
	
	//(�ǽ�)updateJumsu : ID, KOR, ENG, MATH ���� �޾Ƽ� ID�� ã��, 
	//     KOR,ENG,MATH,TOT,AVG �� ����(TOT, AVG ���ó��)
	
	//(�ǽ�)updateTotAvg : ID ���� �޾Ƽ� TOT, AVG �� ����ó��
	
	//StudentVO ����Ÿ�� �޾Ƽ� ����
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
	
	//id�� �޾Ƽ� ����
	public int deleteData(String id) {
		int result = 0;
		
		try {
			//DB����
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			String sql = "";
			sql += "DELETE FROM STUDENT WHERE ID = ?";
			
			//SQL���� �غ�
			pstmt = conn.prepareStatement(sql);
			
			//SQL �� ����
			pstmt.setString(1, id);
			
			//SQL ���� ����
			result = pstmt.executeUpdate();
			
			//SQL ���� ����� ���� ó�� - �� ����
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//(�ǽ�) StudentVO ����Ÿ�� �޾Ƽ� ����(ID������)
	
	//(�ǽ�-������)�̸� �� �޾Ƽ� ����
	

}













