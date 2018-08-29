package com.mystudy.jdbc_dao_impl;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import common_util.JDBC_Close;

//DAO / Dao : Data Access Object / Database Access Object
//����Ÿ���̽��� �����ؼ� CRUD�� �����ϴ� Ŭ����
public class MemberDAO {
	private static final String DRIVER = "oracle.jdbc.OracleDriver"; 
	private static final String URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	private static final String USER = "mystudy"; 
	private static final String PASSWORD = "mystudypw"; 
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	//static �ʱ�ȭ ����
	static {
		try {
			Class.forName(DRIVER);
			System.out.println(">> ����Ŭ JDBC ����̹� �ε� ����!!");
		} catch (ClassNotFoundException e) {
			System.out.println("[���ܹ߻�] ����̹� �ε� ����!!!");
		}
	}
	
	/*
	//SELECT : ���̺� �ִ� ����Ÿ ��ü ��ȸ -selectAll : ArrayList<MemberVO>
	//SELECT : �ϳ��� ����Ÿ ��ȸ(ID) - selectOne : MemberVO
	//SELECT : �ϳ��� ����Ÿ ��ȸ(VO) - selectOne : MemberVO
	//INSERT : VO ��ü�� �޾Ƽ� �Է� - insertOne : int
	//UPDATE : VO ��ü�� �޾Ƽ� ���� - updateOne : int
	//DELETE : VO ��ü�� �޾Ƽ� ���� - deleteOne : int
	//DELETE : Ű��(ID)�� ���޹޾� ���� - deleteOne : int 
	//�α��� ó�� : ID, PASSWORD ���� �޾Ƽ� ������ ����Ÿ ������ true, ������ false ����
	//     boolean checkIdPassword(id, password) 
	*/
	
	//SELECT : ���̺� �ִ� ����Ÿ ��ü ��ȸ -selectAll : ArrayList<MemberVO>
	public ArrayList<MemberVO> selectAll() {
		ArrayList<MemberVO> list = null;
		
		try {
			//DB���� - Connection ��ü ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID, PASSWORD, NAME, PHONE, ADDRESS ");
			sb.append("  FROM MEMBER ");
			sb.append(" ORDER BY ID ");
			
			//Connection ��ü�� ���� PreparedStatement ��ü ����
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ����
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
			//����Ÿ�� 1�ǵ� ���� ��� list�� null�� �ʱ�ȭ
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
	
	//SELECT : �ϳ��� ����Ÿ ��ȸ(ID) - selectOne : MemberVO
	public MemberVO selectOne(String id) {
		MemberVO mvo = null;
		try {
			//DB���� - Connection ��ü ����
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
	
	//SELECT : �ϳ��� ����Ÿ ��ȸ(VO) - selectOne : MemberVO
	public MemberVO selectOne(MemberVO member) {
		MemberVO mvo = null;
		try {
			//DB���� - Connection ��ü ����
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
			//DB���� - Connection ��ü ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID, PASSWORD, NAME, PHONE, ADDRESS ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE NAME = ? ");
			
			//Connection ��ü�� ���� PreparedStatement ��ü ����
			pstmt = conn.prepareStatement(sb.toString());
			
			pstmt.setString(1, name);
			//SQL���� ����
			rs = pstmt.executeQuery(); //SELECT : executeQuery()
			
			list = new ArrayList<>();
			while (rs.next()) {
				list.add(new MemberVO(rs.getString("id"), 
						rs.getString("password"), 
						rs.getString("name"), 
						rs.getString("phone"), 
						rs.getString("address")));
			}
			//����Ÿ�� 1�ǵ� ���� ��� list�� null�� �ʱ�ȭ
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
	
	//UPDATE : VO ��ü�� �޾Ƽ� ���� - updateOne : int
	public int updateOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL ���� ������ ���� �غ�
			//SQL ���� �ۼ�
			StringBuilder sb = new StringBuilder();
			sb.append("UPDATE MEMBER ");
			sb.append("   SET PASSWORD = ? ");
			sb.append("     , NAME = ? ");
			sb.append("     , PHONE = ? ");
			sb.append("     , ADDRESS = ? ");
			sb.append(" WHERE ID = ?");
			//SQL ������ �����ؼ� ���� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?�� �� ��Ī �۾�
			pstmt.setString(1, member.getPassword());
			pstmt.setString(2, member.getName());
			pstmt.setString(3, member.getPhone());
			pstmt.setString(4, member.getAddress());
			pstmt.setString(5, member.getId());
			
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
	
	//DELETE : VO ��ü�� �޾Ƽ� ���� - deleteOne : int
	public int deleteOne(MemberVO member) {
		int result = 0;
		
		try {
			//DB ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL ���� ������ ���� �غ�
			//SQL ���� �ۼ�
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			
			//SQL ������ �����ؼ� ���� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?�� �� ��Ī �۾�
			pstmt.setString(1, member.getId());
			
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
	
	//DELETE : ID �޾Ƽ� ���� - deleteOne : int
	public int deleteOne(String id) {
		int result = 0;
		
		try {
			//DB ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			//SQL ���� ������ ���� �غ�
			//SQL ���� �ۼ�
			StringBuilder sb = new StringBuilder();
			sb.append("DELETE FROM MEMBER WHERE ID = ?");
			
			//SQL ������ �����ؼ� ���� �غ�
			pstmt = conn.prepareStatement(sb.toString());
			
			//SQL���� ?�� �� ��Ī �۾�
			pstmt.setString(1, id);
			
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
	
	//�α��� ó�� : ID, PASSWORD ���� �޾Ƽ� ������ ����Ÿ ������ true, ������ false ����
	//boolean checkIdPassword(id, password)
	public boolean checkIdPassword(String id, String password) {
		boolean result = false;
		try {
			//DB���� - Connection ��ü ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT ID  ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE ID = ? AND PASSWORD = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			if (rs.next()) { //�ּ� 1 �� �̻��� ����Ÿ�� ����
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
			//DB���� - Connection ��ü ����
			conn = DriverManager.getConnection(URL, USER, PASSWORD);
			
			StringBuilder sb = new StringBuilder();
			sb.append("SELECT COUNT(*) AS CNT ");
			sb.append("  FROM MEMBER ");
			sb.append(" WHERE ID = ? AND PASSWORD = ?");
			pstmt = conn.prepareStatement(sb.toString());
			pstmt.setString(1, id);
			pstmt.setString(2, password);
			
			rs = pstmt.executeQuery();
			if (rs.next()) { //COUNT(*) ���� ������ ���� 0~n
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
