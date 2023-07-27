<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%
	// 인코딩 설정
	request.setCharacterEncoding("UTF-8");
	
	// 전송 데이터 수신
	String id = request.getParameter("id");
	String pw = request.getParameter("pw");

	// 회원 여부 확인
	if(pw.equals("1234")){
		// 회원일 경우 -> 세션 기록
		session.setAttribute("sessid", id);
		response.sendRedirect("./loginSuccess.jsp");
	}else{
		// 회원이 아닐 경우
		response.sendRedirect("../2_Session.jsp");
	}
%>