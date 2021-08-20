<%@page import="com.board.study.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%
	int board_num = Integer.parseInt(request.getParameter("board_num"));
	String id = request.getParameter("id");
	
	BoardDAO dao = new BoardDAO();
	boolean result = dao.isBoardWriter(board_num, id);
%>
<%= result %>
