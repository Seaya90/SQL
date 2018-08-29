package com.mystudy.jdbc_dao_impl;

import java.util.ArrayList;

public interface Member {
	ArrayList<MemberVO> selectAll();
	
	MemberVO selectOne(String id);
	MemberVO selectOne(MemberVO member);
	ArrayList<MemberVO> selectName(String name); 
	
	int insertOne(MemberVO member);
	int updateOne(MemberVO member);
	int deleteOne(MemberVO member);
	int deleteOne(String id);
}
