package kr.farmstory1.dao;

import kr.farmstory1.db.DBHelper;
import kr.farmstory1.db.SQL;
import kr.farmstory1.dto.TermsDTO;
import kr.farmstory1.dto.UserDTO;

public class UserDAO extends DBHelper {
	
	private static UserDAO instance = new UserDAO();
	public static UserDAO getInstance() {
		return instance;
	}
	private UserDAO() {}

	// 기본 CRUD 
	public void insertUser(UserDTO dto) {
		
	}
	public UserDTO selectUser(String uid, String pass) {
		return null;
	}
	
	public void selectUsers() {}
	public void updateUser() {}
	public void deleteUser() {}
	
	// 추가 
	public TermsDTO selectTerms() {
		TermsDTO dto = new TermsDTO();

		try{
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_TERMS);
			
			if(rs.next()){
				dto.setTerms(rs.getString(1));
				dto.setPrivacy(rs.getString(2));
			}
			close();
		}catch(Exception e){
			e.printStackTrace();
		}
		return dto;
	}
	
}
