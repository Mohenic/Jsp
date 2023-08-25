<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
	<head>
		<meta charset="UTF-8">
		<title>Member::list</title>
	</head>
	<body>
		<h3>직원목록</h3>
		<a href="/Ch11">메인</a>
		<a href="/Ch11/register.do">직원등록</a>
		
		<table border="1">
			<tr>
				<th>아이디</th>
				<th>이름</th>
				<th>휴대폰</th>
				<th>직급</th>
				<th>부서</th>
				<th>입사일</th>
				<th>관리</th>
			</tr>
			<tr>
				<td>a101</td>
				<td>홍길동</td>
				<td>010-1234-1111</td>
				<td>사원</td>
				<td>영업1부</td>
				<td>2022-08-25</td>
				<td>
					<a href="#">수정</a>
					<a href="#">삭제</a>
				</td>
			</tr>
		</table>
	</body>
</html>