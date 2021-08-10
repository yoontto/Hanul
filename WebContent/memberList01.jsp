<%@page import="com.hanul.study.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%--
MemberDAO.java 클래스를 통해 DB에 접속(myBatis) 후,
Member Table의 전체목록을 검색하고,
검색된 결과를 JSON 구조 형태로 변환하여 결과를 리턴
▶ memberSearchAllJson01();
--%>
<%
MemberDAO dao = new MemberDAO(); 
String json = dao.memberSearchAllJson01();
%>
<%=json %>