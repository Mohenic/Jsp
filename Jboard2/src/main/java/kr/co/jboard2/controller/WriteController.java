package kr.co.jboard2.controller;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import kr.co.jboard2.dto.ArticleDTO;
import kr.co.jboard2.dto.FileDTO;
import kr.co.jboard2.service.ArticleService;
import kr.co.jboard2.service.FileService;

@WebServlet("/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 992090960044622875L;
	
	private ArticleService aService = ArticleService.INSTANCE;
	private FileService fService = FileService.INSTANCE;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/write.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 파일 업로드 경로 구하기 
		ServletContext ctx = req.getServletContext();
		String path = ctx.getRealPath("/upload");
		
		// 최대 업로드 파일 크기
		int maxSize = 1024 * 1024 * 10;
		
		// 파일 업로드 및 Multipart 객체 생성
		MultipartRequest mr = new MultipartRequest(req, path, maxSize, "UTF-8", new DefaultFileRenamePolicy());
		
		// 폼 데이터 수신
		String title   = mr.getParameter("title");
		String content = mr.getParameter("content");
		String writer  = mr.getParameter("writer");
		String oName   = mr.getOriginalFileName("file");		
		String regip   = req.getRemoteAddr();
		
		// DTO 생성
		ArticleDTO dto = new ArticleDTO();
		dto.setTitle(title);
		dto.setContent(content);
		dto.setFile(oName);
		dto.setWriter(writer);
		dto.setRegip(regip);

		// 글 Insert
		int no = aService.insertArticle(dto);
		
		// 파일명 수정 및 파일 Insert
		if(oName != null) {
			
			int i = oName.lastIndexOf(".");
			String ext = oName.substring(i);
			
			String uuid  = UUID.randomUUID().toString();
			String sName = uuid + ext;
			
			File f1 = new File(path+"/"+oName);
			File f2 = new File(path+"/"+sName);
			
			// 파일명 수정
			f1.renameTo(f2);
			
			// 파일 테이블 Insert
			FileDTO fileDto = new FileDTO();
			fileDto.setAno(no);
			fileDto.setOfile(oName);
			fileDto.setSfile(sName);
			
			fService.insertFile(fileDto);
		}
		
		// 리다이렉트
		resp.sendRedirect("/Jboard2/list.do");
	}
}
