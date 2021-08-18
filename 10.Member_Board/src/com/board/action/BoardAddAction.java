package com.board.action;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.board.study.BoardDAO;
import com.board.study.BoardDTO;
import com.commons.action.Action;
import com.commons.action.ActionForward;
import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

public class BoardAddAction implements Action {
	@Override
	public ActionForward excute(HttpServletRequest request, HttpServletResponse response)
		throws ServletException, IOException {
		//boardwrite에서 넘어오는 파일 첨부를 어떻게 완성할까?!

		/*String saveFoler = "boardupload";
		String realFolder = request.getRealPath(saveFoler);
		System.out.println(realFolder);*/

		String realFolder = "";	//업로드한 파일이 저장되는 위치
		realFolder = "D:\\Study_Web\\workspace\\10.Member_Board\\WebContent\\boardupload";
		int fileSize = 5 * 1024 * 1024;	//파일의 최대 용량 : 5MB
					//byte	kb	   kb
		
		MultipartRequest multi = null;	//파일업로드 처리
		DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();	//파일명의 중복 방지
		multi = new MultipartRequest(request, realFolder, fileSize, "utf-8", policy);
		
		//파일 첨부시에는 form에 enctype 선언해주고, action(넘길 때) MultipartRequest 만들어줘야 함
		
		BoardDTO dto = new BoardDTO();
		dto.setBoard_id(multi.getParameter("board_id"));	//request -> multi
		dto.setBoard_subject(multi.getParameter("board_subject"));	
		dto.setBoard_content(multi.getParameter("board_content"));	
		//dto.setBoard_file(multi.getParameter("board_file"));
		
		/*System.out.println(multi.getParameter("board_id"));
		System.out.println(multi.getParameter("board_file"));	//null : 파일명에 대한 중복검사를 수행하지 않겠다, 같은파일 올릴시 자동으로 전체 파일명 뒤에 번호 붙여줌
		//파일명이 다르게 DB에 저장되기 때문에 새롭게 부여된 파일명을 저장해줘야 해서 추후 컬럼도 추가된다.
		System.out.println(multi.getFilesystemName((String) multi.getFileNames().nextElement()));*/	//멀티에서 파일 이름 가져와서 그 다음 요소를 넘겨줘라!(스트링 캐스팅)
	
		dto.setBoard_file(multi.getFilesystemName((String) multi.getFileNames().nextElement()));
		
		BoardDAO dao = new BoardDAO();
		int succ= dao.boardInsert(dto);	//board 단에서는 jdbc framework 사용
		//지금은 트리거 사용할거지만, 실제 현장에서는 시퀀스 더 많이 사용함
		
		response.setContentType("text/html; charset=utf-8");
		PrintWriter out = response.getWriter();
		if(succ > 0) {
			out.println("<script> alert('등록성공')");
			out.println("location.href='boardList.bo';");
			out.println("</script>");
		}
		return null;
	}
}
