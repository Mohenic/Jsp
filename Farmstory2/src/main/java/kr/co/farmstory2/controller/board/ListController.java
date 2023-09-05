package kr.co.farmstory2.controller.board;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.dto.ArticleDTO;
import kr.co.farmstory2.service.ArticleService;

@WebServlet("/board/list.do")
public class ListController extends HttpServlet {
	private static final long serialVersionUID = 3792246722935648540L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService service = ArticleService.instance;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String pg = req.getParameter("pg");
		
		int currentPage = service.getCurrentPage(pg);
		int total = service.selectCountTotal(cate);
		int lastPageNum = service.getLastPageNum(total);
		int[] result = service.getPageGroupNum(currentPage, lastPageNum);
		int pageStartNum = service.getPageStartNum(total, currentPage);
		int start = service.getStartNum(currentPage);
		
		List<ArticleDTO> articles = service.selectArticles(cate, start);
		
		req.setAttribute("group", group);
		req.setAttribute("cate", cate);
		req.setAttribute("articles", articles);
		req.setAttribute("currentPage", currentPage);
		req.setAttribute("lastPageNum", lastPageNum);
		req.setAttribute("pageGroupStart", result[0]);
		req.setAttribute("pageGroupEnd", result[1]);
		req.setAttribute("pageStartNum", pageStartNum+1);
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/board/list.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		
	}
}
