<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
</head>
<body>
	<div align="center">
		<h3>[전체 글 목록보기]</h3>

		<table>
			<tr>
				<th>번호</th>
				<th>제목</th>
				<th>작성자</th>
				<th>작성일</th>
				<th>조회수</th>
			</tr>
			
			<!-- 글목록 표시 -->
			<!-- 페이징 처리 -->
			
			<tr>
				<td colspan="5" align="center">
					<input type="button" value="로그아웃" onclick="location.href='memberLogoutAction.me'">
				</td>
			</tr>
		</table>
	</div>

</body>
</html>



















