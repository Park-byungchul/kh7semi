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

import library.beans.ClientDao;
import library.beans.ClientDto;
import library.beans.board.BoardAnswerDao;
import library.beans.board.BoardAnswerDto;

@WebFilter(urlPatterns = {
		"/board/boardAnswer.jsp"
		})
public class BoardAnswerFilter implements Filter {
	@Override
	public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest)request;
		HttpServletResponse resp = (HttpServletResponse)response;

		int clientNo;
		ClientDao clientDao = new ClientDao();
		ClientDto clientDto;
		try {
			clientNo = (int)req.getSession().getAttribute("clientNo");
			clientDto = clientDao.get(clientNo);
		}
		catch(Exception e) {
			clientNo = 0;
			clientDto = null;
		}
		
		int boardNo;
		try {
			boardNo = Integer.parseInt(req.getParameter("boardNo"));
		}
		catch(Exception e) {
			boardNo = 0;
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
		// (1) 일반사용자가 답변에 접근
		boolean isAdmin = false;
		if(!clientDto.getClientType().equals("일반사용자")) {
			isAdmin = true;
		}
		// (2) 이미 답변완료된 글
		boolean isAnswer = false;
		if(answerDto != null) {
			if(answerDto.getBoardStatus().equals("답변완료")) {
				isAnswer = true;
			}
		}
		
		System.out.println(answerDto.getBoardStatus());

		// login redirect 조건 : 비회원
		if(clientNo == 0) {
			resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
		}
		else if(!isAdmin || isAnswer) {
			resp.sendError(403);
		}
		else {
			chain.doFilter(request, response);
		}
	}
}
