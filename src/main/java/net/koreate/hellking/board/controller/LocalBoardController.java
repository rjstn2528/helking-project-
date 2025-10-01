package net.koreate.hellking.board.controller;

import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import net.koreate.hellking.board.service.LocalBoardService;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.util.LocalBoardSearchCriteria;
import net.koreate.hellking.board.vo.LocalBoardVO;

@Controller
@RequiredArgsConstructor
@Slf4j
public class LocalBoardController {

    private final LocalBoardService service;

    /**
     * 글쓰기 페이지
     */
    @GetMapping("board/localregister")
    public void register() throws Exception {
        log.info("지역 게시판 글쓰기 페이지 요청");
    }

    /**
     * 글 등록 처리
     */
    @PostMapping("board/localregister")
    public String registerPost(LocalBoardVO board, HttpSession session) throws Exception {
        log.info("지역 게시판 글 등록: {}", board);
        String result = service.regist(board);
        session.setAttribute("msg", result);
        return "redirect:/board/localboard";
    }

    /**
     * 지역 게시판 목록 페이지 (검색 + 카테고리 필터링)
     */
    @GetMapping("board/localboard")
    public String localboard(LocalBoardSearchCriteria cri, Model model) throws Exception {
        log.info("지역 게시판 목록 요청: {}", cri);

        // 기본 보정
        if (cri.getPage() <= 0) cri.setPage(1);
        if (cri.getPerPageNum() <= 0) cri.setPerPageNum(10);

        // 게시글 목록
        List<LocalBoardVO> allList = service.listSearch(cri);
        model.addAttribute("allList", allList);

        // 페이지 정보
        BoardPageMaker pm = new BoardPageMaker();
        pm.setCri(cri);
        pm.setTotalCount(service.countSearch(cri));
        model.addAttribute("pm", pm);

        return "board/localboard";
    }

    /**
     * 카테고리 선택 시 AJAX 요청 → JSON 반환
     */
    @GetMapping("board/localboard/{category_id}")
    @ResponseBody
    public List<LocalBoardVO> findCategory(@PathVariable int category_id) throws Exception {
        if (category_id == 0) {
            log.info("전체 지역 글 조회");
            return service.getAllLocalPosts();
        } else {
            log.info("지역별 글 조회: category_id={}", category_id);
            return service.getLocalPostsByCategory(category_id);
        }
    }

    /**
     * 글 상세보기
     */
    @GetMapping("board/localreadPage")
    public String readPage(@RequestParam("bno") int bno, Model model, HttpSession session) throws Exception {
        service.updateCnt(bno);
        LocalBoardVO board = service.read(bno);
        model.addAttribute("list", board);

        // 결과 메시지 처리
        String result = (String) session.getAttribute("result");
        if (result != null) {
            model.addAttribute("result", result);
            session.removeAttribute("result");
        }

        return "board/localread";
    }

    /**
     * 글 수정 페이지
     */
    @GetMapping("board/localmodify")
    public String modifyForm(@RequestParam("bno") int bno, Model model) throws Exception {
        LocalBoardVO board = service.read(bno);
        model.addAttribute("board", board);
        return "board/localmodify";
    }

    /**
     * 글 수정 처리
     */
    @PostMapping("board/localmodify")
    public String modify(LocalBoardVO board, HttpSession session) throws Exception {
        String result = service.modify(board);
        session.setAttribute("result", result);
        return "redirect:/board/localreadPage?bno=" + board.getBno();
    }

    /**
     * 글 삭제 처리
     */
    @PostMapping("board/localremove")
    public String remove(@RequestParam("bno") int bno, HttpSession session) throws Exception {
        String result = service.remove(bno);
        session.setAttribute("result", result);
        return "redirect:/board/localboard";
    }

    /**
     * 추천 처리
     */
    @PostMapping("board/localagree")
    @ResponseBody
    public int plusAgree(@RequestParam("bno") int bno) throws Exception {
        service.plusAgree(bno);
        int result = service.AgreeCount(bno);
        log.info("추천 완료: bno={}, 현재 추천수={}", bno, result);
        return result;
    }
}
