package net.koreate.hellking.board.service;

import java.util.List;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.vo.SecretBoardVO;

public interface SecretBoardService {
	
    String regist(SecretBoardVO board) throws Exception;
    
    List<SecretBoardVO> listCriteria(BoardCriteria cri) throws Exception;
    
    int totalCount() throws Exception;
    
    SecretBoardVO read(int bno) throws Exception;
    
    void updateCnt(int bno) throws Exception;

    boolean modify(SecretBoardVO board, String password) throws Exception;
    
    boolean remove(int bno, String password) throws Exception;

    void plusAgree(int bno) throws Exception;
    
    int AgreeCount(int bno) throws Exception;
}
