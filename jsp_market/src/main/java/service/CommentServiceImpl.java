package service;

import java.util.List;

import dao.CommentDAO;
import dto.Comment;
import dto.Comment_room;

public class CommentServiceImpl implements CommentService {

	private CommentDAO indexDAO = new CommentDAO();
	
	@Override
	public int insert(Comment index) {
		int result = indexDAO.insert(index);
		if(result >0) {
			System.out.println("룸 생성 성공!");
		}
		else {
			System.out.println("룸 생성 실패!");
		}
		return 0;
	}

	@Override
	public Comment select(int no) {
		Comment index = indexDAO.select(no);
		return index;
	}

	@Override
	public List<Comment> list() {
		List<Comment> list = indexDAO.list();
		return list;
	}

	@Override
	public List<Comment> list(int index) {
		List<Comment> list = indexDAO.list(index);
		return list;
	}

	@Override
	public boolean update(Comment index) {
		boolean result = indexDAO.update(index);
		return result;
	}

	@Override
	public boolean delete(int no) {
		boolean result = indexDAO.delete(no);
		return result;
	}

}
