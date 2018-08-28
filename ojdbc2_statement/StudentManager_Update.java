package com.mystudy.ojdbc2_statement;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class StudentManager_Update {

	public static void main(String[] args) {
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

		//0. JDBC ���̺귯�� ����ȯ�� ����(�����ο� ���)
		Connection conn = null;
		Statement stmt = null;
		
		try {
			//1. JDBC ����̹� �ε�
			Class.forName("oracle.jdbc.OracleDriver");
			
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@127.0.0.1:1521:xe", 
					"mystudy", "mystudypw");

			//3-1. Connection ��ü�� ���� Statement ��ü �����ϰ�,
			stmt = conn.createStatement();
			
			//3-2. Statement�� ����(SQL�� ����)
			String sql = "";
			String id = "2018005";
			int kor = 99;
			int eng = 88;
			int math = 77;
			/*
			sql += "UPDATE STUDENT ";
			sql += "   SET KOR = 99 ";
			sql += "     , ENG = 88 ";
			sql += "     , MATH = 77 ";
			sql += " WHERE ID = '2018005' ";
			*/
			sql += "UPDATE STUDENT ";
			sql += "   SET KOR = "+ kor;
			sql += "     , ENG = " + eng;
			sql += "     , MATH = " + math;
			sql += " WHERE ID = '" + id + "' ";
			System.out.println("sql: " + sql);
			
			int cnt = stmt.executeUpdate(sql);
			
			//4. SQL ���� ����� ���� ó��
			System.out.println(">> �����Ǽ�: " + cnt);
			
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
			try {
				if (stmt != null) {
					stmt.close();
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

}
