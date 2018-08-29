package com.mystudy.dao_list;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common_util.JDBC_Close;

//JDBC를 이용한 DB 프로그래밍 방법
//0. JDBC 라이브러리 개발환경 설정(빌드경로에 등록)
//1. JDBC 드라이버 로딩
//2. DB연결  - Connection 객체 생성 <-DriverManager

//3. Statement문 실행(SQL문 실행)
//4. SQL 실행 결과에 대한 처리
// -SELECT : 조회(검색) 데이타 결과 값에 대한 처리
// -INSERT, UPDATE, DELETE : int값(건수) 처리

//5. 클로징 처리에 의한 자원 반납
//////////////////////////////////////
public class MemberDAO implements MemberListCUD {
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	public MemberDAO() {
		this.driverLoading();
	}
	
	private void driverLoading() {
		try {
			Class.forName(DRIVER);
			//System.out.println(">> 오라클 JDBC 드라이버 로딩 성공!!");
		} catch (ClassNotFoundException e) {
			System.out.println("[예외발생] 드라이버 로딩 실패!!!");
		}
	}
	private Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			System.out.println("[예외발생] DB연결 실패!!!");
		}
		return conn;
	}
	
	@Override
	public void printDataAll() {
		
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
	public int insertListOne(ArrayList<MemberVO> list) {
		//리턴값 저장용 변수 선언
		int result = 0;
		
		//전달받은 list에 있는 VO값을 추출해서 insertOne(VO) 메소드 호출시 전달
		for (MemberVO member : list) {
			//result = result + insertOne(member);
			result += insertOne(member);
		}
		
		return result;
	}
	
	@Override
	public int insertList(ArrayList<MemberVO> list) {
		//리턴값 저장을 위한 변수 선언
		int result = 0;
		//2. DB연결  - Connection 객체 생성 <-DriverManager
		conn = getConnection();
		if (conn == null) {
			return -1;
		}

		try {
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//3. Statement문 실행(SQL문 실행)
			//SQL문 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?위치에 값 설정
			for (MemberVO member : list) {
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPassword());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getAddress());
				//SQL문 실행
				result += pstmt.executeUpdate();
			}
			
			//4. SQL 실행 결과에 대한 처리-INSERT, UPDATE, DELETE : int값(건수) 처리
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmt(conn, pstmt);
		}

		//5. 클로징 처리에 의한 자원 반납
		
		
		return result;
	}
	
	//전체 입력처리 또는 예외발생시 전체 데이타 입력취소 처리되도록 구현
	//기본 AutoCommit = true 상태
	public int insertListCommit(ArrayList<MemberVO> list) {
		//리턴값 저장을 위한 변수 선언
		int result = 0;
		//2. DB연결  - Connection 객체 생성 <-DriverManager
		conn = getConnection();
		if (conn == null) {
			return -1;
		}

		try {
			//AutoCommit 설정 값 확인
			System.out.println("AutoCommit상태확인: " 
					+ conn.getAutoCommit());
			
			//AutoCommit 값을 false 설정
			conn.setAutoCommit(false); 
			System.out.println("AutoCommit 해제상태: " 
					+ conn.getAutoCommit());
			
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//3. Statement문 실행(SQL문 실행)
			//SQL문 준비
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문의 ?위치에 값 설정
			for (MemberVO member : list) {
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPassword());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getAddress());
				//SQL문 실행
				result += pstmt.executeUpdate();
			}
			
			//모든 데이타에 대한 처리가 정상적으로 종료된 상태
			conn.commit(); //모든 SQL 실행문에 대하여 확정 처리(DB에 반영)
			conn.setAutoCommit(true);
			
		} catch (SQLException e) {
			try {
				//SQL문 실행처리된 모든 작업에 대하여 취소 처리(DB 반영 안함)
				conn.rollback();
				conn.setAutoCommit(true);
				result = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			//5. 클로징 처리에 의한 자원 반납
			JDBC_Close.closeConnStmt(conn, pstmt);
		}

		return result;
	}

	@Override
	public int updateList(ArrayList<MemberVO> list) {
		int result = 0;
		conn = getConnection();
		if (conn == null) {
			return -999;
		}
		
		try {
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE MEMBER ");
			sb.append("   SET PASSWORD = ? ");
			sb.append("     , NAME = ? ");
			sb.append("     , PHONE = ? ");
			sb.append("     , ADDRESS = ? ");
			sb.append(" WHERE ID = ? ");
			conn.setAutoCommit(false); //AutoCommit 해제
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문 ? 위치에 값 설정
			for (int i = 0; i < list.size(); i++) {
				MemberVO member = list.get(i);
				int idx = 1;
				pstmt.setString(idx++, member.getPassword());
				pstmt.setString(idx++, member.getName());
				pstmt.setString(idx++, member.getPhone());
				pstmt.setString(idx++, member.getAddress());
				pstmt.setString(idx++, member.getId());
				
				//SQL문 실행
				result += pstmt.executeUpdate();
			}
			conn.commit(); //전체 SQL 실행 결과 DB에 반영
			conn.setAutoCommit(true); //AutoCommit 설정
		} catch (SQLException e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
				result = -888;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}

	@Override
	public int deleteList(ArrayList<MemberVO> list) {
		int result = 0;
		conn = getConnection();
		if (conn == null) {
			return -999;
		}
		
		try {
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			conn.setAutoCommit(false); //AutoCommit 해제
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문 ? 위치에 값 설정
			for (MemberVO mvo : list) {
				pstmt.setString(1, mvo.getId());
				
				//SQL문 실행
				result += pstmt.executeUpdate();
			}
			conn.commit(); //전체 SQL 실행 결과 DB에 반영
			conn.setAutoCommit(true); //AutoCommit 설정
		} catch (SQLException e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
				result = -888;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	
	public int deleteListID(ArrayList<String> list) {
		int result = 0;
		conn = getConnection();
		if (conn == null) {
			return -999;
		}
		
		try {
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			conn.setAutoCommit(false); //AutoCommit 해제
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL문 ? 위치에 값 설정
			for (String id : list) {
				pstmt.setString(1, id);
				
				//SQL문 실행
				result += pstmt.executeUpdate();
			}
			conn.commit(); //전체 SQL 실행 결과 DB에 반영
			conn.setAutoCommit(true); //AutoCommit 설정
		} catch (SQLException e) {
			try {
				conn.rollback();
				conn.setAutoCommit(true);
				result = -888;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}

}
