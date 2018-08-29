package com.mystudy.dao_list;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common_util.JDBC_Close;

//JDBC�� �̿��� DB ���α׷��� ���
//0. JDBC ���̺귯�� ����ȯ�� ����(�����ο� ���)
//1. JDBC ����̹� �ε�
//2. DB����  - Connection ��ü ���� <-DriverManager

//3. Statement�� ����(SQL�� ����)
//4. SQL ���� ����� ���� ó��
// -SELECT : ��ȸ(�˻�) ����Ÿ ��� ���� ���� ó��
// -INSERT, UPDATE, DELETE : int��(�Ǽ�) ó��

//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
			//System.out.println(">> ����Ŭ JDBC ����̹� �ε� ����!!");
		} catch (ClassNotFoundException e) {
			System.out.println("[���ܹ߻�] ����̹� �ε� ����!!!");
		}
	}
	private Connection getConnection() {
		Connection conn = null;
		try {
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
		} catch (SQLException e) {
			System.out.println("[���ܹ߻�] DB���� ����!!!");
		}
		return conn;
	}
	
	@Override
	public void printDataAll() {
		
	}

	//INSERT : VO ��ü�� �޾Ƽ� �Է� - insertOne : int
	public int insertOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL ���� ������ ���� �غ�
			//SQL ���� �ۼ�
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//SQL ������ �����ؼ� ���� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?�� �� ��Ī �۾�
			pstmt.setString(1, member.getId());
			pstmt.setString(2, member.getPassword());
			pstmt.setString(3, member.getName());
			pstmt.setString(4, member.getPhone());
			pstmt.setString(5, member.getAddress());
			
			//SQL�� ����
			result = pstmt.executeUpdate();
			
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			//����� �ڿ� �ݱ�
			JDBC_Close.closeConnStmt(conn, pstmt);
		}
		
		return result;
	}
	public int insertListOne(ArrayList<MemberVO> list) {
		//���ϰ� ����� ���� ����
		int result = 0;
		
		//���޹��� list�� �ִ� VO���� �����ؼ� insertOne(VO) �޼ҵ� ȣ��� ����
		for (MemberVO member : list) {
			//result = result + insertOne(member);
			result += insertOne(member);
		}
		
		return result;
	}
	
	@Override
	public int insertList(ArrayList<MemberVO> list) {
		//���ϰ� ������ ���� ���� ����
		int result = 0;
		//2. DB����  - Connection ��ü ���� <-DriverManager
		conn = getConnection();
		if (conn == null) {
			return -1;
		}

		try {
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//3. Statement�� ����(SQL�� ����)
			//SQL�� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?��ġ�� �� ����
			for (MemberVO member : list) {
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPassword());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getAddress());
				//SQL�� ����
				result += pstmt.executeUpdate();
			}
			
			//4. SQL ���� ����� ���� ó��-INSERT, UPDATE, DELETE : int��(�Ǽ�) ó��
		} catch (SQLException e) {
			e.printStackTrace();
		} finally {
			JDBC_Close.closeConnStmt(conn, pstmt);
		}

		//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
		
		
		return result;
	}
	
	//��ü �Է�ó�� �Ǵ� ���ܹ߻��� ��ü ����Ÿ �Է���� ó���ǵ��� ����
	//�⺻ AutoCommit = true ����
	public int insertListCommit(ArrayList<MemberVO> list) {
		//���ϰ� ������ ���� ���� ����
		int result = 0;
		//2. DB����  - Connection ��ü ���� <-DriverManager
		conn = getConnection();
		if (conn == null) {
			return -1;
		}

		try {
			//AutoCommit ���� �� Ȯ��
			System.out.println("AutoCommit����Ȯ��: " 
					+ conn.getAutoCommit());
			
			//AutoCommit ���� false ����
			conn.setAutoCommit(false); 
			System.out.println("AutoCommit ��������: " 
					+ conn.getAutoCommit());
			
			StringBuilder sb = new StringBuilder();
			sb.append("INSERT INTO MEMBER ");
			sb.append("       (ID, PASSWORD, NAME, PHONE, ADDRESS) ");
			sb.append("VALUES (?, ?, ?, ?, ?) ");
			//3. Statement�� ����(SQL�� ����)
			//SQL�� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?��ġ�� �� ����
			for (MemberVO member : list) {
				pstmt.setString(1, member.getId());
				pstmt.setString(2, member.getPassword());
				pstmt.setString(3, member.getName());
				pstmt.setString(4, member.getPhone());
				pstmt.setString(5, member.getAddress());
				//SQL�� ����
				result += pstmt.executeUpdate();
			}
			
			//��� ����Ÿ�� ���� ó���� ���������� ����� ����
			conn.commit(); //��� SQL ���๮�� ���Ͽ� Ȯ�� ó��(DB�� �ݿ�)
			conn.setAutoCommit(true);
			
		} catch (SQLException e) {
			try {
				//SQL�� ����ó���� ��� �۾��� ���Ͽ� ��� ó��(DB �ݿ� ����)
				conn.rollback();
				conn.setAutoCommit(true);
				result = -1;
			} catch (SQLException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		} finally {
			//5. Ŭ��¡ ó���� ���� �ڿ� �ݳ�
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
			conn.setAutoCommit(false); //AutoCommit ����
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL�� ? ��ġ�� �� ����
			for (int i = 0; i < list.size(); i++) {
				MemberVO member = list.get(i);
				int idx = 1;
				pstmt.setString(idx++, member.getPassword());
				pstmt.setString(idx++, member.getName());
				pstmt.setString(idx++, member.getPhone());
				pstmt.setString(idx++, member.getAddress());
				pstmt.setString(idx++, member.getId());
				
				//SQL�� ����
				result += pstmt.executeUpdate();
			}
			conn.commit(); //��ü SQL ���� ��� DB�� �ݿ�
			conn.setAutoCommit(true); //AutoCommit ����
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
			conn.setAutoCommit(false); //AutoCommit ����
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL�� ? ��ġ�� �� ����
			for (MemberVO mvo : list) {
				pstmt.setString(1, mvo.getId());
				
				//SQL�� ����
				result += pstmt.executeUpdate();
			}
			conn.commit(); //��ü SQL ���� ��� DB�� �ݿ�
			conn.setAutoCommit(true); //AutoCommit ����
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
			conn.setAutoCommit(false); //AutoCommit ����
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL�� ? ��ġ�� �� ����
			for (String id : list) {
				pstmt.setString(1, id);
				
				//SQL�� ����
				result += pstmt.executeUpdate();
			}
			conn.commit(); //��ü SQL ���� ��� DB�� �ݿ�
			conn.setAutoCommit(true); //AutoCommit ����
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
