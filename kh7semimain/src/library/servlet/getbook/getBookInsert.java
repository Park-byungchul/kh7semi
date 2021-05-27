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

@WebServlet(urlPatterns = "/getBook/insert.kh")
public class getBookInsert extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			GetBookDto getBookDto = new GetBookDto();
			getBookDto.setGetBookNo(Integer.parseInt(req.getParameter("getBookNo")));
			getBookDto.setBookIsbn(Integer.parseInt(req.getParameter("bookIsbn")));
			getBookDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			getBookDto.setGetBookDate(Date.valueOf(req.getParameter("getBookDate")));
			getBookDto.setGetBookStatus(req.getParameter("getBookStatus"));
			
			GetBookDao getBookDao = new GetBookDao();
			getBookDao.insert(getBookDto);
			
			resp.sendRedirect("getBookInsertSuccess.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
