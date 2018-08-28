package com.mystudy.ojdbc_CRUD;

import java.util.ArrayList;

public class StudentCRUDTest {

	public static void main(String[] args) {
		StudentCRUD crud = new StudentCRUD();
		crud.dispData("2018001");
		StudentVO vo = crud.selectId("2018002");
		System.out.println("2018002 데이타 - " + vo);
		
		System.out.println("------------------");
		//존재하지 않는 데이타 조회
		vo = crud.selectId("2018111");
		if (vo == null) {
			System.out.println("2018111 데이타 없음");
		} else {
			System.out.println("2018111 데이타 - " + vo);
		}
		
		//전체데이타 조회
		ArrayList<StudentVO> list = crud.selectAll();
		System.out.println("--- 전체데이타 조회 결과 ---");
		for (StudentVO stu : list) {
			crud.dispData(stu.getId());
		}
		
		System.out.println("---- 입력 테스트 -----");
		//데이타 입력 테스트
		crud.insertData("2018010", "홍길동10", 100, 90, 80, 0, 0);
		crud.dispData("2018010");
		//crud.insertData(new StudentVO("2018011", "홍길동11", 100, 90, 81));
		crud.insertData(new StudentVO("2018012", "홍길동12", 100, 90, 81,0,0));
		
		System.out.println("--- 수정처리 테스트 ---");
		StudentVO updVO = new StudentVO("2018012", "홍길동-12", 95, 85, 81);
		crud.updateData(updVO);
		crud.dispData("2018012");
		
		System.out.println("--- 삭제처리 테스트 ---");
		crud.deleteData("2018010");
		crud.dispData("2018010");
		
		
	}

}
