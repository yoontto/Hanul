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

public class MemberViewAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// MemberDeleteAction에서 복사해옴

		request.setCharacterEncoding("utf-8");
		// 관리자가 아닌데도 회원 삭제하는 요청이 있을 수 있음->방지해야 함
		// 세션에서 값을 가져와서 관리자인지 확인해야 함 (MemberListAction에서 가져옴)
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");

		// 관리자 아닐경우 비정상적 접근임을 알려줘야 함
		// session값이 admin일 경우만 실행
		response.setContentType("text/html; charset=utf-8"); // alert 창 띄우려면 필요함
		PrintWriter out = response.getWriter(); // 스크립트 작성위해 만들어주기
		if (id == null) { // 로그인이 안된 상태
			out.println("<script>alert('로그인하시기 바랍니다.');");
			out.println("location.href='memberLogin.me';</script>");
			return null;
		} else if (!id.equals("admin")) { // admin이 아닌 다른 id로 로그인 된 경우(false)
			out.println("<script>alert('관리자가 아닙니다.');");
			out.println("location.href='boardList.bo';</script>");
			return null;
		} else { // admin(관리자)로 로그인한 상태, 정상 비즈니스 로직 실행
			String member_id = request.getParameter("member_id"); // 삭제할 멤버 아이디 받아오기
			MemberDAO dao = new MemberDAO();
			MemberDTO dto = dao.getDetailMember(member_id); // dao 가서 메소드 만들기
			request.setAttribute("dto", dto);				//메소드 만들고 나서 dto로 받아주기

			ActionForward forward = new ActionForward();
			forward.setPath("member/memberInfo.jsp");	//jsp 만들어주기
			forward.setRedirect(false); //url 바뀌면 안됨
			return forward;
		}
	}
}
