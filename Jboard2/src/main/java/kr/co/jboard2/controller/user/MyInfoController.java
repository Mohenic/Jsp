package kr.co.jboard2.controller.user;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.jboard2.service.UserService;

@WebServlet("/user/myInfo.do")
public class MyInfoController extends HttpServlet {
	private static final long serialVersionUID = -535586664189707602L;

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private UserService service = UserService.getInstance();
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		RequestDispatcher dispatcher = req.getRequestDispatcher("/user/myInfo.jsp");
		dispatcher.forward(req, resp);
	}
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

		String kind = req.getParameter("kind");
		String uid  = req.getParameter("uid");
		
		logger.debug("kind : " + kind);
		logger.debug("uid : "  + uid);
		
		switch(kind) {
			case "WITHDRAW":
				int result = service.updateUserForWithdraw(uid);
				
				JsonObject json = new JsonObject();
				json.addProperty("result", result);
				resp.getWriter().print(json);
				
				// ajax 요청이기 때문에 redirect 응답처리 안됨
				//resp.sendRedirect("/Jboard2/user/login.do?success=400");
				break;
			case "PASSWORD":
				break;
			case "MODIFY":
				break;
		}
	}
	
	
}
