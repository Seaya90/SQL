package com.mystudy.ojdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class StudentManager_Delete {

	public static void main(String[] args) {
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

		//(실습) '2018003' 김유신의 데이타를 삭제하는 JDBC 프로그램 작성
		//0. JDBC 라이브러리 개발환경 설정(빌드경로에 등록)
		//1. JDBC 드라이버 로딩
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println(">> 드라이버로딩 성공");
		} catch (ClassNotFoundException e) {
			System.out.println("[예외] 드라이버로딩 실패!!!");
			e.printStackTrace();
		}
		
		//2. DB연결  - Connection 객체 생성 <-DriverManager
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@127.0.0.1:1521:xe", 
					"mystudy", "mystudypw");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//3. Statement 객체를 사용해서 SQL문 실행
		Statement stmt = null;
		try {
			//3-1. Connection 객체로 부터 Statement 객체 생성하고,
			stmt = conn.createStatement();
			
			//3-2. Statement문 실행(SQL문 실행)
			String sql = "";
			sql += "DELETE FROM STUDENT WHERE ID = '2018003'";
			
			//SELECT 문 : executeQuery()
			//INSERT, UPDATE, DELETE문 : executeUpdate()
			int result = stmt.executeUpdate(sql);
			
			//4. SQL 실행 결과에 대한 처리
			System.out.println("DELETE>> 삭제건수: " + result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		//5. 클로징 처리에 의한 자원 반납
		//--클로징 처리시 생성순서와 역순으로 진행
		try {
			stmt.close();
			System.out.println(">>Statement 객체 close 처리");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			conn.close();
			System.out.println(">>Connection 객체 close 처리");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		

}
