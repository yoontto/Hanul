package com.member.study;

import java.io.IOException;
import java.io.InputStream;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

public class MemberDAO {	
	//DB 연동 : myBatis FrameWork, 라이브러리 추가해주기
	private static SqlSessionFactory sqlMapper;
	static {
		try {
			String resource = "com/hanul/mybatis/SqlMapConfig.xml";
			InputStream inputStream = Resources.getResourceAsStream(resource);
			sqlMapper = new SqlSessionFactoryBuilder().build(inputStream);
		} catch (IOException e) {
			e.printStackTrace();
			System.out.println("SqlSessionFactory Exception!");
		}
	}// static(초기화 블럭)
	
	//회원가입
	public int joinMember(MemberDTO dto) {
		SqlSession session = sqlMapper.openSession();
		int succ = 0;
		succ = session.insert("joinMember",dto);
		session.commit();
		session.close();
		return succ;
	}//joinMember()
	
	
	//회원가입
	public int isMember(MemberDTO dto) {
		SqlSession session = sqlMapper.openSession();		//검색하면 결과 하나 나오던지 null 나오던지
		MemberDTO isDTO = null;													//여러개 나오면 list 써야하는데 하나 나오니까 dto로 받아줌
		isDTO = session.selectOne("isMember",dto);
		session.close();
		
		int result = -1;
		if(isDTO != null) {	//아이디 존재, 패스워드 검사도 해줘야 함
			if(isDTO.getMember_pw().equals(dto.getMember_pw())) {
				result = 1;	//비밀번호 일치
			} else {
				result = 0; //비밀번호 불일치
			}
		} else {			//아이디가 존재하지 않는다
			result = -1;
		}
		
		return result;
	}//isMember()
}//class
