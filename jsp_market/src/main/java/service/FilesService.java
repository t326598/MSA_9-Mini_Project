package service;

import java.util.List;

import dto.Files;

public interface FilesService {
	
	//파일 생성
	public int insert(Files index);
	
	//파일 선택
	public Files select(int no);
	
	//파일 선택(이벤트 코드, 테이블 넘버,테이블 이름)
	public Files select(int table_no,String table_name);
	
	//파일 전체 조회
	public List<Files> list();
	
	//파일 조회 (이벤트 코드, )
	//  -- 0:메인이미지 1:이벤트 2:프로필 3:보드
	public List<Files> list(int code);
	
	//파일 업데이트
	public boolean update(Files index);
	
	//파일 삭제
	public boolean delete(int no);
}
