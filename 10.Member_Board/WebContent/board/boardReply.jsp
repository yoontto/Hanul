<%@page import="com.board.study.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");
BoardDTO dto = (BoardDTO) request.getAttribute("dto");
String id = (String) session.getAttribute("id");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Reply</title>
<script type="text/javascript">
function fnSubmit(){
	if(confirm("답글을 등록하시겠습니까?")){
		return true;
	}
	return false;
}

function fnReset(){
	var msg = "입력하신 내용이 초기화됩니다. \n계속 진행하시겠습니까?";
	if(confirm(msg)){
		return true;
	}
	return false;
}
</script>
</head>
<body>
<div align="center">
<h3>답글쓰기</h3>
<form action="boardReplyAction.bo" method="post" onsubmit="fnSubmit()" onreset="fnReset()">
<input type="hidden" name="board_id" value="${id}">
<input type="hidden" name="board_num" value="${dto.board_num}">
<input type="hidden" name="board_re_ref" value="${dto.board_re_ref}">
<input type="hidden" name="board_re_lev" value="${dto.board_re_lev}">
<input type="hidden" name="board_re_seq" value="${dto.board_re_seq}">
<table border="1">
	<tr>
		<th>작성자</th>
		<td>${id}</td>
	</tr>
	<tr>
		<th>제목</th>
		<td><input type="text" name="board_subject" value="${id }님의 답글" maxlength="50"></td>
	</tr>
	<tr>
		<th>내용</th>
		<td><textarea rows="15" cols="50" name="board_content" required="required"></textarea></td>
	</tr>
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="답글등록">
			<input type="reset" value="다시 작성">
			<input type="button" value="취소하기" onclick="history.go(-1);">
			<input type="button" value="목록보기" onclick="location.href='boardList.bo'">
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>