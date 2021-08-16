<%@page import="com.member.study.MemberDTO"%>
<%@page import="java.util.List"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<% 
request.setCharacterEncoding("utf-8");
List<MemberDTO> list = (List<MemberDTO>) request.getAttribute("list");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Member List</title>
<script type="text/javascript">
function fnDelete(member_id){	//member_id가 파라미터, 아래의 i.member_id는 이엘로 받아온 아이디 값
	//alert(member_id);
	if(confirm("정말 삭제하시겠습니까?")){
		location.href="memberDeleteAction.me?member_id=" + member_id;	//frontcontroller로 넘어가기
	}
}
</script>
</head>
<body>
<div align="center">
<h3>[전체회원 리스트]</h3>
<table border="1">
	<tr>
		<th>아이디 </th>
		<th>이름 </th>
		<th>삭제 </th>
	</tr>
	
	<c:forEach var="i" items="${list}">	<!-- 반복문 -->
		<tr align="center">
			<td>${i.member_id }</td>
			<td>${i.member_name }</td>
			<td>
				<c:if test="${i.member_id eq 'admin'}">삭제 금지</c:if>
				<c:if test="${i.member_id ne 'admin'}">
					<input type="button" value="삭제" onclick="fnDelete('${i.member_id}')"></c:if>	
					<!-- 여기 들어간 값은 i번지의 member_id라는 뜻 -->
			</td>
		</tr>
	</c:forEach>
</table>
</div>
</body>
</html>