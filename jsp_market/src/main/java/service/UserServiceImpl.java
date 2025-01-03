package service;

import dao.UserDAO;
import dto.User;
import utils.PasswordUtils;

public class UserServiceImpl implements UserService{
	
	private UserDAO userDAO = new UserDAO();
	
	@Override
	public int signup(User user) {
		// 비밀번호 암호화
		// * 암호화 알고리즘 : SHA-256, Bcrypt ...
		// 123456 ---> FI2IOF2JF89F/@FJASJ
		String encodedPassword = PasswordUtils.encoded(user.getPasswd());
		user.setPasswd(encodedPassword);
		
		int result = userDAO.insert(user);
		if(result >0) {
			System.out.println("회원가입 성공!");
		}
		else {
			System.out.println("회원가입 실패!");
		}
		
		//회원 기본 권한 등록...
		return result;
	}

	@Override
	public User login(User user) {
		String username = user.getId();
		User selectedUser = userDAO.select(username);
		
		// 회원 가입이 안 된 아이디
		if(selectedUser == null) {
			return null;
		}
		
		// 비밀번호 일치 여부 확인
		String password = selectedUser.getPasswd();
		String loginPassword = user.getPasswd();
		
		// * BCrypt.checkpw(로그인 비밀번호, 회원가입된 암호화된 비밀번호);
		boolean check = PasswordUtils.check(loginPassword, password);
		
		//비밀번호 불일치
		if(!check) {
			return null;
		}
		//로그인 성공
		return selectedUser;
	}

	@Override
	public User select(int no) {
		// TODO Auto-generated method stub
		User user = userDAO.select(no);
		return user;
	}

	@Override
	public User select(String id) {
		User user = userDAO.select(id);
		return user;
	}

	@Override
	public boolean update(User user) {
		boolean result = userDAO.update(user);
		return result;
	}

	@Override
	public boolean delete(int uuid) {
		boolean result = userDAO.delete(uuid);
		return result;
	}


}
