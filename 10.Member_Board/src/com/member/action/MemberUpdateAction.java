package com.member.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.commons.action.Action;
import com.commons.action.ActionForward;
import com.member.study.MemberDAO;
import com.member.study.MemberDTO;

public class MemberUpdateAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		MemberDTO dto = new MemberDTO();
		dto.setMember_id(request.getParameter("member_id"));
		dto.setMember_pw(request.getParameter("member_pw"));
		dto.setMember_name(request.getParameter("member_name"));
		dto.setMember_age(Integer.parseInt(request.getParameter("member_age")));
		dto.setMember_gender(request.getParameter("member_gender"));
		dto.setMember_email(request.getParameter("member_email"));
		
		MemberDAO dao = new MemberDAO();
		int succ = dao.updateMember(dto);
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(succ > 0) {
			out.println("<script>");
			out.println("alert('수정성공')");
			out.println("location.href='memberDetailAction.me?member_id="+dto.getMember_id()+"';");
			out.println("</script>");
		} else {
			out.println("<script>");
			out.println("alert('수정실패')");
			out.println("location.href='memberDetailAction.me?member_id="+dto.getMember_id()+"';");
			out.println("</script>");
		}
		return null;		//ActionForward 타입의 리턴 줄게 없음(이동 없다는 뜻 -> 스크립트 태그로 이동하기 때문에)
	}
}
