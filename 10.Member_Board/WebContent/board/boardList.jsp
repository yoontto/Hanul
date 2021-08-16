<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
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

		<table border="1">
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
					<%-- <%if(id != null && id.equals("admin")){ %>
						<input type="button" value="회원관리" onclick="location.href='memberListAction.me'"/>
					<% } %> --%>
					<c:if test="${id ne null && id eq 'admin'}">	<!-- ne: not equals, eq: equals -->
					<!-- 아이디가 null이 아니고 admin일 때 -->
						<input type="button" value="회원관리" onclick="location.href='memberListAction.me'"/>
					</c:if>
					<input type="button" value="로그아웃" onclick="location.href='memberLogoutAction.me'">
				</td>
			</tr>
		</table>
	</div>

</body>
</html>



















