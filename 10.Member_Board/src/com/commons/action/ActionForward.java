package com.commons.action;

public class ActionForward {
	private String path;		//view page(*.jsp)의 경로와 파일명
	private boolean idRedirect;	//페이지 전환방식 -> true : sendRedirect(), false : forward()

	//getter, setter로 접근
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isIdRedirect() {
		return idRedirect;
	}
	public void setIdRedirect(boolean idRedirect) {
		this.idRedirect = idRedirect;
	}
	
	
}
