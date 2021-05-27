package library.servlet.getbook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.GetBookDao;

@WebServlet(urlPatterns = "/getBook/getBookDelete.kh")
public class getBookDelete extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int getBookNo = Integer.parseInt(req.getParameter("getBookNo"));
			
			GetBookDao getBookDao = new GetBookDao();
			getBookDao.delete(getBookNo);
			
			resp.sendRedirect("getBookList.jsp");
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
