package service;

import java.util.List;

import dto.Board;

public interface BoardService {

	//보드 생성
	public int insert(Board index);
	
	//보드 선택
	public Board select(int no);
	
	//마지막 보드선택
	public int lastIndex();
	
	//보드 전체 조회
	public List<Board> list();
	
	//보드 조회 (아이디)
	public List<Board> list(int uuid);
	
	//보드 업데이트
	public boolean update(Board index);
	
	//보드 삭제
	public boolean delete(int no);
	
	
	
}
