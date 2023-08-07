<%@page import="kr.co.jboard1.vo.UserVO"%>
<%@page import="java.sql.PreparedStatement"%>
<%@page import="kr.co.jboard1.db.SQL"%>
<%@page import="java.sql.Connection"%>
<%@page import="javax.sql.DataSource"%>
<%@page import="javax.naming.InitialContext"%>
<%@page import="javax.naming.Context"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 전송 데이터 수신
	request.setCharacterEncoding("UTF-8");
	String title 	= request.getParameter("title");
	String content 	= request.getParameter("content");
	String file 	= request.getParameter("file");
	String writer 	= request.getParameter("writer");
	String regip    = request.getRemoteAddr();
	
	// 데이터베이스 처리
	try {
		Context ctx = (Context) new InitialContext().lookup("java:comp/env");
		DataSource ds = (DataSource) ctx.lookup("jdbc/Jboard");
		Connection conn = ds.getConnection();
		
		PreparedStatement psmt = conn.prepareStatement(SQL.INSERT_ARTICLE);
		psmt.setString(1, title);
		psmt.setString(2, content);
		psmt.setString(3, writer);
		psmt.setString(4, regip);
		
		psmt.executeUpdate();
		
		psmt.close();
		conn.close();
	}catch(Exception e){
		e.printStackTrace();
	}
	
	// 리다이렉트
	response.sendRedirect("/Jboard1/list.jsp");
%>