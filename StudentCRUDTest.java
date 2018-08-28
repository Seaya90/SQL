package com.mystudy.ojdbc_CRUD;

import java.util.ArrayList;

public class StudentCRUDTest {

	public static void main(String[] args) {
		StudentCRUD crud = new StudentCRUD();
		crud.dispData("2018001");
		StudentVO vo = crud.selectId("2018002");
		System.out.println("2018002 ����Ÿ - " + vo);
		
		System.out.println("------------------");
		//�������� �ʴ� ����Ÿ ��ȸ
		vo = crud.selectId("2018111");
		if (vo == null) {
			System.out.println("2018111 ����Ÿ ����");
		} else {
			System.out.println("2018111 ����Ÿ - " + vo);
		}
		
		//��ü����Ÿ ��ȸ
		ArrayList<StudentVO> list = crud.selectAll();
		System.out.println("--- ��ü����Ÿ ��ȸ ��� ---");
		for (StudentVO stu : list) {
			crud.dispData(stu.getId());
		}
		
		System.out.println("---- �Է� �׽�Ʈ -----");
		//����Ÿ �Է� �׽�Ʈ
		crud.insertData("2018010", "ȫ�浿10", 100, 90, 80, 0, 0);
		crud.dispData("2018010");
		//crud.insertData(new StudentVO("2018011", "ȫ�浿11", 100, 90, 81));
		crud.insertData(new StudentVO("2018012", "ȫ�浿12", 100, 90, 81,0,0));
		
		System.out.println("--- ����ó�� �׽�Ʈ ---");
		StudentVO updVO = new StudentVO("2018012", "ȫ�浿-12", 95, 85, 81);
		crud.updateData(updVO);
		crud.dispData("2018012");
		
		System.out.println("--- ����ó�� �׽�Ʈ ---");
		crud.deleteData("2018010");
		crud.dispData("2018010");
		
		
	}

}
