package kr.co.farmstory2.service;

import kr.co.farmstory2.dao.TermsDAO;
import kr.co.farmstory2.dto.TermsDTO;

public class TermsService {

	private TermsDAO dao = new TermsDAO();
	
	public TermsDTO selectTerms() {
		return dao.selectTerms();
	}
}
