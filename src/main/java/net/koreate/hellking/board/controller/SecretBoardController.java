package net.koreate.hellking.board.controller;

import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;

import lombok.RequiredArgsConstructor;
import net.koreate.hellking.board.service.SecretBoardService;
import net.koreate.hellking.board.util.BoardCriteria;
import net.koreate.hellking.board.util.BoardPageMaker;
import net.koreate.hellking.board.vo.SecretBoardVO;

import java.util.List;

@Controller
@RequiredArgsConstructor
public class SecretBoardController {

    private final SecretBoardService service;

    /** 글쓰기 페이지 */
    @GetMapping("board/secretregister")
    public void register() {}

    /** 글 등록 */
    @PostMapping("board/secretregister")
    public String registerPost(SecretBoardVO board, HttpSession session) throws Exception {
        String result = service.regist(board);
        session.setAttribute("msg", result);
        return "redirect:/board/secretboard";
    }

    /** 목록 */
    @GetMapping("board/secretboard")
    public String secretboard(BoardCriteria cri, Model model) throws Exception {
        List<SecretBoardVO> allList = service.listCriteria(cri);
        model.addAttribute("allList", allList);

        BoardPageMaker pm = new BoardPageMaker();
        pm.setCri(cri);
        pm.setTotalCount(service.totalCount());
        model.addAttribute("pm", pm);

        return "board/secretboard";
    }

    /** 상세보기 */
    @GetMapping("secretreadPage")
    public String readPage(@RequestParam("bno") int bno, Model model) throws Exception {
        service.updateCnt(bno);
        SecretBoardVO board = service.read(bno);
        model.addAttribute("list", board);
        return "board/secretread";
    }

    /** 글 수정 (비밀번호 확인 포함) */
    @PostMapping("board/secretmodify")
    public String modify(SecretBoardVO board,
                         @RequestParam("password") String password,
                         HttpSession session) throws Exception {
        boolean success = service.modify(board, password);
        session.setAttribute("result", success ? "수정 성공" : "비밀번호 불일치");
        return "redirect:/secretreadPage?bno=" + board.getBno();
    }

    /** 글 삭제 (비밀번호 확인 포함) */
    @PostMapping("board/secretremove")
    public String remove(@RequestParam("bno") int bno,
                         @RequestParam("password") String password,
                         HttpSession session) throws Exception {
        boolean success = service.remove(bno, password);
        session.setAttribute("result", success ? "삭제 성공" : "비밀번호 불일치");
        return "redirect:/board/secretboard";
    }

    /** 추천 */
    @PostMapping("board/secretagree")
    @ResponseBody
    public int plusAgree(@RequestParam("bno") int bno) throws Exception {
        service.plusAgree(bno);
        return service.AgreeCount(bno);
    }
}
