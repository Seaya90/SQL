package com.mystudy.dao_list;

import java.util.ArrayList;


public class MemberDAOTest {

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		int cnt = 0;
		ArrayList<MemberVO> list = new ArrayList<>();
//		System.out.println("--- insertListOne() ---"); 
//		list.add(new MemberVO("4444", "pw4444", "������4", "010-2222-1111", "����"));
//		list.add(new MemberVO("3333", "pw3333", "������3", "010-3333-1111", "����"));
//		list.add(new MemberVO("5555", "pw5555", "������5", "010-3333-1111", "����"));
//		cnt = dao.insertListOne(list);
//		System.out.println("�Է°Ǽ� : " + cnt);
		
//		System.out.println("--- insertList() �߰��� key�ߺ� ---"); 
//		list.clear();
//		list.add(new MemberVO("6666", "pw", "������6", "010-2222-1111", "����"));
//		list.add(new MemberVO("3333", "pw", "������3", "010-3333-1111", "����"));
//		list.add(new MemberVO("7777", "pw", "������7", "010-3333-1111", "����"));
//		cnt = dao.insertList(list);
//		System.out.println("�Է°Ǽ�: " + cnt);
		
		
		System.out.println("--- insertListCommit() �߰��� key�ߺ� ---"); 
		list.clear();
		list.add(new MemberVO("11111", "pw", "������6", "010-2222-1111", "����"));
		list.add(new MemberVO("11112", "pw", "������3", "010-3333-1111", "����"));
		list.add(new MemberVO("9999", "pw", "������7", "010-3333-1111", "����"));
		cnt = dao.insertListCommit(list);
		System.out.println("�Է°Ǽ�: " + cnt);

	}

}
