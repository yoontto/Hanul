package com.board.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.board.study.BoardDAO;
import com.board.study.BoardDTO;
import com.commons.action.Action;
import com.commons.action.ActionForward;

public class BoardListAction implements Action {
	
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//클라이언트 요청
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		//비지니스 로직 : DB 접속 후 전체글 목록 검색, 페이징 처리
		BoardDAO dao = new BoardDAO();
		int listCount = dao.getListCount();	//전체 글 개수 검색
		int page = 1;	//시작 페이지 번호
		int limit = 10;	//한 페이지당 출력되는 글의 갯수
		if(request.getParameter("page") != null) {
			page = Integer.parseInt(request.getParameter("page"));
		}
		ArrayList<BoardDTO> list = new ArrayList<>();
		list = dao.getBoardList(page, limit);	//전체 글 목록 검색
		//프리젠테이션 로직
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if (id == null) {
			/*forward.setPath("memberLogin.me");
			forward.setRedirect(true);		// redirect는 url 바뀜 */
			out.println("<script>alert('정상적인 접근 방식이 아닙니다!')");
			out.println("location.href='memberLogin.me'</script>");
			return null;
		} else {
			ActionForward forward = new ActionForward();
			forward.setPath("board/boardList.jsp");
			forward.setRedirect(false);		//url  변경 안된다
			return forward;
		}
	}
}
