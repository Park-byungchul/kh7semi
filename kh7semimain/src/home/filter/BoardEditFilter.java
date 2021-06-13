package home.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardAnswerDao;
import library.beans.board.BoardAnswerDto;
import library.beans.board.BoardDao;
import library.beans.board.BoardDto;
import library.beans.board.ReviewDao;
import library.beans.board.ReviewDto;

@WebFilter(urlPatterns = {
	"/board/boardEdit.jsp", "/board/reviewEdit.jsp"
	})
public class BoardEditFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		int clientNo;
		try {
			clientNo = (int)req.getSession().getAttribute("clientNo");
		}
		catch(Exception e) {
			clientNo = 0;
		}

		int boardNo;
		BoardDao boardDao = new BoardDao();
		BoardDto boardDto;
		try {
			boardNo = Integer.parseInt(req.getParameter("boardNo"));
			boardDto = boardDao.get(boardNo);
		}
		catch(Exception e) {
			boardNo = 0;
			boardDto = null;
		}
		
		int reviewNo;
		ReviewDao reviewDao = new ReviewDao();
		ReviewDto reviewDto;
		try {
			reviewNo = Integer.parseInt(req.getParameter("reviewNo"));
			reviewDto = reviewDao.find(reviewNo);
		}
		catch(Exception e) {
			reviewNo = 0;
			reviewDto = null;
		}
		
		BoardAnswerDao answerDao = new BoardAnswerDao();
		BoardAnswerDto answerDto;
		try {
			answerDto = answerDao.get(boardNo);
		}
		catch(Exception e) {
			answerDto = null;
		}
		
		// 403 조건
		// (1) 자기가 작성한 글이 아님에도 edit 접근
		boolean isMine = true;
		if(boardDto != null) {
			if(clientNo != boardDto.getClientNo()) {
				isMine = false;
			}
		}
		else if(reviewDto != null) {
			if(reviewNo != reviewDto.getClientNo()) {
				isMine = false;
			}
		}
		// (2) 이미 답변완료된 글
		boolean isAnswer = false;
		if(answerDto != null) {
			if(answerDto.getBoardStatus().equals("답변완료")) {
				isAnswer = true;
			}
		}

		// login redirect 조건 : 비회원
		if(clientNo == 0) {
			resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
		}
		else if(!isMine || isAnswer) {
			resp.sendError(403);
		}
		else {
			chain.doFilter(request, response);
		}
	}
}
