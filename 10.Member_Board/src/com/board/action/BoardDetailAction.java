package com.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.board.study.BoardDAO;
import com.board.study.BoardDTO;
import com.commons.action.Action;
import com.commons.action.ActionForward;

public class BoardDetailAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		if(id == null) {	//로그인이 되어있지 않은 상태
			response.setContentType("text/html; charset=utf-8");
			PrintWriter out = response.getWriter();
			out.println("<script>alert('로그인하시기 바랍니다!!!!!!!!!!!!')");
			out.println("location.href='memberLogin.me'</script>");
			return null;
		} else {	//로그인이 된 상태
			int board_num = Integer.parseInt(request.getParameter("board_num"));
			
			BoardDAO dao = new BoardDAO();
			BoardDTO dto = dao.getDetail(board_num);	//조회수 증가 전 가져오기
			
			if(!(id.equals(dto.getBoard_id()))) {	//작성자 아이디와 로그인 아이디가 다를 경우에만 조회수 증가 
				dao.readCount(board_num);	//조회수 증가
			}
			dto = dao.getDetail(board_num);	//조회수 증가 후 가져오기
			request.setAttribute("dto", dto);
			
			ActionForward forward = new ActionForward();
			forward.setPath("board/boardView.jsp");
			forward.setRedirect(false);
			return forward;
		}
	}
}
