package com.mystudy.ojdbc3_prepared;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.SQLException;

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
		
		
		//JDBC�� �̿��Ͽ� STUDENT ���̺��� ����Ÿ�� �����ϴ� ���α׷� �ۼ�
		//ID�� ã�Ƽ� NAME, KOR, ENG, MATH, TOT, AVG ���� ó��
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			//1. JDBC ����̹� �ε�
			Class.forName("oracle.jdbc.OracleDriver");
			
			//2. DB����  - Connection ��ü ���� <-DriverManager
			conn = DriverManager.getConnection(
					"jdbc:oracle:thin:@localhost:1521:xe", 
					"mystudy", "mystudypw");
			
			//3. Statement�� ����(SQL�� ����)
			String sql = "";
			sql += "UPDATE STUDENT ";
			sql += "   SET NAME = ? "; //1
			sql += "     , KOR = ? ";  //2
			sql += "     , ENG = ? ";  //3
			sql += "     , MATH = ? "; //4
			sql += "     , TOT = ? ";  //5
			sql += "     , AVG = ? ";  //6
			sql += " WHERE ID = ? ";   //7
			

			//3-1. SQL ���� ���� �غ�
			pstmt = conn.prepareStatement(sql);
			
			
			String id = "2018006";
			String name = "������2";
			int kor = 99;
			int eng = 88;
			int math = 77;
			int tot = kor + eng + math;
			double avg = tot * 100 / 3 / 100.0;
			
			//3-2. SQL ������ ? ��ġ�� �� ��Ī
			pstmt.setString(1, name);
			pstmt.setInt(2, kor);
			pstmt.setInt(3, eng);
			pstmt.setInt(4, math);
			pstmt.setInt(5, tot);
			pstmt.setDouble(6, avg);
			pstmt.setString(7, id);
			
			//3-3 �غ�� SQL���� ���� ó��
			int cnt = pstmt.executeUpdate();
			
			//4. SQL ���� ����� ���� ó��
			System.out.println("ó���Ǽ�: " + cnt);
			
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
		
		
	}//main end

}//class end
