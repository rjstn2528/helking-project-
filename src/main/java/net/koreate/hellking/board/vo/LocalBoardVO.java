package net.koreate.hellking.board.vo;

import java.util.Date;
import java.util.List;

import lombok.Data;

@Data
public class LocalBoardVO {
	
	    private int bno;
	    private String title;
	    private String content;
	    private String nickname;
	    private Date regdate;
	    private int viewcnt;
	    private int agree;
	    private int disagree;
	    private int category_id;
		private int HotAgree = 20;
		private List<FileVO> files;
		private String boardType; 

	}
