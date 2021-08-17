<%@page import="com.member.study.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	
	MemberDAO dao = new MemberDAO();
	String member_pw = dao.getMember_pw(id);	//dao가서 비밀번호 불러오는 메소드 만들어주기
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board List</title>
<script type="text/javascript">
function fnModify(id, member_pw){
	//alert(id + "\n" + member_pw);
	var input_pw = prompt("비밀번호를 입력하세요","");
	
	if(input_pw == member_pw){
		location.href = "memberDetailAction.me?member_id=" + id;
	} else {
		alert("비밀번호가 일치하지 않습니다.");
	}
}
</script>
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
					<input type="button" value="회원정보 수정" onclick="fnModify('<%=id%>', '<%=member_pw%>')">
					<input type="button" value="로그아웃" onclick="location.href='memberLogoutAction.me'">
					<input type="button" value="글쓰기" onclick="location.href='boardWrite.bo'">
				</td>
			</tr>
		</table>
	</div>

</body>
</html>



















