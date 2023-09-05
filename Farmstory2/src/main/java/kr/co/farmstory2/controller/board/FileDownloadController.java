package kr.co.farmstory2.controller.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.dto.FileDTO;
import kr.co.farmstory2.service.ArticleService;
import kr.co.farmstory2.service.FileService;

@WebServlet("/board/fileDownload.do")
public class FileDownloadController extends HttpServlet{
	private static final long serialVersionUID = 2608153774921702065L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private ArticleService aService = ArticleService.instance;
	private FileService fService = FileService.instance;
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String fno = req.getParameter("fno");
		logger.info("fno : " + fno);
		
		FileDTO dto = fService.selectFile(fno);
		logger.debug(dto.toString());
		
		aService.downloadFile(req, resp, dto);
	}
	
}
