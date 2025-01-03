package service;

import java.util.List;

import dto.Declaration;

public interface DeclarationService {
	
	//신고글 생성
	public int insert(Declaration index);
	
	//신고글 선택
	public Declaration select(int no);
	
	//신고글 전체 조회
	public List<Declaration> list();
	
	//파일 업데이트
	public boolean update(Declaration index);
	
	//파일 삭제
	public boolean delete(int no);
}
