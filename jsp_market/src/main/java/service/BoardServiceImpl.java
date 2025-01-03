package service;

import java.util.List;

import dao.BoardDAO;
import dto.Board;

public class BoardServiceImpl implements BoardService {

	private BoardDAO indexDAO = new BoardDAO();

	@Override
	public int insert(Board index) {
		int result = 0;
		try {
			result = indexDAO.insert(index);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Board select(int no) {
		Board board = null;
		try {
			board = indexDAO.select(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return board;
	}

	@Override
	public List<Board> list() {
		List<Board> boardList = null;
		try {
			boardList = indexDAO.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return boardList;
	}

	@Override
	public List<Board> list(int uuid) {
		List<Board> boardList = indexDAO.list(uuid);
		return boardList;
	}

	@Override
	public boolean update(Board index) {
		int result = 0;
		try {
			result = indexDAO.update(index);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	@Override
	public boolean delete(int no) {
		int result = 0;
		try {
			result = indexDAO.delete(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result > 0;
	}

	@Override
	public int lastIndex() {
		int result = 0;
		try {
			result = indexDAO.lastIndex();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}
	
//	@Override
//	public int insert(Board index) {
//		int result = indexDAO.insert(index);
//		if(result >0) {
//			System.out.println("보드생성 성공!");
//		}
//		else {
//			System.out.println("보드생성 실패!");
//		}
//		return 0;
//	}
//
//	@Override
//	public Board select(int no) {
//		Board index = indexDAO.select(no);
//		return index;
//	}
//	
//	@Override
//	public List<Board> list() {
//		List<Board> boardList = indexDAO.list();
//		return boardList;
//	}
//
//	@Override
//	public List<Board> list(int uuid) {
//		List<Board> boardList = indexDAO.list(uuid);
//		return boardList;
//	}
//
//	@Override
//	public boolean update(Board index) {
//		boolean result = indexDAO.update(index);
//		return result;
//	}
//
//	@Override
//	public boolean delete(int uuid) {
//		boolean result = indexDAO.delete(uuid);
//		return result;
//	}	
}
