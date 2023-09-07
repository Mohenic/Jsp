package kr.co.farmstory2.controller.board;

import java.io.File;
import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.service.FileService;

@WebServlet("/board/delete.do")
public class DeleteController extends HttpServlet {
	private static final long serialVersionUID = -4550516370748336927L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private FileService fService = FileService.instance;
	private ArticleService aService = ArticleService.instance;

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		// 글 번호 수신
		String group = req.getParameter("group");
		String cate = req.getParameter("cate");
		String no = req.getParameter("no");
		
		logger.debug("no : " + no);
		
		// 파일 삭제(DB)
		List<String> snames = fService.deleteFile(no);
		
		// 글+댓글 삭제
		aService.deleteArticle(no);
		
		// 파일 삭제(Directory)
		if(!snames.isEmpty()) {
			String path = aService.getPath(req, "/upload");
			
			for(String sname : snames) {
				File file = new File(path+"/"+sname);
				
				if(file.exists()) {
					file.delete();
				}
			}
		}
		
		resp.sendRedirect("/Farmstory2/board/list.do?group="+group+"&cate="+cate);
		
	}
}
