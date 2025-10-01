DROP TABLE hell_comment PURGE;

CREATE TABLE hell_comment (
    cno         NUMBER PRIMARY KEY,          -- 댓글 번호
    bno         NUMBER NOT NULL,             -- 게시글 번호
    content     VARCHAR2(1000) NOT NULL,     -- 댓글 내용
    username    VARCHAR2(50) NOT NULL,      -- 작성자 (닉네임으로 처리할거임!)
    regdate     DATE DEFAULT SYSDATE,        -- 작성일
    updatedate  DATE DEFAULT SYSDATE,         -- 수정일
    CONSTRAINT fk_comment_user FOREIGN KEY (username)
        REFERENCES hk_users(username) ON DELETE CASCADE
);

CREATE SEQUENCE hell_comment_seq START WITH 1 INCREMENT BY 1;

COMMIT

ALTER TABLE hell_comment 
ADD parent_cno NUMBER NULL;

-- FK 제약 (너무어려워 이런걸어떻게해)
ALTER TABLE hell_comment 
ADD CONSTRAINT fk_comment_parent 
FOREIGN KEY (parent_cno) REFERENCES hell_comment(cno) ON DELETE CASCADE;
