package com.board.study;

import java.io.Serializable;

public class BoardSearchDTO implements Serializable{
	private String part, searchData;

	public String getPart() {
		return part;
	}

	public void setPart(String part) {
		this.part = part;
	}

	public String getSearchData() {
		return searchData;
	}

	public void setSearchData(String searchData) {
		this.searchData = searchData;
	}
 
}
