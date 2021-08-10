package com.hanul.study;

import java.io.InputStream;
import java.util.List;

import org.apache.ibatis.io.Resources;
import org.apache.ibatis.session.SqlSession;
import org.apache.ibatis.session.SqlSessionFactory;
import org.apache.ibatis.session.SqlSessionFactoryBuilder;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

public class MemberDAO {
   //기존 JDBC Frame Work에서는 Connection(연결객체)을 먼저 만들었지만,
   //myBatis Frame Work의 경우 SqlSessionFactory 객체를 먼저 생성
   private static SqlSessionFactory sqlMapper;
   static {
      try {
         String resource = "com/hanul/mybatis/SqlMapConfig.xml";
         InputStream inputStream = Resources.getResourceAsStream(resource);
         sqlMapper = new SqlSessionFactoryBuilder().build(inputStream);
      } catch (Exception e) {
         e.printStackTrace();
         System.out.println("SqlSessionFactory Exception!!!");
      }
   }//static(초기화 블럭)
   
   //memberSearchAllJson01() : 전체회원 목록을 검색한 후 JSON 구조로 리턴
    public String memberSearchAllJson01() {
       SqlSession session = sqlMapper.openSession();
       List<MemberDTO> list = null;
       list = session.selectList("memberSearchAllJson01");	//Mapper의 select문을 실행해주는 명령어
       //selectList로 SQL 실행 후, 그를 리스트로 반환해줌 
       session.close();
       
       JSONArray array = new JSONArray();
       JSONObject object = null;
       //JSONObject는 객체를 Json객체로 바꿔주거나 json객체를 새로 만드는 역할을 함
       
       for (MemberDTO dto : list) {	//SQL실행해서 가져온 모든 멤버의 정보를 DTO타입의 list로 만들어서 배열 길이만큼 반복해줌
		object = new JSONObject();	//제이슨 객체 생성
		object.put("member", dto);	//0번 데이터에 member라는 키값의 dto list 데이터 넣어줌("mamber": ["name" : "홍길동", "age" : 22 ~~~])
		array.add(object);			//변환한 객체의 데이터를 JSONarray에 추가해줌			 
	}
       
       String json = array.toString();	//jsonArray 배열을 문자열로 바꿔줌 
       return json;						//
    }//memberSearchAllJson01()
   
  //memberSearchAllJson02()
   public String memberSearchAllJson02() {
	   SqlSession session = sqlMapper.openSession();
       List<MemberDTO> list = null;
       list = session.selectList("memberSearchAllJson01");
       session.close();
       
       JSONArray array = JSONArray.fromObject(list); 
       //fromObject : dto타입의 list를 간단히 array로 만드는 함수
       String json = array.toString();
       return json;
    
   }
    
}//class