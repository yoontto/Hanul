package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.commons.action.Action;
import com.commons.action.ActionForward;
import com.member.study.MemberDAO;
import com.member.study.MemberDTO;

public class MemberListAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		HttpSession session = request.getSession();
		String id = (String) session.getAttribute("id");
		
		//관리자 아닐경우 비정상적 접근임을 알려줘야 함
		//session값이 admin일 경우만 실행
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(id == null) {	//로그인이 안된 상태
			out.println("<script>alert('로그인하시기 바랍니다.');");
			out.println("location.href='memberLogin.me';</script>");
			return null;
		} else if(!id.equals("admin")) {	//admin이 아닌 다른 id로 로그인 된 경우(false)
			out.println("<script>alert('관리자가 아닙니다.');");
			out.println("location.href='boardList.bo';</script>");
			return null;
		} else {	//admin(관리자로 로그인한 상태)
			//out.println("<script>alert('관리자로 로그인 하셨습니다.');</script>");
			//return null;
			MemberDAO dao = new MemberDAO();
			List<MemberDTO> list = dao.getMember_AllList();	//모든 사용자 정보 리스트로 받아옴
			request.setAttribute("list", list);	//리스트 객체에 받아온 리스트 넣어줌
			
			ActionForward forward = new ActionForward();
			forward.setPath("member/memberList.jsp");	//memberList.jsp 만들어주기
			forward.setRedirect(false);// url 안바뀌게 (포워드 방식)
			return forward;
		}
	}
}
