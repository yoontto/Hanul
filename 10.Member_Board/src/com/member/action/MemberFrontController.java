package com.member.action;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.commons.action.Action;
import com.commons.action.ActionForward;


/**
 * Servlet implementation class MemberFrontController
 */
@WebServlet("/MemberFrontController.me")
public class MemberFrontController extends HttpServlet {
	protected void service(HttpServletRequest request, HttpServletResponse response) 
		throws ServletException, IOException {
		//1. 클라이언트가 어떤 요청을 했는가를 파악
		request.setCharacterEncoding("utf-8");
		String uri = request.getRequestURI();
		String ctx = request.getContextPath();
		String command = uri.substring(ctx.length());
		System.out.println("uri" + uri);
		System.out.println("ctx" + ctx);
		System.out.println("command" + command);
		
		//2. 클라이언트의 요청과 실제 처리할 비지니스 로직 연결
		// *.me -> command -> Member~~~Action.java
		Action action = null;
		ActionForward forward = null;
		
		if(command.equals("/memberLogin.me")) {	 //슬래쉬 꼭 입력해야 함
			//로그인 화면으로 이동 : DB 연동X
			forward = new ActionForward();
			forward.setPath("member/memberLoginForm.jsp");
		}
		
		
		//3. 페이지전환 방식 정해줘야 함 redirect or forward
		if(forward != null) {	//true : sendRedirect()
			 if(forward.isIdRedirect()) {   //true : sendRedirect()
	            response.sendRedirect(forward.getPath());
	         }else {                     //false : forward()
	            RequestDispatcher rd = request.getRequestDispatcher(forward.getPath());
	            rd.forward(request, response);
	         }
		}
	}
}


