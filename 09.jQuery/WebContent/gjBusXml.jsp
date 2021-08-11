<%@page import="net.htmlparser.jericho.Source"%>
<%@page import="com.hanul.study.GjBusDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
GjBusDAO dao = new GjBusDAO();
Source source = dao.makeXml();
String xml = source.toString();

int beginIndex = xml.indexOf("<ns2");
xml = xml.substring(beginIndex);
%>
<%=xml%>