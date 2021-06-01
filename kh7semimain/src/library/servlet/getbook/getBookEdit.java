package library.servlet.getbook;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.GetBookDao;
import library.beans.GetBookDto;
import oracle.sql.DATE;

@WebServlet(urlPatterns = "/getBook/getBookEdit.kh")
public class getBookEdit extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			GetBookDto getBookDto = new GetBookDto();
			getBookDto.setGetBookNo(Integer.parseInt(req.getParameter("getBookNo")));
			getBookDto.setBookIsbn(Long.parseLong(req.getParameter("bookIsbn")));
			getBookDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			getBookDto.setGetBookDate(Date.valueOf(req.getParameter("getBookDate")));
			getBookDto.setGetBookStatus(req.getParameter("getBookStatus"));
			
			GetBookDao getBookDao = new GetBookDao();
			boolean result = getBookDao.editGetBook(getBookDto);
			
			if(result) {
//				resp.sendRedirect("getBookDetail.jsp?no="+getBookDto.getGetBookNo());
				resp.sendRedirect("getBookList.jsp");
			}
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
