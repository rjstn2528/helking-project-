package net.koreate.hellking.board.dao;

import java.util.List;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

public interface LocalBoardDAO {
	
    void create(LocalBoardVO vo) throws Exception;

    List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception;
    
    List<LocalBoardVO> listCriteria(BoardCriteria cri) throws Exception;

    int countSearch(LocalBoardSearchCriteria cri) throws Exception;

    LocalBoardVO read(int bno) throws Exception;

    void updateCnt(int bno) throws Exception;

    void update(LocalBoardVO vo) throws Exception;

    void delete(int bno) throws Exception;

    void updateAgree(int bno) throws Exception;

    int viewAgree(int bno) throws Exception;

    List<LocalBoardVO> selectAllLocalPosts() throws Exception;

    List<LocalBoardVO> selectLocalPostsByCategory(int categoryId) throws Exception;
}
