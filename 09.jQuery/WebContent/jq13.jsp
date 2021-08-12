<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
int num1 = Integer.parseInt(request.getParameter("num1"));
int num2 = Integer.parseInt(request.getParameter("num2"));

int result = 0;
for(int i = num1; i <= num2; i++){
	result += i;
}
%>
<%= result %>
<!-- 계산을 해주고 결과값을 다시 html 파일로 넘겨줌 -->
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>jq13 - 13번 html 값 받아오는 페이지</title>
</head>
