package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.farmstory2.dto.ArticleDTO;
import kr.co.farmstory2.service.ArticleService;

@WebServlet("/comment.do")
public class CommentController extends HttpServlet {
	private static final long serialVersionUID = 3096232538471515350L;

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.instance;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String kind = req.getParameter("kind");
		String no = req.getParameter("no");
		
		int result = 0;
		
		switch(kind) {
			case "DEL":
				result = service.deleteComment(no);
				break;
		}
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		resp.getWriter().print(json);
		
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String parent = req.getParameter("parent");
		String content = req.getParameter("content");
		String writer = req.getParameter("writer");
		String regip = req.getRemoteAddr();
		
		logger.debug("parent : " + parent);
		logger.debug("content: " + content);
		logger.debug("writer : " + writer);
		logger.debug("regip : " + regip);
		
		ArticleDTO dto = new ArticleDTO();
		dto.setParent(parent);
		dto.setContent(content);
		dto.setWriter(writer);
		dto.setRegip(regip);
		
		int result = service.insertComment(dto);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		resp.getWriter().print(json);
		
	}
}
