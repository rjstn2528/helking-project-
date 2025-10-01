package net.koreate.hellking.board.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardSearchCriteria;
import net.koreate.hellking.board.vo.BoardVO;
import net.koreate.hellking.board.vo.FileVO;

public interface BoardDAO {
	
	/**
	 * @param board - 게시글 등록에 필요한 정보
	 * @return - 테이블에 삽입된 행의 개수
	 */
	int create(BoardVO board) throws Exception;
	
	/**
	 * @param bno - 조회할 게시글 번호
	 * @return - PK로 조회된 1개의 게시글 정보 반환
	 */
	BoardVO read(int bno) throws Exception;
	
	/**
	 * @param board - 수정할 게시글 정보
	 * @return - 수정된 행의 개수
	 */
	int update(BoardVO board) throws Exception;
	
	/**
	 * @param bno - 삭제할 게시글 번호
	 * @return - 처리후 삭제된 행의 개수 반환
	 */
	int delete(int bno) throws Exception;
	
	/**
	 * @param bno - 조회수 증가 할 게시글 번호
	 * 일치하는 게시글 번호를 가진 행의 viewcnt(조회수)컬럼의 데이터를 1증가
	 */
	void updateCnt(int bno) throws Exception;
	
	/**
	 * @return - 등록된 전체 게시글(행) 개수
	 */
	int totalCount() throws Exception;
	
	/**
	 * @param cri - 검색 기준
	 * @return - 검색 기준에 따라 조회된 게시글 목록
	 */
	List<BoardVO> listCriteria(BoardCriteria cri) throws Exception;
	
	/**
	 * 추천수 ~이상의 일정 게시물 조회
	 */
	List<BoardVO> getHotBoard(int HotAgree) throws Exception;
	
	/**
	 * @param bno - 추천수 증가 할 게시글 번호
	 * 일치하는 게시글 번호를 가진 행의 agree(추천수)의 데이터를 1증가
	 */
	void plusAgree(int bno) throws Exception;
	
	/**
	 * 증가가 있으면 감소가 있어야한다, 찬란한 빛에도 그림자는 있는 법이다.
	 */
	void minusAgree(int bno) throws Exception;
	
	/**
	 * 추천 수 증가 실시간 조회 ajax이용
	 */
	int AgreeCount(int bno) throws Exception;
	
	/**
	 * 추천 누가 하였는지, 그 유저가 이미 추천하였는지, 있으면 delete 없으면 insert
	 */
	boolean existsUserAgree(@Param("bno") int bno, @Param("userId") String userId);

	void insertUserAgree(@Param("bno") int bno, @Param("userId") String userId);

	void deleteUserAgree(@Param("bno") int bno, @Param("userId") String userId);
	
	/**
	 * 첨부파일 처리하는 기능
	 */
	int getLastInsertedBno();
	
	void insertFiles(List<FileVO> files);
	
	List<FileVO> getFilesByBno(@Param("bno") int bno, @Param("boardType") String boardType);
	
	/**
	 * 게시글 수정시에 첨부파일도 같이 업로드/삭제 수정가능하게
	 */
    FileVO findFileByFno(int fno) throws Exception;
    
    void deleteFile(int fno) throws Exception;
    
    List<BoardVO> listSearch(BoardSearchCriteria cri) throws Exception;
    
    int countSearch(BoardSearchCriteria cri) throws Exception;

    
    
	

	
}

