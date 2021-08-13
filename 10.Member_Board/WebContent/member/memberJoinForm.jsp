<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MemberJoin</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 위의 cdn 방식은 네트워크에 문제가 생길 경우 동작이 안되므로
	아래의 내장 js의 src를 사용해서 대비해준다. -->
<script src="jQuery/jquery-3.6.0.js"></script>
<script>
$(document).ready(function(){
	
});//ready()

function fnSubmit(){
	var submitMsg = "입력된 내용으로 회원가입이 됩니다. \n 가입하시겠습니까?";
	if(submitMsg){
		return true;
	} else {
		return false;
	}
}

function fnReset(){
	var resetMsg = "작성하신 내용이 초기화 됩니다. \n 다시 작성하시겠습니까?";
	if(confirm(resetMsg)){
		return true;
	}else{
		return false;
	}
}
</script>
</head>
<body>
<div align="center">
<h3>[회원가입]</h3>
<form action="memberJoinAction.me" method="post" onsubmit="return fnSubmit()" onreset="return fnReset()">
<table border="1">
	<tr>
		<th>아이디</th>
		<td>
			<input type="text" name="member_id" required="required"><br>
			<span id="idCheck"></span> 
			<!-- 유효성 검사 : 유효성검사 다 통과했을 때 마지막에 중복검사 -->
		</td>
	</tr>
	<tr>
		<th>비밀번호</th>
		<td>
			<input type="password" name="member_pw" id="member_pw" required="required"><br>
			<span id="pwCheck"></span> 
			<!-- 유효성 검사 -->
		</td>
	</tr>
	<!-- 비밀번호 확인 -->
	<tr>
		<th>비밀번호 확인</th>
		<td>
			<input type="password" name="member_pw" id="member_pw" required="required"><br>
			<span id="pwDoubChk"></span> <!-- 유효성 검사 -->
		</td>
	</tr>
	<tr>
		<th>이름</th>
		<td>
			<input type="text" name="member_name" required="required"><br>
		</td>
	</tr>
	<tr>
		<th>나이</th>
		<td>
			<input type="number" name="member_age" required="required"><br>
		</td>
	</tr>
	<tr>
		<th>성별</th>
		<td align="center">
			<input type="radio" name="member_gender" value="남" checked="checked">남자
			<input type="radio" name="member_gender" value="여">여자
		</td>
	</tr>
	
	<tr>
		<th>이메일</th>
		<td>
			<input type="text" name="member_email" required="required"><br>
			<span></span>	<!-- 유효성 검사 -->
		</td>
	</tr>
	
	<tr>
		<td colspan="2" align="center">
			<input type="submit" value="회원가입">
			<input type="reset" value="다시작성">
			<input type="button" value="로그인" onclick="location.href='memberLogin.me'">
		</td>
	</tr>
</table>
</form>
</div>
</body>
</html>


























