<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>4_application</title>
		<!-- 
			날짜 : 2023/07/25
			이름 : 김철학
			내용 : JSP application 내장객체 실습하기
		-->
	</head>
	<body>
		<h3>4.application 내장객체</h3>
		
		<h4>서버 정보</h4>
		<%= application.getServerInfo() %>
		
		<h4>파라미터 정보</h4>
		<%
			String value1 = application.getInitParameter("PARAM1");
			String value2 = application.getInitParameter("PARAM2");
		%>
		<p>
			value1 : <%= value1 %><br>
			value2 : <%= value2 %><br>
		</p>	
		
		<h4>로그 정보</h4>
		<%
			application.log("로그기록");
		%>
		
		<h4>자원 경로</h4>
		<%= application.getRealPath("./4_application.jsp") %>
				
	</body>
</html>