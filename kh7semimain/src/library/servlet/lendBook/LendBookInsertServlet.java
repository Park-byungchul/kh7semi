package library.servlet.lendBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.LendBookDao;
import library.beans.LendBookDto;

@WebServlet(urlPatterns = "/lendBook/lendBookInsert.kh")
public class LendBookInsertServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 회원번호, 입고번호, 책번호, 지점번호 수신 
			LendBookDto lendBookDto = new LendBookDto();
			lendBookDto.setClientNo(Integer.parseInt(req.getParameter("clientNo")));
			lendBookDto.setGetBookNo(Integer.parseInt(req.getParameter("getBookNo")));
			lendBookDto.setBookIsbn(Long.parseLong(req.getParameter("bookIsbn")));
			lendBookDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			
			//계산
			LendBookDao lendBookDao = new LendBookDao();
			lendBookDao.lendBookInsert(lendBookDto);
			
			//출력
			resp.sendRedirect("lendBookInsert.jsp");
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
