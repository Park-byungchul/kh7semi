package library.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import home.beans.ProductDao;
import home.beans.ProductDto;
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
			bookDto.setGenreNo(req.getParameter("GenreNo"));
			bookDto.setBookName(req.getParameter("bookName"));
			bookDto.setBookAuthor(req.getParameter("bookAuthor"));
			
			BookDao bookDao = new BookDao();
			boolean result = bookDao.editBook(bookDto);
			
			if(result) {
//				resp.sendRedirect("bookDetail.jsp?no="+bookDto.getBookIsbn());
				resp.sendRedirect("clientList.jsp");
			}

		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
