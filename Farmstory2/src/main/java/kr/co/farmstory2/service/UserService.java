package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.UserDAO;
import kr.co.farmstory2.dto.UserDTO;

public enum UserService {

	instance;
	
	private UserDAO dao = new UserDAO();
	
	public void insertUser(UserDTO dto) {
		dao.insertUser(dto);
	}
	
	public UserDTO selectUser(String uid, String pass) {
		return dao.selectUser(uid, pass);
	}
	
	public List<UserDTO> selectUsers(int start){
		return dao.selectUsers(start);
	}
	
	public int selectCountUsers() {
		return dao.selectCountUsers();
	}
	
	public int selectCountUid(String uid) {
		return dao.selectCountUid(uid);
	}
	
	public int selectCountNick(String nick) {
		return dao.selectCountNick(nick);
	}
	
	public int selectCountEmail(String email) {
		return dao.selectCountEmail(email);
	}
	
	public int selectCountHp(String hp) {
		return dao.selectCountUid(hp);
	}
}
