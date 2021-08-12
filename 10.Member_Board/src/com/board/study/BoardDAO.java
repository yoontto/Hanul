package com.board.study;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardDAO {		//DB 연동 : JDBC FrameWork 연동, old working type, 요즘은 myBatis, mySQL로 더 많이 함
	private Connection conn;
	private PreparedStatement ps;
	private ResultSet rs;
	
	//DB 접속
	public Connection getConn() {
		try {
			String url = "jdbc:oracle:thin:@127.0.0.1:1521:XE";
			String user = "hanul";
			String password = "0000";
			Class.forName("oracle.jdbc.driver.OracleDriver");
			conn = DriverManager.getConnection(url,user,password);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getConn() Exception!");
		}
		return conn;
	}
	
	//DB 접속 해제
	public void dbClose() {
		try {
			if(rs != null) {rs.close();}
			else if (ps != null) {ps.close();}
			else if (conn != null) {conn.close();}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("dbClose Exceprion!");
		}
	}
	
	
	
	
	
	
}//class()
