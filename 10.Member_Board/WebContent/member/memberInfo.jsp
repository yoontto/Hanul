<%@page import="com.member.study.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<% request.setCharacterEncoding("utf-8");
MemberDTO dto = (MemberDTO) request.getAttribute("dto");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member Info</title>
</head>
<body>
<div align="center">
	<h3>[회원정보 상세보기]</h3>
	<table border="1">
		<tr>
			<th>아이디</th>
			<%-- <td><%=dto.getMember_id() %></td> --%>
			<td>${dto.member_id}</td>
		</tr>
		
		<tr>
			<th>비밀번호</th>
			<%-- <td>${dto.member_pw}</td> --%>	<!-- 개인정보 보호, 비밀번호 볼 수 있으면 안됨 -->
			<%-- <%
				int pwLength = dto.getMember_pw().length();
				String mark = dto.getMember_pw().substring(0,2);
				for(int i = 0; i < pwLength - 2; i++){
					mark += "*";
				}
				out.println("<td>" + mark + "</td>");
			%> --%>
			<td>
				<c:set var="pwLength" value="${fn:length(dto.member_pw)}"></c:set>
				<c:set var="mark" value="${fn:substring(dto.member_pw, 0, 2)}"></c:set>
				${mark}<c:forEach begin="0" end="${pwLength -3}">*</c:forEach>
				<%-- <c:if test="${!empty dto.member_pw }">
					${fn:substring(dto.member_pw,0,2) }
					<c:forEach begin="5" end="${fn:length(dto.member_pw)}" step="1">
						*
					</c:forEach>
				</c:if> --%>
			</td>
			<!-- 위의 태그를 JSTL, function으로 해보기, taglib -> c, fn 필요 -->
		</tr>
		
		<tr>
			<th>이름</th>
			<td>${dto.member_name}</td>
		</tr>
		<tr>
			<th>나이</th>
			<td>${dto.member_age}</td>
		</tr>
		<tr>
			<th>성별</th>
			<td>${dto.member_gender}</td>
		</tr>
		<tr>
			<th>이메일</th>
			<c:if test="${dto.member_email eq null}">
				<td>이메일이 등록되지 않았습니다.</td>
			</c:if>
			<c:if test="${dto.member_email ne null}">
				<td>${dto.member_email}</td>
			</c:if>
		</tr>
		
		<tr>
			<td colspan="2" align="center">
				<input type="button" value="회원 목록보기" onclick="location.href = 'memberListAction.me'">
				<input type="button" value="게시판보기" onclick="location.href = 'boardList.bo'">
				<input type="button" value="로그아웃" onclick="location.href = 'memberLogoutAction.me'">
			</td>
		</tr>
	</table>
</div>
</body>
</html>