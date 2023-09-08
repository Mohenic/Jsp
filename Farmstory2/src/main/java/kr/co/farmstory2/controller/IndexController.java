package kr.co.farmstory2.controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.dao.ArticleDAO;
import kr.co.farmstory2.dto.ArticleDTO;
import kr.co.farmstory2.service.ArticleService;

@WebServlet(value = {"", "/index.do"})
public class IndexController extends HttpServlet {
	private static final long serialVersionUID = 1L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService aService = ArticleService.instance;
	

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
	 
		ArticleDAO dao = new ArticleDAO();
		
		List<ArticleDTO> latest1 = aService.selectLatests("grow", 5);
		List<ArticleDTO> latest2 = aService.selectLatests("story", 5);
		List<ArticleDTO> latest3 = aService.selectLatests("school", 5);
		
		logger.debug(latest1.toString());
		logger.debug(latest2.toString());
		logger.debug(latest3.toString());
		
		req.setAttribute("latest1", latest1);
		req.setAttribute("latest2", latest2);
		req.setAttribute("latest3", latest3);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/index.jsp");
		dispatcher.forward(req, resp);
	
	}

}
