package service;

import java.util.List;

import dao.Comment_roomDAO;
import dto.Comment_room;

public class Comment_roomServiceImpl implements Comment_roomService {

	private Comment_roomDAO indexDAO = new Comment_roomDAO();
	
	@Override
	public int insert(Comment_room index) {
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
	public Comment_room select(int no) {
		Comment_room index = indexDAO.select(no);
		return index;
	}

	@Override
	public List<Comment_room> list() {
		List<Comment_room> list = indexDAO.list();
		return list;
	}

	@Override
	public List<Comment_room> list(int index) {
		List<Comment_room> list = indexDAO.list(index);
		return list;
	}

	@Override
	public boolean update(Comment_room index) {
		boolean result = indexDAO.update(index);
		return result;
	}

	@Override
	public boolean delete(int no) {
		boolean result = indexDAO.delete(no);
		return result;
	}

	@Override
	public Comment_room selectBoardNo(int no) {
		Comment_room result = null;
		try {
			result = indexDAO.select_boardNo(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
}
