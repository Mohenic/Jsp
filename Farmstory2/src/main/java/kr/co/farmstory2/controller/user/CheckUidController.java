package kr.co.farmstory2.controller.user;


import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import com.google.gson.JsonObject;

import kr.co.farmstory2.service.UserService;

@WebServlet("/user/checkUid.do")
public class CheckUidController extends HttpServlet {
	private static final long serialVersionUID = -4413450232588058294L;

	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private UserService service = new UserService();
	
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String uid = req.getParameter("uid");
		logger.debug("uid" + uid);
		
		int result = service.selectCountUid(uid);
		
		JsonObject json = new JsonObject();
		json.addProperty("result", result);
		
		PrintWriter writer = resp.getWriter();
		writer.print(json.toString());
	}
}
