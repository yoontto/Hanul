<%@page import="com.member.study.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%
	request.setCharacterEncoding("utf-8");
	MemberDTO dto = (MemberDTO) request.getAttribute("dto");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>MEmber Detail Form</title>
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<!-- 위의 cdn 방식은 네트워크에 문제가 생길 경우 동작이 안되므로
	아래의 내장 js의 src를 사용해서 대비해준다. -->
<script src="jQuery/jquery-3.6.0.js"></script>
<script>
$(document).ready(function(){
$("#member_pw, #member_pw_check").keyup(function(){	//비밀번호, 비밀번호 확인 둘 다 키업 걸어줘야 작동
		var pw = $("#member_pw").val();	
		pwOk = 0;
		var num = pw.search(/[0-9]/g);	//g : global, 문자열 내의 모든 패턴을 검색
		var eng = pw.search(/[a-z]/ig);	//i : ignore Case, 대소문자 구분없이
		var spe = pw.search(/[`~!@@#$%^&*|₩₩₩'₩";:₩/?]/gi);
		
		if(pw.length < 10 || pw.length > 15){	//pw 길이
			var pwMsg = "비밀번호는 10 - 15자 이내로 입력하세요"
			$("#pwCheck").html(pwMsg);
			$("#pwCheck").css("color","red");
			$("#member_pw").focus();
			pwOk = 0;
		} else if(pw.search(/\s/) != -1){	// \s:공백문자  , \S : 공백이 아닌문자
			//.search()는 검색될 문자의 위치값을 반영, -1이라는 위치는 없는 위치이므로 공백이 없음을 의미함
			var pwMsg = "비밀번호는 공백 없이 입력하세요"
			$("#pwCheck").html(pwMsg);
			$("#pwCheck").css("color","red");
			$("#member_pw").focus();
			pwOk = 0;
		} else if((num < 0 && eng < 0) || (eng < 0 && spe < 0) || (spe < 0 && num < 0)){	//문자 종류 2가지 이상 사용
			var pwMsg = "영문, 숫자, 특수문자 중 2가지 이상을 입력해주세요.";
			$("#pwCheck").html(pwMsg);
			$("#pwCheck").css("color","red");
			$("#member_pw").focus();
			pwOk = 0;
		} else {
			var pwMsg = "사용 가능한 비밀번호입니다.";
			$("#pwCheck").html(pwMsg);
			$("#pwCheck").css("color","blue");
			pwOk = 1;
			var pwRecheck = $("#member_pw_check").val();
			if(pw != pwRecheck) {
				var pwMsg = "비밀번호가 일치하지 않습니다.";
				$("#pwRecheck").html(pwMsg);
				$("#pwRecheck").css("color", "red");
				pwOk = 0;
			}else{
				var pwMsg = "비밀번호가 일치합니다.";
				$("#pwRecheck").html(pwMsg);
				$("#pwRecheck").css("color", "blue");
				pwOk = 1;
			}
		}
	});//pw_keyup
});//ready()

function fnSubmit(){
	if(confirm("정말 수정하시겠습니까?")){
		return true;
	} else {
		return false;
	}
}
</script>
</head>
<body>
	<div align="center">
		<h3>[회원정보 수정화면]</h3>
		<form action="memberUpdateAction.me" method="post">
		<input type="hidden" name="member_id" value="${dto.member_id }">
			<table border="1">
				<tr>
					<th>아이디</th>
					<td>${dto.member_id}</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="member_pw" value="${dto.member_pw }"><br> <span id="pwCheck"></span> <!-- 유효성 검사 -->
					</td>
				</tr>
				<!-- <tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="member_pw_check" id="member_pw_check"
						required="required"><br> <span id="pwRecheck"></span>
						유효성 검사</td>
				</tr> -->
				<tr>
					<th>이름</th>
					<td><input type="text" name="member_name" value="${dto.member_name }"></td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="text" name="member_age" value="${dto.member_age}" min="0"></td>
				</tr>
				<tr>
					<th>성별</th>
					<td>
						<c:if test="${dto.member_gender eq '남'}">
							<input type="radio" name="member_gender" value="남" checked="checked">남자
							<input type="radio" name="member_gender" value="여">여자
						</c:if>	
						<c:if test="${dto.member_gender eq '여'}">
							<input type="radio" name="member_gender" value="남" checked="checked">남자
							<input type="radio" name="member_gender" value="여">여자
						</c:if>	
					</td>
				</tr>
				<tr>
					<th>이메일</th>
					<td><input type="text" name="member_email" value="${dto.member_email}"></td>
				</tr>
				<tr>
					<td colspan="2" align="center">
						<input type="submit" value="수정하기" onclick="fnSubmit()">
						<input type="reset" value="다시 작성">
						<input type="button" value="게시판 목록보기" onclick="location.href='boardList.bo'"/>
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>