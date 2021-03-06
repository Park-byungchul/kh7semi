	package library.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BookDao;

@WebServlet(urlPatterns = "/book/bookDelete.kh")
public class BookDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			String bookIsbn = req.getParameter("bookIsbn");
			
			BookDao bookDao = new BookDao();
			bookDao.delete(bookIsbn);
			
			resp.sendRedirect("bookList.jsp");

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
