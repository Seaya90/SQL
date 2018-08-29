package com.mystudy.dao_list;

import java.util.ArrayList;

public interface MemberListCUD {
	String DRIVER = "oracle.jdbc.OracleDriver"; 
	String URL = "jdbc:oracle:thin:@localhost:1521:xe"; 
	String USER = "mystudy"; 
	String PASSWORD = "mystudypw"; 
	
	//Member 테이블에 있는 데이타를 화면 출력
	void printDataAll();

	//회원목록을 받아서 일괄 입력 처리
	int insertList(ArrayList<MemberVO> list);

	//리스트를 받아서 일괄 수정작업 처리
	int updateList(ArrayList<MemberVO> list);

	//리스트를 받아서 일괄 삭제작업 처리
	int deleteList(ArrayList<MemberVO> list);

}
