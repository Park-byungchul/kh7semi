package library.servlet.book;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BookDao;
import library.beans.BookDto;


@WebServlet(urlPatterns = "/book/bookEdit.kh")
public class BookEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BookDto bookDto = new BookDto();
			bookDto.setBookIsbn(req.getParameter("bookIsbn"));
			bookDto.setGenreNo(Integer.parseInt(req.getParameter("genreNo")));
			bookDto.setBookTitle(req.getParameter("bookTitle"));
			bookDto.setBookAuthor(req.getParameter("bookAuthor"));
			bookDto.setBookPublisher(req.getParameter("bookPublisher"));
			
			SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
			
			java.util.Date util_StartDate = format.parse(req.getParameter("bookDate"));
			java.sql.Date sql_StartDate = new java.sql.Date(util_StartDate.getTime());
			
			bookDto.setBookDate(sql_StartDate);
			bookDto.setBookContent(req.getParameter("bookContent"));
			bookDto.setBookImg(req.getParameter("bookImg"));
			
			BookDao bookDao = new BookDao();
			boolean result = bookDao.editBook(bookDto);
			
			if(result) {
				resp.sendRedirect("bookDetail.jsp?bookIsbn="+bookDto.getBookIsbn());
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
