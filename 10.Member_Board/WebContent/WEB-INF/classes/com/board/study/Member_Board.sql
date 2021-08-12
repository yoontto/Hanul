-- 게시판 : memberBoard Table 생성
CREATE TABLE memberBoard(
Board_num NUMBER PRIMARY KEY NOT NULL,
Board_id VARCHAR2(15),
Board_subject VARCHAR2(50),
Board_content VARCHAR2(2000),
Board_file VARCHAR2(20),
Board_re_ref NUMBER,
Board_re_lev NUMBER,
Board_re_seq NUMBER,
Board_readcount NUMBER,
Board_date DATE
);

-- 전체레코드 검색
SELECT * FROM memberboard ORDER BY board_num DESC;

-- 제약조건 설정
ALTER TABLE memberBoard
    ADD CONSTRAINT pk_board_id FOREIGN KEY(board_id)
        REFERENCES boardMember(member_id)
            ON DELETE CASCADE;

-- 제약조건 제거 (해제)
ALTER TABLE memberBoard
    DROP CONSTRAINT pk_board_id;
    
DROP TABLE memberBoard PURGE;