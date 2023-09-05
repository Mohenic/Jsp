package kr.co.farmstory2.service;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.dto.UserDTO;

public class UserService {

	private UserDAO dao = new UserDAO();
	
	public void insertUser(UserDTO dto) {
		dao.insertUser(dto);
	}
	
	public UserDTO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	
	public int selectCountUid(String uid) {
		return dao.selectCountUid(uid);
	}
	
	public int selectCountNick(String nick) {
		return dao.selectCountUid(nick);
	}
	
	public int selectCountEmail(String email) {
		return dao.selectCountUid(email);
	}
	
	public int selectCountHp(String hp) {
		return dao.selectCountUid(hp);
	}
}
