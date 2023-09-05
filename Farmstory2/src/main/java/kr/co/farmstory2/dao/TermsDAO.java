package kr.co.farmstory2.dao;

import kr.co.farmstory2.db.DBHelper;
import kr.co.farmstory2.db.SQL;
import kr.co.farmstory2.dto.TermsDTO;

public class TermsDAO extends DBHelper {
	
	public TermsDTO selectTerms() {
		
		TermsDTO dto = new TermsDTO();
		
		try {
			
			conn = getConnection();
			stmt = conn.createStatement();
			rs = stmt.executeQuery(SQL.SELECT_TERMS);
			
			if(rs.next()) {
				dto.setTerms(rs.getString(1));
				dto.setPrivacy(rs.getString(2));
			}
			
			close();
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return dto;
	}
	
}
