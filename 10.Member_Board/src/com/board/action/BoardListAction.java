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

		/*아래의 전체 페이지 수와 현재 페이지 수 구하는 법은 전형적인 계산식*/
		//전체 페이지 수
		int maxPage = (int)((double)listCount / limit + 0.95);
		
		//현재 페이지에서 보여줄 시작되는 글 번호
		int startPage = (((int)((double)page / limit + 0.95)) - 1) * limit + 1;
		
		//현재 페이지에서 보여줄 마지막 글번호 (10,20,30)
		int endPage = maxPage;
		if(endPage > startPage + limit - 1) {
			endPage = startPage + limit - 1;
		}
		
		//바인딩 객체 생성 : 출력 페이지로 전달
		request.setAttribute("page", page);				//현재 페이지 수
		request.setAttribute("maxPage", maxPage);		//전체 페이지 수
		request.setAttribute("startPage", startPage);	//첫 페이지수
		request.setAttribute("endPage", endPage);		//마지막 페이지수
		request.setAttribute("listCount", listCount);	//전체 글의 개수
		request.setAttribute("list", list);				//전체 글 목록
		
		
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
