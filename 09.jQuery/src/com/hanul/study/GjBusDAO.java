package com.hanul.study;

import java.net.URL;

import net.htmlparser.jericho.Source;

public class GjBusDAO {
	public Source makeJson() {
		Source source = null;
 		try {
			String addr = "http://api.gwangju.go.kr/json/lineInfo";
			URL url = new URL(addr);
			source = new Source(url);
		} catch (Exception e) {
			e.printStackTrace();
			System.out.println("makeJson() Exception!");
		}
 		return source;
	}
}
