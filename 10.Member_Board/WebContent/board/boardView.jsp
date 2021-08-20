<%@page import="com.board.study.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	BoardDTO dto = (BoardDTO) request.getAttribute("dto");
	
	/* 줄바꿈 처리 */
	//POJO를 이용한 게시판 줄바꿈 처리(순수 자바코드)
	String board_content = dto.getBoard_content();
	String replaceContent = board_content.replaceAll("\r\n", "<br>");
	
	//JSTL을 이용한 게시판 줄바꿈 처리
	pageContext.setAttribute("enter", "\r\n");
	String id = (String) session.getAttribute("id"); 
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script src="jQuery/jquery-3.6.0.js"></script>
<script type="text/javascript">
$(document).ready(function(){
	$("#btn").click(function(){
		var board_num = ${dto.board_num};
		var id = '${id}';	//인용구 ''로 묶어주기
		//alert("board_num : " + board_num + "  id : " + id);
		var param = "board_num=" + board_num + "&id=" + id;
		
		$.ajax({
			dataType : "text", 
			url : "board/isWriter.jsp",
			data : param,
			success : function(data){fnUpdate(board_num, data);},
			error : function(){alert("로딩실패");}
		});//ajax 
	})//btn_click()
});//ready()
function fnReply(board_num){
	location.href = "boardReplyView.bo?board_num=" + board_num ;
}


function fnUpdate(board_num, data){
	//alert("board_num=" + board_num + "&data=" + data);
	if(data.trim() == "false"){
		alert("수정 권한이 없습니다.");
		return;
	} else {
		location.href = "boardModifyView.bo?board_num=" + board_num;
	}
}

function fnDelete(board_num){
	//alert("board_num : " + board_num + "을 삭제합니다.");
	if(confirm("정말 삭제하시겠습니까?")){
		location.href = "boardDeleteAction.bo?board_num=" + board_num;
	}
	return false;
}
</script>
</head>
<body>
<div align="center">
<h3>[글 내용 상세보기]</h3>
<table border="1" style="width : 80%">
	<tr>
		<th>제목</th>
		<%-- <td><%=dto.getBoard_subject() %></td>
		자바코드 최소화 하려고 el 문법 씀
		 --%>
		<td>${dto.board_subject }</td>
		<th>조회수</th>
		<td>${dto.board_readcount }</td>
	</tr>
	
	<tr>
		<th>내용</th>
		<%-- <td colspan="3">${dto.board_content }</td> --%>
		<%-- <td colspan="3"><%=replaceContent %></td> --%><!-- POJO 사용 -->
		<td colspan="3">${fn:replace(dto.board_content, enter, "<br>")} </td><!-- JSTL 사용 -->
	</tr>
	<tr>
		<th>첨부파일</th>
		<td colspan="3">
			<c:if test="${empty dto.board_file}">
				첨부된 파일이 없습니다.
			</c:if>
			<c:if test="${not empty dto.board_file}">
				<a href="boardupload/${dto.board_file}" target="blank">${dto.board_file}</a>
			</c:if>
		</td>
	</tr>
	<tr>
		<td colspan="4" align="center">
			<input type="button" value="답글쓰기" onclick="fnReply('${dto.board_num}')">
			<input type="button" value="수정하기" id="btn">
			<input type="button" value="삭제하기" onclick="fnDelete('${dto.board_num}')">
			<input type="button" value="목록보기" onclick="location.href='boardList.bo'">
		</td>
	</tr>
</table>
</div>
</body>
</html>