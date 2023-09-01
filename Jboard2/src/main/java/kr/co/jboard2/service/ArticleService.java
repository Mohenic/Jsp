package kr.co.jboard2.service;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dao.ArticleDAO;
import kr.co.jboard2.db.SQL;
import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.dto.FileDTO;

public enum ArticleService {
	
	INSTANCE;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass()); 
	private ArticleDAO dao = new ArticleDAO();
	
	public int insertArticle(ArticleDTO dto) {
		return dao.insertArticle(dto);
	}
	
	public ArticleDTO selectArticle(String no) {
		return dao.selectArticle(no);
	}
	
	public List<ArticleDTO> selectArticles(int start) {
		return dao.selectArticles(start);
	}
	
	public void updateArticle(ArticleDTO dto) {
		dao.updateArticle(dto);
	}
	
	public void deleteArticle(String no) {
		dao.deleteArticle(no);
	}

	// 추가 
	public int selectCountTotal() {
		return dao.selectCountTotal();
	}
	
	public List<ArticleDTO> selectComments(String parent) {
		return dao.selectComments(parent);
	}
	
	public void insertComment(ArticleDTO dto) {
		dao.insertComment(dto);
	}
	
	public void updateArticleForCommentPlus(String no) {
		dao.updateArticleForCommentPlus(no);
	}
	
	public void updateArticleForCommentMinus(String no) {
		dao.updateArticleForCommentMinus(no);
	}

	public void updateComment(String no, String content) {
		dao.updateComment(no, content);
	}
	
	public void deleteComment(String no) {
		dao.deleteComment(no);
	}
	
	// 업로드 경로 구하기
	public String getFilePath(HttpServletRequest req) {
		// 파일 업로드 경로 구하기 
		ServletContext ctx = req.getServletContext();
		String path = ctx.getRealPath("/upload");
		return path;
	}
	
	// 파일명 수정
	public String renameToFile(HttpServletRequest req, String oName) {
		
		String path = getFilePath(req);
		
		int i = oName.lastIndexOf(".");
		String ext = oName.substring(i);
		
		String uuid  = UUID.randomUUID().toString();
		String sName = uuid + ext;
		
		File f1 = new File(path+"/"+oName);
		File f2 = new File(path+"/"+sName);
		
		f1.renameTo(f2);
		
		return sName;
	}
	
	
	// 파일 업로드
	public MultipartRequest uploadFile(HttpServletRequest req) {
		// 파일 경로 구하기
		String path = getFilePath(req);
		
		// 최대 업로드 파일 크기
		int maxSize = 1024 * 1024 * 10;
		
		// 파일 업로드 및 Multipart 객체 생성
		MultipartRequest mr = null;
		
		try {
			mr = new MultipartRequest(req, 
									  path, 
									  maxSize, 
									  "UTF-8", 
									  new DefaultFileRenamePolicy());
		} catch (IOException e) {
			logger.error("uploadFile : " + e.getMessage());
		}
		
		return mr;
	}
	
	// 파일 다운로드
	public void downloadFile(HttpServletRequest req, HttpServletResponse resp, FileDTO dto) throws IOException {
		// response 파일 다운로드 헤더 수정
		resp.setContentType("application/octet-stream");
		resp.setHeader("Content-Disposition", "attachment; filename="+URLEncoder.encode(dto.getOfile(), "utf-8"));
		resp.setHeader("Content-Transfer-Encoding", "binary");
		resp.setHeader("Pragma", "no-cache");
		resp.setHeader("Cache-Control", "private");
		
		// response 파일 스트림 작업
		String path = getFilePath(req);
		
		File file = new File(path+"/"+dto.getSfile());
		
		BufferedInputStream bis = new BufferedInputStream(new FileInputStream(file));
		BufferedOutputStream bos = new BufferedOutputStream(resp.getOutputStream());
				
		while(true){
			
			int data = bis.read();
			if(data == -1){
				break;
			}
			
			bos.write(data);
		}
		
		bos.close();
		bis.close();
	}
	
	// 페이지 마지막 번호
	public int getLastPageNum(int total) {
		
		int lastPageNum = 0;
		
		if(total % 10 == 0){
			lastPageNum = total / 10;
		}else{
			lastPageNum = total / 10 + 1;
		}
		
		return lastPageNum;
	}
	
	// 페이지 그룹
	public int[] getPageGroupNum(int currentPage, int lastPageNum) {
		int currentPageGroup = (int)Math.ceil(currentPage / 10.0);
		int pageGroupStart = (currentPageGroup - 1) * 10 + 1;
		int pageGroupEnd = currentPageGroup * 10;
		
		if(pageGroupEnd > lastPageNum){
			pageGroupEnd = lastPageNum;
		}
		
		int[] result = {pageGroupStart, pageGroupEnd};
		
		return result;
	}
	
	// 페이지 시작번호
	public int getPageStartNum(int total, int currentPage) {
		int start = (currentPage - 1) * 10;
		return total - start;
	}
	
	// 현재 페이지 번호
	public int getCurrentPage(String pg) {
		int currentPage = 1;
		
		if(pg != null){
			currentPage = Integer.parseInt(pg);	
		}
		
		return currentPage;
	}
	
	// Limit 시작번호
	public int getStartNum(int currentPage) {
		return (currentPage - 1) * 10;
	}
	
	
}
