package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ReviewDao;

@WebServlet (urlPatterns = "/board/reviewDelete.kh")
public class ReviewDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int reviewNo = Integer.parseInt(req.getParameter("reviewNo"));

			ReviewDao reviewDao = new ReviewDao();
			reviewDao.delete(reviewNo);

			resp.sendRedirect("reviewList.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
