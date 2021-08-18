<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("utf-8");
	String id = (String) session.getAttribute("id");
	if(id == null) {		//로그인이 되어있지 않은 상태 : alert 창을 출력   --> 로그인 페이지로 이동
		response.sendRedirect("memberLogin.me");
	}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Board Write</title>
<script type="text/javascript">
function fnSubmit(){
	if(confirm("작성하신 글을 등록하시겠습니까?")){
		return true;
	}
	return false;
}

function fnReset(){
	var resetMsg = "입력하신 내용이 삭제됩니다.";
	resetMsg += "\n계속 진행하시겠습니까?";
	if(confirm(resetMsg)){
		return true;
	}
	return false;
}
</script>
</head>
<body>
<div align="center">
<h3>[게시판 글쓰기]</h3>	<!-- 로그인 안한 상태에서 글 쓰는 것 막아야 함 -->
<form action="boardAddAction.bo" method="post" onsubmit="return fnSubmit()" onreset="return fnReset()"
		enctype="multipart/form-data"><!-- enctype 안걸어주면 파일 첨부한 데이터 안넘어가고, 파일의 경로만 넘어감 -->
<!-- get방식은 파일첨부가 안됨, 당연히 post로 설정하기! -->
	<input type="hidden" name="board_id" value="${id }"/>	<!-- id값 서브밋 시킬 떄 넘겨야 하니까 업데이트할 때처럼 히든 시킴 -->
	<table border="1">
		<tr>
			<th>작성자</th>
			<td>${id}</td>
		</tr>
		<tr>
			<th>제목</th>
			<td><input type="text" name="board_subject" required="required" maxlength="50"/></td>
		</tr>
		<tr>
			<th>내용</th>
			<td><textarea rows="15" cols="50" name="board_content" required="required" maxlength="50"></textarea></td>
		</tr>
		<tr>
			<th>파일첨부</th>
			<td><input type="file" name="board_file"></td>
		</tr>
		<tr>
			<td colspan="2" align="center">
				<input type="submit" value="글 등록">
				<input type="reset" value="다시작성">
				<input type="button" value="목록보기" onclick="location.href='boardList.bo'">
			</td>
		</tr>
	</table><!-- function까지 작성완료하면 controller 넘어가기 -->
</form>
</div>
</body>
</html>