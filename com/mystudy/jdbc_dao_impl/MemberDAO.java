package com.mystudy.jdbc_dao_impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common_util.JDBC_Close;

//DAO / Dao : Data Access Object / Database Access Object
//데이타베이스와 연결해서 CRUD를 구현하는 클래스
public class MemberDAO {
	private static final String DRIVER = "oracle.jdbc.OracleDriver"; 
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	private static final String USER = "mystudy"; 
	private static final String PASSWORD = "mystudypw"; 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//static 초기화 구문
	static {
		try {
			Class.forName(DRIVER);
			System.out.println(">> 오라클 JDBC 드라이버 로딩 성공!!");
		} catch (ClassNotFoundException e) {
			System.out.println("[예외발생] 드라이버 로딩 실패!!!");
		}
	}
	
	/*
	//SELECT : 테이블에 있는 데이타 전체 조회 -selectAll : ArrayList<MemberVO>
	//SELECT : 하나의 데이타 조회(ID) - selectOne : MemberVO
	//SELECT : 하나의 데이타 조회(VO) - selectOne : MemberVO
	//INSERT : VO 객체를 받아서 입력 - insertOne : int
	//UPDATE : VO 객체를 받아서 수정 - updateOne : int
	//DELETE : VO 객체를 받아서 삭제 - deleteOne : int
	//DELETE : 키값(ID)을 전달받아 삭제 - deleteOne : int 
	//로그인 처리 : ID, PASSWORD 값을 받아서 동일한 데이타 있으면 true, 없으면 false 리턴
	//     boolean checkIdPassword(id, password) 
	*/
	
	//SELECT : 테이블에 있는 데이타 전체 조회 -selectAll : ArrayList<MemberVO>
	public ArrayList<MemberVO> selectAll() {
		ArrayList<MemberVO> list = null;
		
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID, PASSWORD, NAME, PHONE, ADDRESS ");
			sb.append("  FROM MEMBER ");
			sb.append(" ORDER BY ID ");
			
			//Connection 객체로 부터 PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문장 실행
			rs = pstmt.executeQuery(); //SELECT : executeQuery()
			
			list = new ArrayList<>();
			while (rs.next()) {
				//new MemberVO(id, password, name, phone, address)
				/*
				MemberVO mvo = new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address"));
				list.add(mvo);
				*/
				list.add(new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address")));
			}
			//데이타가 1건도 없는 경우 list를 null로 초기화
			if (list.size() < 1) {
				list = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//SELECT : 하나의 데이타 조회(ID) - selectOne : MemberVO
	public MemberVO selectOne(String id) {
		MemberVO mvo = null;
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT * FROM MEMBER WHERE ID = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mvo = new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		return mvo;
	}
	
	//SELECT : 하나의 데이타 조회(VO) - selectOne : MemberVO
	public MemberVO selectOne(MemberVO member) {
		MemberVO mvo = null;
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT * FROM MEMBER WHERE ID = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, member.getId());
			
			rs = pstmt.executeQuery();
			if (rs.next()) {
				mvo = new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address"));
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		return mvo;
	}
	
	public ArrayList<MemberVO> selectName(String name) {
		ArrayList<MemberVO> list = null;
		
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID, PASSWORD, NAME, PHONE, ADDRESS ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE NAME = ? ");
			
			//Connection 객체로 부터 PreparedStatement 객체 생성
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, name);
			//SQL문장 실행
			rs = pstmt.executeQuery(); //SELECT : executeQuery()
			
			list = new ArrayList<>();
			while (rs.next()) {
				list.add(new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address")));
			}
			//데이타가 1건도 없는 경우 list를 null로 초기화
			if (list.size() < 1) {
				list = null;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//INSERT : VO 객체를 받아서 입력 - insertOne : int
	public int insertOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB 연결
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL 문장 실행을 위한 준비
			//SQL 문장 작성
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//SQL 문장을 전달해서 실행 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?에 값 매칭 작업
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getAddress());
			
			//SQL문 실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//사용한 자원 닫기
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//UPDATE : VO 객체를 받아서 수정 - updateOne : int
	public int updateOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB 연결
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL 문장 실행을 위한 준비
			//SQL 문장 작성
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE MEMBER ");
			sb.append("   SET PASSWORD = ? ");
			sb.append("     , NAME = ? ");
			sb.append("     , PHONE = ? ");
			sb.append("     , ADDRESS = ? ");
			sb.append(" WHERE ID = ?");
			//SQL 문장을 전달해서 실행 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?에 값 매칭 작업
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getId());
			
			//SQL문 실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//사용한 자원 닫기
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//DELETE : VO 객체를 받아서 삭제 - deleteOne : int
	public int deleteOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB 연결
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL 문장 실행을 위한 준비
			//SQL 문장 작성
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			
			//SQL 문장을 전달해서 실행 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?에 값 매칭 작업
			pstmt.setString(1, member.getId());
			
			//SQL문 실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//사용한 자원 닫기
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//DELETE : ID 받아서 삭제 - deleteOne : int
	public int deleteOne(String id) {
		int result = 0;
		
		try {
			//DB 연결
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL 문장 실행을 위한 준비
			//SQL 문장 작성
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			
			//SQL 문장을 전달해서 실행 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?에 값 매칭 작업
			pstmt.setString(1, id);
			
			//SQL문 실행
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//사용한 자원 닫기
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	//로그인 처리 : ID, PASSWORD 값을 받아서 동일한 데이타 있으면 true, 없으면 false 리턴
	//boolean checkIdPassword(id, password)
	public boolean checkIdPassword(String id, String password) {
		boolean result = false;
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID  ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE ID = ? AND PASSWORD = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			if (rs.next()) { //최소 1 건 이상의 데이타가 있음
				result = true;
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		
		return result;
	}
	
	public boolean checkIdPassword2(String id, String password) {
		boolean result = false;
		try {
			//DB연결 - Connection 객체 생성
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT COUNT(*) AS CNT ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE ID = ? AND PASSWORD = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			if (rs.next()) { //COUNT(*) 값은 무조건 있음 0~n
				if (rs.getInt(1) > 0) {
					result = true;
				} 
			}
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmtRs(conn, pstmt, rs);
		}
		
		
		return result;
	}
	
	
	
	
	
}
