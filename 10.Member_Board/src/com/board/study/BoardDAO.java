package com.board.study;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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
	}//dbClose()
	
	//글 등록
	public int boardInsert(BoardDTO dto) {
		conn = getConn();
		String sql = "";
		int succ = 0;
		try {
			//글 번호(board_num)를 먼저 검색한 후, 등록할 글번호(b_num)를 결정
			//- 글이 없을 경우는 당연히 1이 되는데, 글이 많이 생겨서 글 번호를 이어야 할 경우에는 이전 글 번호를 찾아서 그 다음 번호를 부여해야 함
			sql = "select max(board_num) from memberBoard";	//board_num에서 최대값을 구하면 마지막 글의 번호가 됨
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			
			int b_num = 0;
			if(rs.next()) {	//rs에 값이 있다  == 등록된 글이 있다.
				//b_num = rs.getInt("max(board_num)");	//컬럼명(column label)으로 가져올 수도 있지만
				b_num = rs.getInt(1);					//인덱스 번호로 가져올 수도 있음, 
				//'하지만 지양 : 테이블의 구조가 바뀌는 상황에서 일관성 유지하지 못함. DB의 유연성을 유지하기 위해서 연동 최소화'
				b_num += 1;
			} else {
				//최초 글 등록 시 설정
				b_num = 1;
			}
			
			//글 등록하는 쿼리 작성
			sql = "insert into memberBoard values(?,?,?,?,?,?,?,?,?,sysdate)";
			ps = conn.prepareStatement(sql);
			ps.setInt(1, b_num);
			ps.setString(2, dto.getBoard_id());
			ps.setString(3, dto.getBoard_subject());
			ps.setString(4, dto.getBoard_content());
			ps.setString(5, dto.getBoard_file());
			ps.setInt(6, b_num);	//답글의 참조 번호 : board_re_ref
			ps.setInt(7, 0);		//답글의 답글: re lev
			ps.setInt(8, 0);		//답글의 순서 : re seq
			ps.setInt(9, 0);		//조회수	
			succ = ps.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("boardInsert() Exception!");
		} finally {
			dbClose();
		}
		return succ;
	}//boardInsert()
	
	
	//등록된 전체 글의 갯수, 페이징처리에 사용
	public int getListCount() {
		conn = getConn();
		String sql = "select count(*) from memberBoard";
		int listCount = 0;
		try {
			ps = conn.prepareStatement(sql);
			rs = ps.executeQuery();
			if(rs.next()) {
				//listCount = rs.getInt("count(*)");
				listCount = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getListCount() exception!");
		} finally {
			dbClose();
		}
		return listCount;
	}

	//전체 글 목록 검색(페이징 처리와 같이)
	public ArrayList<BoardDTO> getBoardList(int page, int limit) {
		conn = getConn();
		String sql = "";
		ArrayList<BoardDTO> list = new ArrayList<>();
		try {
			
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("getBoardList() Exception!");
		} finally {
			dbClose();
		}
		
		return null;
	}
	
	
	
	
	
	
}//class()
