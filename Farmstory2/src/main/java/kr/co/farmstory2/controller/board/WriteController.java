package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.oreilly.servlet.MultipartRequest;

import kr.co.farmstory2.dto.ArticleDTO;
import kr.co.farmstory2.dto.FileDTO;
import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.service.FileService;

@WebServlet("/board/write.do")
public class WriteController extends HttpServlet {
	private static final long serialVersionUID = 4770924791750877308L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService aService = ArticleService.instance;
	private FileService fService = FileService.instance;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/write.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		MultipartRequest mr = aService.uploadFile(req);
		
		String group = mr.getParameter("group");
		String cate = mr.getParameter("cate");
		String title = mr.getParameter("title");
		String content = mr.getParameter("content");
		String writer = mr.getParameter("writer");
		String oName = mr.getOriginalFileName("file");
		String regip = req.getRemoteAddr();
		
		logger.debug("title : " + title);
		logger.debug("content : " + content);
		logger.debug("writer : " + writer);
		logger.debug("oName : " + oName);
		logger.debug("regip : " + regip);
		
		ArticleDTO dto = new ArticleDTO();
		dto.setCate(cate);
		dto.setTitle(title);
		dto.setContent(content);
		dto.setFile(oName);
		dto.setWriter(writer);
		dto.setRegip(regip);
		
		int no = aService.insertArticle(dto);
		
		if(oName != null) {
			String sName = aService.renameToFile(req, oName);
			
			FileDTO filedto = new FileDTO();
			filedto.setAno(no);
			filedto.setOfile(oName);
			filedto.setSfile(sName);
			
			fService.insertFile(filedto);
			
		}
		
		resp.sendRedirect("/Farmstory2/board/list.do?group="+group+"&cate="+cate);
		
	}
}
