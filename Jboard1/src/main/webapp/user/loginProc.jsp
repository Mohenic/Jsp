<%@page import="kr.co.jboard1.dao.UserDAO"%>
<%@page import="kr.co.jboard1.dto.UserDTO"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String uid  = request.getParameter("uid");
	String pass = request.getParameter("pass");
	
	// 사용자 DB 조회
	UserDTO user = UserDAO.getInstance().selectUser(uid, pass);
	
	// 회원 여부 확인
	if(user != null){
		// 사용자 세션 저장
		session.setAttribute("sessUser", user);
		
		// 리다이렉트
		response.sendRedirect("/Jboard1/list.jsp");
	}else{
		// 리다이렉트
		response.sendRedirect("/Jboard1/user/login.jsp?success=100");		
	}
%>