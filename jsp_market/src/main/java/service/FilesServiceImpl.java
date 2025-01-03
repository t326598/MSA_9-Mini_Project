package service;

import java.util.List;

import dao.FilesDAO;
import dto.Declaration;
import dto.Files;

public class FilesServiceImpl implements FilesService {

	private FilesDAO indexDAO = new FilesDAO();
	
	@Override
	public int insert(Files index) {
		int result = 0;
		try {
			result = indexDAO.insert(index);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return result;
	}

	@Override
	public Files select(int no) {
		Files dec = null;
		try {
			dec = indexDAO.select(no);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dec;
	}

	@Override
	public Files select(int table_no, String table_name) {
		Files dec = null;
		try {
			dec = indexDAO.select(table_no,table_name);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dec;
	}


	
	
	//파일 전체 조회
	@Override
	public List<Files> list() {
		List<Files> List = null;
		try {
			List = indexDAO.list();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return List;
	}

	//파일 조회 (이벤트 코드)
	//  -- 0:메인이미지 1:이벤트 2:프로필 3:보드
	@Override
	public List<Files> list(int code) {
		List<Files> List = null;
		try {
			List = indexDAO.list(code);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return List;
	}

	@Override
	public boolean update(Files index) {
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
