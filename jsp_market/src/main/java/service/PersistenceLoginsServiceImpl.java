package service;

import java.util.Date;

import dao.PersistenceLoginsDAO;
import dto.PersistenceLogins;

public class PersistenceLoginsServiceImpl implements PersistenceLoginsService {

	private PersistenceLoginsDAO persistenceLoginsDAO = new PersistenceLoginsDAO();
	
	
	@Override
	public PersistenceLogins insert(String username) {
		return persistenceLoginsDAO.insert(username);
	}

	@Override
	public PersistenceLogins select(String token) {
		return persistenceLoginsDAO.select(token);
	}

	@Override
	public PersistenceLogins selectByToken(String token) {
		return persistenceLoginsDAO.selectByToken(token);
		
	}

	@Override
	public PersistenceLogins update(String username) {
		return persistenceLoginsDAO.update(username);
	}

	@Override
	public PersistenceLogins refresh(String username) {
		PersistenceLogins persistenceLogins = persistenceLoginsDAO.select(username);
		
		if(persistenceLogins == null) {
			persistenceLoginsDAO.insert(username);
			persistenceLogins = persistenceLoginsDAO.select(username);
		}
		else {
			// 토큰이 있는 경우, 토큰 수정
			persistenceLogins = persistenceLoginsDAO.update(username);
		}
		return persistenceLogins;
	}

	@Override
	public boolean isValid(String token) {
		PersistenceLogins persistenceLogins = persistenceLoginsDAO.selectByToken(token);
		
		//토큰 없음
		if(persistenceLogins == null)
			return false;
		//토큰 만료
		Date expiryDate = persistenceLogins.getExpiryDate();
		Date today= new Date();
		if(today.after(expiryDate)) {
			return false;
		}
		return true;
		
		
	}

	@Override
	public boolean delete(String username) {
		boolean result = persistenceLoginsDAO.delete(username);
		return result;
	}
	
}
