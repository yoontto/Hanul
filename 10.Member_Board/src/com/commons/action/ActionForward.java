package com.commons.action;

public class ActionForward {
	private String path;		//view page(*.jsp)의 경로와 파일명
	private boolean isRedirect;	//페이지 전환방식 -> true : sendRedirect(), false : forward()
	public String getPath() {
		return path;
	}
	public void setPath(String path) {
		this.path = path;
	}
	public boolean isRedirect() {
		return isRedirect;
	}
	public void setRedirect(boolean isRedirect) {
		this.isRedirect = isRedirect;
	}

	//getter, setter로 접근
	
	
	
}


