package com.mystudy.ojdbc;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

public class StudentManager_Delete {

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

		//(�ǽ�) '2018003' �������� ����Ÿ�� �����ϴ� JDBC ���α׷� �ۼ�
		//0. JDBC ���̺귯�� ����ȯ�� ����(�����ο� ���)
		//1. JDBC ����̹� �ε�
		try {
			Class.forName("oracle.jdbc.OracleDriver");
			System.out.println(">> ����̹��ε� ����");
		} catch (ClassNotFoundException e) {
			System.out.println("[����] ����̹��ε� ����!!!");
			e.printStackTrace();
		}
		
		//2. DB����  - Connection ��ü ���� <-DriverManager
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@127.0.0.1:1521:xe", 
					"mystudy", "mystudypw");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		//3. Statement ��ü�� ����ؼ� SQL�� ����
		Statement stmt = null;
		try {
			//3-1. Connection ��ü�� ���� Statement ��ü �����ϰ�,
			stmt = conn.createStatement();
			
			//3-2. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "DELETE FROM STUDENT WHERE ID = '2018003'";
			
			//SELECT �� : executeQuery()
			//INSERT, UPDATE, DELETE�� : executeUpdate()
			int result = stmt.executeUpdate(sql);
			
			//4. SQL ���� ����� ���� ó��
			System.out.println("DELETE>> �����Ǽ�: " + result);
			
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		
		//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
		//--Ŭ��¡ ó���� ���������� �������� ����
		try {
			stmt.close();
			System.out.println(">>Statement ��ü close ó��");
		} catch (SQLException e) {
			e.printStackTrace();
		}
		
		try {
			conn.close();
			System.out.println(">>Connection ��ü close ó��");
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
		

}
