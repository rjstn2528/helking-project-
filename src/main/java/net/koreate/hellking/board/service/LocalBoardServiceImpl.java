package net.koreate.hellking.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.LocalBoardDAO;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Service
@RequiredArgsConstructor
public class LocalBoardServiceImpl implements LocalBoardService {

    private final LocalBoardDAO dao;

    @Override
    public String regist(LocalBoardVO vo) throws Exception {
        dao.create(vo);
        return "등록 성공";
    }

    @Override
    public List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception {
        return dao.listSearch(cri);
    }

    @Override
    public int countSearch(LocalBoardSearchCriteria cri) throws Exception {
        return dao.countSearch(cri);
    }
    
    @Override
    public List<LocalBoardVO> listCriteria(BoardCriteria cri) throws Exception {
        return dao.listCriteria(cri);
    }

    @Override
    public LocalBoardVO read(int bno) throws Exception {
        return dao.read(bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        dao.updateCnt(bno);
    }

    @Override
    public String modify(LocalBoardVO vo) throws Exception {
        dao.update(vo);
        return "수정 성공";
    }

    @Override
    public String remove(int bno) throws Exception {
        dao.delete(bno);
        return "삭제 성공";
    }

    @Override
    public void plusAgree(int bno) throws Exception {
        dao.updateAgree(bno);
    }

    @Override
    public int AgreeCount(int bno) throws Exception {
        return dao.viewAgree(bno);
    }

    @Override
    public List<LocalBoardVO> getAllLocalPosts() throws Exception {
        return dao.selectAllLocalPosts();
    }

    @Override
    public List<LocalBoardVO> getLocalPostsByCategory(int categoryId) throws Exception {
        return dao.selectLocalPostsByCategory(categoryId);
    }
}
