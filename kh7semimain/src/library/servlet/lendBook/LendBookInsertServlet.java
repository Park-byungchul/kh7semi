package library.servlet.lendBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.GetBookDao;
import library.beans.GetBookDto;
import library.beans.LendBookDao;
import library.beans.LendBookDto;

@WebServlet(urlPatterns = "/lendBook/lendBookInsert.kh")
public class LendBookInsertServlet extends HttpServlet{
	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : 회원번호, 입고번호, 책번호, 지점번호 수신 
			LendBookDto lendBookDto = new LendBookDto();
			GetBookDao getBookDao = new GetBookDao();
			GetBookDto getBookDto = getBookDao.get(Integer.parseInt(req.getParameter("getBookNo")));
			lendBookDto.setClientNo(Integer.parseInt(req.getParameter("clientNo")));
			lendBookDto.setGetBookNo(Integer.parseInt(req.getParameter("getBookNo")));
			lendBookDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo"))); 
			if(getBookDao.check(lendBookDto.getGetBookNo())) {
				lendBookDto.setBookIsbn(getBookDto.getBookIsbn()); //파라미터로 받지 않음. getBookNo 파라미터를 사용해 getBookDao에서 검색
				LendBookDao lendBookDao = new LendBookDao();
				if(lendBookDao.get(getBookDto.getGetBookNo())) {//누군가 빌린 기록이 view안에 들어있다면?
					resp.sendRedirect("lendBookInsertFail.jsp");
				}
				else if (lendBookDao.lendBookInsert(lendBookDto)){//정상적으로 insert 되었다면?
					resp.sendRedirect("lendBookInsert.jsp");
				}
				else {
					resp.sendRedirect("lendBookInsertFail2.jsp");//누군가 빌린 기록은 없지만 insert 안됐다면?
				}
			}
			else {
				resp.sendRedirect("lendBookInsertFail2.jsp");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
