<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="com.board.study.BoardDTO"%>
<%@page import="com.member.study.MemberDAO"%>
<%@page import="java.util.ArrayList"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	
	MemberDAO dao = new MemberDAO();
	String member_pw = dao.getMember_pw(id);	//dao가서 비밀번호 불러오는 메소드 만들어주기
	
	Integer nowPage = (Integer) request.getAttribute("page");
	Integer maxPage = (Integer) request.getAttribute("maxPage");
	Integer startPage = (Integer) request.getAttribute("startPage");
	Integer endPage = (Integer) request.getAttribute("endPage");
	//page만 쓰면 jsp 내장객체 중 동일한 이름을 가진 page가 동작됨, 다른 이름으로 설정
	Integer listCount = (Integer) request.getAttribute("listCount");
	ArrayList<BoardDTO> list = new ArrayList<>();
	list = (ArrayList<BoardDTO>) request.getAttribute("list");
	
	//el 표현식에서 사용하기 위해 새로운 바인딩 객체 설정
	pageContext.setAttribute("nowPage", nowPage);
	
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
			<%-- <%if(list.size() == 0){
				out.println("<tr><td colspan='5' align='center'>");
				out.println("작성된 글이 없습니다.</td></tr>");
			}//if%>
			
			<% for(int i = 0; i < list.size() ; i++){ 
				BoardDTO dto = list.get(i);	%>
				<tr align="center">
					<td><%=dto.getBoard_num() %></td>
				</tr>
			
			<% } %> --%>
			
			<c:if test="${empty list}">
				<tr>
					<td colspan="5" align="center">작성된 글이 없습니다.</td>
				</tr>
			</c:if><%--<c:if test="${list eq null}"> --%>
			
			<c:forEach var="i" begin="0" end="${fn:length(list) - 1}" step="1">
				<tr align="center">
					<td>${list[i].board_num}</td>
					<td>${list[i].board_subject}</td>
					<td>${list[i].board_id}</td>
					<td>${list[i].board_date}</td>
					<td>${list[i].board_readcount}</td>
				</tr>
			</c:forEach>
			
			
			<!-- 페이징 처리 -->
			<tr align="center">
				<%-- <td colspan="5">
					<%if(nowPage <= 1){ %>
						[이전]&nbsp;
					<%}else{ %>
						<a href="boardList.bo?page=<%=nowPage - 1%>">[이전]</a>&nbsp;
					<%}//if %>

					<% for(int i = startPage; i <= endPage; i++){ %>
						<%if(i == nowPage){ %>
							[<%=i %>]&nbsp;
						<%} else { %>
							<a href="boardList.bo?page=<%= i %>">[<%=i %>]</a>&nbsp;
						<%} %>
					<%}//for %>

					<%if(nowPage >= maxPage){ %>
						<a>[다음]</a>
					<%} else { %>
						<a href="boardList.bo?page=<%=nowPage +1%>">[다음]</a>&nbsp;
					<%}//if %>
				</td> 
			</tr>--%>
			
			<tr align="center">
				<td colspan="5">
					<c:if test="${nowPage le 1}">[이전]&nbsp;</c:if>
					<c:if test="${!(nowPage le 1)}">
						<a href="boardList.bo?page=${nowPage - 1}">[이전]</a>&nbsp;
					</c:if>
					
					<c:forEach var="i" begin="${startPage }" end="${endPage}" step="1">
						<c:if test="${i eq nowPage}">[${i}]&nbsp;</c:if>
						<c:if test="${i ne nowPage}">
							<a href="boardList.bo?page=${i}">[${i}]</a>
						</c:if>
					</c:forEach>
					
					<c:if test="${nowPage ge maxPage}">[다음]</c:if>
					<c:if test="${!(nowPage ge maxPage)}">
						<a href="boardList.bo?page=${nowPage + 1}">[다음]</a>&nbsp;
					</c:if>
				</td>
			</tr>
			
			
			
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



















