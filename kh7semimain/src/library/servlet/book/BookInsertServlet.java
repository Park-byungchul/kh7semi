package library.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BookDao;
import library.beans.BookDto;

@WebServlet(urlPatterns = "/book/insert.kh")
public class BookInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			BookDto bookDto = new BookDto();
			bookDto.setBookIsbn(req.getParameter("bookIsbn"));
			bookDto.setGenreNo(req.getParameter("GenreNo"));
			bookDto.setBookName(req.getParameter("bookName"));
			bookDto.setBookAuthor(req.getParameter("bookAuthor"));
			
			BookDao bookDao = new BookDao();
			bookDao.insert(bookDto);
			
			resp.sendRedirect("bookInsertSuccess.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
