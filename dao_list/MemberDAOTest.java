package com.mystudy.dao_list;

import java.util.ArrayList;


public class MemberDAOTest {

	public static void main(String[] args) {
		MemberDAO dao = new MemberDAO();
		int cnt = 0;
		ArrayList<MemberVO> list = new ArrayList<>();
//		System.out.println("--- insertListOne() ---"); 
//		list.add(new MemberVO("4444", "pw4444", "김유신4", "010-2222-1111", "서울"));
//		list.add(new MemberVO("3333", "pw3333", "김유신3", "010-3333-1111", "서울"));
//		list.add(new MemberVO("5555", "pw5555", "김유신5", "010-3333-1111", "서울"));
//		cnt = dao.insertListOne(list);
//		System.out.println("입력건수 : " + cnt);
		
//		System.out.println("--- insertList() 중간에 key중복 ---"); 
//		list.clear();
//		list.add(new MemberVO("6666", "pw", "김유신6", "010-2222-1111", "서울"));
//		list.add(new MemberVO("3333", "pw", "김유신3", "010-3333-1111", "서울"));
//		list.add(new MemberVO("7777", "pw", "김유신7", "010-3333-1111", "서울"));
//		cnt = dao.insertList(list);
//		System.out.println("입력건수: " + cnt);
		
		
		System.out.println("--- insertListCommit() 중간에 key중복 ---"); 
		list.clear();
		list.add(new MemberVO("11111", "pw", "김유신6", "010-2222-1111", "서울"));
		list.add(new MemberVO("11112", "pw", "김유신3", "010-3333-1111", "서울"));
		list.add(new MemberVO("9999", "pw", "김유신7", "010-3333-1111", "서울"));
		cnt = dao.insertListCommit(list);
		System.out.println("입력건수: " + cnt);

	}

}
