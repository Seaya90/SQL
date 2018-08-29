package com.mystudy.jdbc_dao_impl;

import java.util.ArrayList;

public class MemberImpl implements Member {
	MemberDAO dao;
	
	public MemberImpl() {
		this.dao = new MemberDAO();
	}
	
	@Override
	public ArrayList<MemberVO> selectAll() {
		//MemberDAO dao = new MemberDAO();
//		ArrayList<MemberVO> list = dao.selectAll();
//		return list;
		return dao.selectAll();
	}

	@Override
	public MemberVO selectOne(String id) {
		return dao.selectOne(id);
	}

	@Override
	public MemberVO selectOne(MemberVO member) {
		return dao.selectOne(member);
	}

	@Override
	public ArrayList<MemberVO> selectName(String name) {
		//MemberDAO.selectName(name) ±¸Çö
		return dao.selectName(name);
	}

	@Override
	public int insertOne(MemberVO member) {
		return dao.insertOne(member);
	}

	@Override
	public int updateOne(MemberVO member) {
		return dao.updateOne(member);
	}

	@Override
	public int deleteOne(MemberVO member) {
		return dao.deleteOne(member);
	}

	@Override
	public int deleteOne(String id) {
		return dao.deleteOne(id);
	}

}
