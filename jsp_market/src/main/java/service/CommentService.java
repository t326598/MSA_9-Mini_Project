package service;

import java.util.List;

import dto.Comment;

public interface CommentService {
	
	//댓글 생성
	public int insert(Comment index);
	
	//댓글 선택
	public Comment select(int no);
	
	//댓글 전체 조회
	public List<Comment> list();
	
	//댓글 조회 (룸 번호)
	public List<Comment> list(int index);
	
	//댓글 업데이트
	public boolean update(Comment index);
	
	//댓글 삭제
	public boolean delete(int no);
}
