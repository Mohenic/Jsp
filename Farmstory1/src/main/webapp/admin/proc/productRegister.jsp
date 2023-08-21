<%@page import="kr.farmstory1.dto.ProductDTO"%>
<%@page import="kr.farmstory1.dao.ProductDAO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String productName = request.getParameter("productName");
	String type        = request.getParameter("type");
	String price       = request.getParameter("price");
	String delivery    = request.getParameter("delivery");
	String stock       = request.getParameter("stock");
	String thumb1    = request.getParameter("thumb1");
	String thumb2    = request.getParameter("thumb2");
	String thumb3    = request.getParameter("thumb3");
	String seller    = request.getParameter("seller");
	String etc         = request.getParameter("etc");

	ProductDTO dto = new ProductDTO();
	dto.setpName(productName);
	dto.setType(type);
	dto.setPrice(price);
	dto.setDelivery(delivery);
	dto.setStock(stock);
	dto.setThumb1(thumb1);
	dto.setThumb2(thumb2);
	dto.setThumb3(thumb3);
	dto.setSeller(seller);
	dto.setEtc(etc);
	
	ProductDAO dao = new ProductDAO();
	dao.insertProduct(dto);
	
	response.sendRedirect("../productRegister.jsp");
%>