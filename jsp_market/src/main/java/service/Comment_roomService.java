package service;

import java.util.List;

import dto.Comment_room;

public interface Comment_roomService {

	//채널 생성
	public int insert(Comment_room index);
	
	//채널 선택
	public Comment_room select(int no);
	
	//채널 선택
	public Comment_room selectBoardNo(int no);
	
	//채널 전체 조회
	public List<Comment_room> list();
	
	//채널 조회 (아이디)
	public List<Comment_room> list(int index);
	
	//채널 업데이트
	public boolean update(Comment_room index);
	
	//채널 삭제
	public boolean delete(int no);
	
	
}
