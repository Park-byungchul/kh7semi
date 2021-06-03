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
			//lendBookDto.setBookIsbn(Long.parseLong(req.getParameter("bookIsbn"))); //bookIsbn을 입력후 파라미터로 받는다면 이거사용
			lendBookDto.setBookIsbn(getBookDto.getBookIsbn()); //파라미터로 받지 않음. getBookNo 파라미터를 사용해 getBookDao에서 검색
			//lendBookDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));//이제 헤더에 지점 따라다닐예정이니 그거 받아오면됨
			lendBookDto.setAreaNo(1);
			
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
