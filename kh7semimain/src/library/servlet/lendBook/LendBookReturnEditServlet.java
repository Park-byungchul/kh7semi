package library.servlet.lendBook;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.LendBookDao;
import library.beans.LendBookDto;

@WebServlet(urlPatterns = "/lendBook/lendBookUpdate.kh")
public class LendBookReturnEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			LendBookDao lendBookDao = new LendBookDao();
			boolean success = lendBookDao.lendBookUpdate(Integer.parseInt(req.getParameter("getBookNo")));
			
			if (success) {
				resp.sendRedirect("lendBookUpdate.jsp");
			}
			else {
				resp.sendRedirect("lendBookUpdateFail.jsp");
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
