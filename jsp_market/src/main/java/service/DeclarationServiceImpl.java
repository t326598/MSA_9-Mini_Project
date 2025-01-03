package service;

import java.util.List;

import dao.DeclarationDAO;
import dto.Board;
import dto.Declaration;

public class DeclarationServiceImpl implements DeclarationService {

	private DeclarationDAO indexDAO = new DeclarationDAO();
	
	@Override	
	public int insert(Declaration index) {
		int result = 0;
		try {
			result = indexDAO.insert(index);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Declaration select(int no) {
		Declaration dec = null;
		try {
			dec = indexDAO.select(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dec;
	}

	@Override
	public List<Declaration> list() {
		List<Declaration> List = null;
		try {
			List = indexDAO.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return List;
	}

	@Override
	public boolean update(Declaration index) {
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
	
	
}
