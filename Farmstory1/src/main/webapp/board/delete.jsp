<%@page import="kr.farmstory1.dao.ArticleDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String no    = request.getParameter("no");	
	String group = request.getParameter("group");	
	String cate  = request.getParameter("cate");	

	ArticleDAO dao = new ArticleDAO();
	dao.deleteArticle(no);

	response.sendRedirect("./list.jsp?group="+group+"&cate="+cate);
%>