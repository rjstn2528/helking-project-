package net.koreate.hellking.board.dao;

import java.util.List;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.vo.SecretBoardVO;

public interface SecretBoardDAO {
	
    void create(SecretBoardVO board) throws Exception;
    
    List<SecretBoardVO> listCriteria(BoardCriteria cri) throws Exception;
    
    int totalCount() throws Exception;
    
    SecretBoardVO read(int bno) throws Exception;
    
    void updateCnt(int bno) throws Exception;

    void update(SecretBoardVO board) throws Exception;
    
    void delete(int bno) throws Exception;
    
    String getPassword(int bno) throws Exception;

    void updateAgree(int bno) throws Exception;
    
    int viewAgree(int bno) throws Exception;
}
