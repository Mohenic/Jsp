package kr.co.farmstory2.service;

import kr.co.farmstory2.dao.FileDAO;
import kr.co.farmstory2.dto.FileDTO;

public enum FileService {
	
	instance;
	
	private FileDAO dao = new FileDAO();
	
	public void insertFile(FileDTO dto) {
		dao.insertFile(dto);
	}
	
	public FileDTO selectFile(String fno) {
		return dao.selectFile(fno);
	}
	
	public void updateCountFilePlus(String no) {
		dao.updateCountFilePlus(no);
	}
	
	public void updateCountFileMinus(String no) {
		dao.updateCountFileMinus(no);
	}
}
