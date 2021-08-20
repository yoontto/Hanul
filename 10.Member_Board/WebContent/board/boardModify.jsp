<%@page import="com.board.study.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	BoardDTO dto = (BoardDTO) request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Modify</title>
</head>
<script type="text/javascript">
function fnSubmit(){
	if(confirm("정말 수정하시겠습니까?")){
		return true;
	}
	return false;
}

function fnReset(){
	var msg = "작성하신 내용이 초기화 됩니다.";
	msg += "\n계속 진행하시겠습니까?";
	if(confirm(msg)){
		return true;
	}
	return false;
}
</script>
<body>
<div align="center">
<h3>[게시글 수정화면]</h3>
<form action="boardModifyAction.bo" method="post" onsubmit="return fnSubmit()" onreset="return fnReset()">
	<input type="hidden" name="board_num" value="${dto.board_num}">
	<table border="1">
		<tr>
			<th>제목</th>
			<td><input type="text" name="board_subject" value="${dto.board_subject}"></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="15" cols="50" name="board_content" required="required">${dto.board_content }</textarea></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="수정하기">
				<input type="reset" value="다시 작성하기">
				<!-- <input type="button" value="목록보기" onclick="location.href='boardList.bo'"> -->
				<a href="javascript:history.go(-1)"><input type="button" value="취소하기"></a>
			</td>
		</tr>
	</table>
</form>

</div>
</body>
</html>