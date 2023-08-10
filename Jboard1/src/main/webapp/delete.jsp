<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no = request.getParameter("no");	

	ArticleDAO dao = new ArticleDAO();
	dao.deleteArticle(no);
	
	response.sendRedirect("/Jboard1/list.jsp");
%>