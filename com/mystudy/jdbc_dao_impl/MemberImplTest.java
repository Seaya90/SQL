package com.mystudy.jdbc_dao_impl;

import java.util.ArrayList;

public class MemberImplTest {

	public static void main(String[] args) {
		MemberImpl mi = new MemberImpl();
		/*
		MemberImpl�� �޼ҵ尡 ���� �����ϵ��� �ۼ� �� �׽�Ʈ
		*/
		System.out.println("--- selectAll() ---- ");
		ArrayList<MemberVO> list = mi.selectAll();
		for (MemberVO mvo : list) {
			System.out.println(mvo);
		}
		

	}

}
