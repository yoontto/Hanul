package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.commons.action.Action;
import com.commons.action.ActionForward;
import com.member.study.MemberDAO;
import com.member.study.MemberDTO;

public class MemberDetailAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		if(id == null) {		//로그인이 되어있지 않은 상태
			response.setContentType("text/html; charset=utf-8"); // alert 창 띄우려면 필요함
			PrintWriter out = response.getWriter(); 
			out.println("<script>alert('로그인하시기 바랍니다.');");
			out.println("location.href='memberLogin.me';</script>");
			return null;
		} else {	//로그인 되어있는 상태
			String member_id = request.getParameter("member_id");
			
			MemberDAO dao = new MemberDAO();
			MemberDTO dto =dao.getDetailMember(member_id);
			request.setAttribute("dto", dto);
			
			ActionForward forward = new ActionForward();
			forward.setPath("member/memberDetailForm.jsp");
			forward.setRedirect(false);
			return forward;
		}
	}
}
