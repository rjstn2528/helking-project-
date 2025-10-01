package net.koreate.hellking.board.service;

import java.util.List;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

public interface LocalBoardService {

    // 글 등록
    String regist(LocalBoardVO vo) throws Exception;

    // 글 목록 (검색/페이징)
    List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception;
    
    List<LocalBoardVO> listCriteria(BoardCriteria cri) throws Exception;

    // 검색 조건 포함 총 게시글 수
    int countSearch(LocalBoardSearchCriteria cri) throws Exception;

    // 글 읽기
    LocalBoardVO read(int bno) throws Exception;

    // 조회수 증가
    void updateCnt(int bno) throws Exception;

    // 글 수정
    String modify(LocalBoardVO vo) throws Exception;

    // 글 삭제
    String remove(int bno) throws Exception;

    // 추천 +1
    void plusAgree(int bno) throws Exception;

    // 추천 수 조회
    int AgreeCount(int bno) throws Exception;

    // 모든 게시글 조회
    List<LocalBoardVO> getAllLocalPosts() throws Exception;

    // 카테고리별 게시글 조회
    List<LocalBoardVO> getLocalPostsByCategory(int categoryId) throws Exception;
}
