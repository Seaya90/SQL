package com.mystudy.jdbc_dao_impl;

import java.util.ArrayList;

public class MemberImplTest {

	public static void main(String[] args) {
		MemberImpl mi = new MemberImpl();
		/*
		MemberImpl의 메소드가 정상 동작하도록 작성 후 테스트
		*/
		System.out.println("--- selectAll() ---- ");
		ArrayList<MemberVO> list = mi.selectAll();
		for (MemberVO mvo : list) {
			System.out.println(mvo);
		}
		

	}

}
