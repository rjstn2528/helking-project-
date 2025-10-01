package net.koreate.hellking.board.dao;

import java.util.List;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Repository
@RequiredArgsConstructor
public class LocalBoardDAOImpl implements LocalBoardDAO {

    private final SqlSession session;
    private static final String NS = "localMapper";

    @Override
    public void create(LocalBoardVO vo) throws Exception {
        session.insert(NS + ".create", vo);
    }

    @Override
    public List<LocalBoardVO> listSearch(LocalBoardSearchCriteria cri) throws Exception {
        return session.selectList(NS + ".listSearch", cri);
    }
    
    @Override
    public List<LocalBoardVO> listCriteria(BoardCriteria cri) {
        return session.selectList(NS + ".listCriteria", cri);
    }

    @Override
    public int countSearch(LocalBoardSearchCriteria cri) throws Exception {
        return session.selectOne(NS + ".countSearch", cri);
    }

    @Override
    public LocalBoardVO read(int bno) throws Exception {
        return session.selectOne(NS + ".read", bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        session.update(NS + ".updateCnt", bno);
    }

    @Override
    public void update(LocalBoardVO vo) throws Exception {
        session.update(NS + ".update", vo);
    }

    @Override
    public void delete(int bno) throws Exception {
        session.delete(NS + ".delete", bno);
    }

    @Override
    public void updateAgree(int bno) throws Exception {
        session.update(NS + ".updateAgree", bno);
    }

    @Override
    public int viewAgree(int bno) throws Exception {
        return session.selectOne(NS + ".viewAgree", bno);
    }

    @Override
    public List<LocalBoardVO> selectAllLocalPosts() throws Exception {
        return session.selectList(NS + ".selectAllLocalPosts");
    }

    @Override
    public List<LocalBoardVO> selectLocalPostsByCategory(int categoryId) throws Exception {
        return session.selectList(NS + ".selectLocalPostsByCategory", categoryId);
    }
}
