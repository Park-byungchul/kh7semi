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

@WebFilter(urlPatterns = {
		"/board/boardWrite.jsp", "/board/reviewWrite.jsp"
		})
public class BoardWriteFilter implements Filter{
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
		
		int boardTypeNo;
		try {
			boardTypeNo = Integer.parseInt(req.getParameter("boardTypeNo"));
		}
		catch(Exception e) {
			// 도서 리뷰 게시판의 경우
			boardTypeNo = 0;
		}
		
		// 403 조건
		// - 일반사용자가 공지사항 Write 접근
		boolean isNormal = false;
		if(clientDto != null && clientDto.getClientType().equals("일반사용자") && boardTypeNo == 1) {
			isNormal = true;
		}

		// login redirect 조건 : 비회원
		if(clientNo == 0) {
			resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
		}
		else if(isNormal) {
			resp.sendError(403);
		}
		else {
			chain.doFilter(request, response);
		}
	}
}