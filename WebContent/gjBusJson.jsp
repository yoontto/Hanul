<%@page import="net.htmlparser.jericho.Source"%>
<%@page import="com.hanul.study.GjBusDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//GjBusDAO.java 클래스의 makeJSON() 메소드 통해
//버스노선정보 url을 htmlParser Library를 활용하여 파싱
GjBusDAO dao = new GjBusDAO();
Source source = dao.makeJson();
String json = source.toString();

int beginIndex = json.indexOf("[");
int endIndex = json.indexOf("]");
json = json.substring(beginIndex,endIndex + 1);
%>
<%=json %>
