<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Insert title here</title>
	</head>
	<body>
		<form action="/Jboard1/test2.jsp" method="post" enctype="multipart/form-data">
			<input type="text" name="title">
			<input type="text" name="name">
			<input type="text" name="age">
			<input type="file" name="fname">
			<input type="submit" value="전송">
		</form>
		
	</body>
</html>