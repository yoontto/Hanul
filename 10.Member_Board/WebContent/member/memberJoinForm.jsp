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
var eamilOk = 0;
var pwOk = 0;
var idOk = 0;

$(document).ready(function() {
	
	$("#member_id").keyup(function() {
		var id = $("#member_id").val();
		var regId = /^[a-z0-9]{5,15}$/;
		var check = true;
		//ID 유효성 검사
		if (!regId.test(id)) {
			var msg = "영문 소문자나 숫자를 이용해 5~10글자로 입력해주세요.";
			$("#idCheck").html(msg);
			$("#idCheck").css("color", "red");
			$("#member_id").focus();
		} else {
				$.ajax({
					dataType : "json",
					url : "member/checkId.jsp",
					success : function(data){
						$.each(data, function(key, value){
							if(id == value.member_id){
								idOk = 0;
								check = false;	
							}
						});//each
						fnCheck(check);
					} ,
					error : function(){
						alert("다시 입력해주세요!");
						idOk = 0;
					}//success 
				});//ajax  
			}//if
	});//id_keyup()

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
	
	//email 유효성 검사
	$("#member_email2").keyup(function(){
		var email = $("#member_email2").val();
		var regEmail = /^[a-z0-9]{5,20}$/;
		if(!regEmail.test(email)){
			var emailMsg = "정확한 이메일을 입력하세요!";
			$("#emailCheck").html(emailMsg).css("color", "red");
			emailOk = 0;
		} else {
			var emailMsg = "사용 가능한 이메일입니다.";
			$("#emailCheck").html(emailMsg).css("color", "blue");
			emailOk = 1;
		}
	});
	
	
});//ready()

function fnSubmit() {
	if(pwOk == 0 || idOk == 0 || emailOk == 0){
		confirm("필수사항을 전부 입력해주세요\n" + pwOk);
		return false;
	} else {
		if(confirm("입력하신 정보로 회원가입을 진행하시겠습니까?")){
			return true;
		} else {
			return false;
		}
	}
	
	/* var submitMsg = "입력된 내용으로 회원가입이 됩니다. \n 가입하시겠습니까?";
	if (submitMsg) {
		return true;
	} else {
		return false;
	} */
}

function fnReset() {
	var resetMsg = "작성하신 내용이 초기화 됩니다. \n 다시 작성하시겠습니까?";
	if (confirm(resetMsg)) {
		return true;
	} else {
		return false;
	}
}

function fnCheck(check) {
	if (!check) {
		var msg = "사용중인 아이디입니다.";
		$("#idCheck").html(msg);
		$("#idCheck").css("display", "block");
		$("#idCheck").css("color", "red");
		idOk = 0;
	} else {
		msg = "사용 가능한 아이디입니다.";
		$("#idCheck").html(msg);
		$("#idCheck").css("color", "blue");
		idOk = 1;
	}
}
</script>
</head>
<body>
	<div align="center">
		<h3>[회원가입]</h3>
		<form action="memberJoinAction.me" method="post"
			onsubmit="return fnSubmit()" onreset="return fnReset()">
			<table border="1">
				<tr>
					<th>아이디</th>
					<td><input type="text" name="member_id" id="member_id" required="required"><br>
						<span id="idCheck"></span> <!-- 유효성 검사 : 유효성검사 다 통과했을 때 마지막에 중복검사 -->
					</td>
				</tr>
				<tr>
					<th>비밀번호</th>
					<td><input type="password" name="member_pw" id="member_pw"
						required="required"><br> <span id="pwCheck"></span> <!-- 유효성 검사 -->
					</td>
				</tr>
				<tr>
					<th>비밀번호 확인</th>
					<td><input type="password" name="member_pw_check" id="member_pw_check"
						required="required"><br> <span id="pwRecheck"></span>
						<!-- 유효성 검사 --></td>
				</tr>
				<tr>
					<th>이름</th>
					<td><input type="text" name="member_name" required="required"><br>
					</td>
				</tr>
				<tr>
					<th>나이</th>
					<td><input type="number" name="member_age" required="required"><br>
					</td>
				</tr>
				<tr>
					<th>성별</th>
					<td align="center"><input type="radio" name="member_gender"
						value="남" checked="checked">남자 <input type="radio"
						name="member_gender" value="여">여자</td>
				</tr>

				<tr>
					<th>이메일</th>
					<td>
					<span id="member_email">
						<input type="text" name="member_email" id="member_email2" required="required" style="width:100px">
							@<select name="email">
								<option>naver.com</option>
								<option>daum.net</option>
								<option>gmail.com</option>
								<option>hanmail.net</option>
							</select><br>
						</span>
						<span id="emailCheck"></span> <!-- 유효성 검사 -->
					</td>
				</tr>

				<tr>
					<td colspan="2" align="center"><input type="submit"
						value="회원가입"> <input type="reset" value="다시작성"> <input
						type="button" value="로그인" onclick="location.href='memberLogin.me'">
					</td>
				</tr>
			</table>
		</form>
	</div>
</body>
</html>


























