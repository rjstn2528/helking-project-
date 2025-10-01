package net.koreate.hellking.board.service;

import java.util.List;

import org.springframework.stereotype.Service;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.dao.SecretBoardDAO;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.vo.SecretBoardVO;

@Service
@RequiredArgsConstructor
public class SecretBoardServiceImpl implements SecretBoardService {

    private final SecretBoardDAO dao;

    @Override
    public String regist(SecretBoardVO board) throws Exception {
        dao.create(board);
        return "등록 성공";
    }

    @Override
    public List<SecretBoardVO> listCriteria(BoardCriteria cri) throws Exception {
        return dao.listCriteria(cri);
    }

    @Override
    public int totalCount() throws Exception {
        return dao.totalCount();
    }

    @Override
    public SecretBoardVO read(int bno) throws Exception {
        return dao.read(bno);
    }

    @Override
    public void updateCnt(int bno) throws Exception {
        dao.updateCnt(bno);
    }

    @Override
    public boolean modify(SecretBoardVO board, String password) throws Exception {
        String dbPw = dao.getPassword(board.getBno());
        if (dbPw != null && dbPw.equals(password)) {
            dao.update(board);
            return true;
        }
        return false;
    }

    @Override
    public boolean remove(int bno, String password) throws Exception {
        String dbPw = dao.getPassword(bno);
        if (dbPw != null && dbPw.equals(password)) {
            dao.delete(bno);
            return true;
        }
        return false;
    }

    @Override
    public void plusAgree(int bno) throws Exception {
        dao.updateAgree(bno);
    }

    @Override
    public int AgreeCount(int bno) throws Exception {
        return dao.viewAgree(bno);
    }
}
