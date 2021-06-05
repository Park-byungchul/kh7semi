package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.ReviewDao;
import library.beans.board.ReviewDto;

@WebServlet (urlPatterns = "/board/reviewEdit.kh")
public class ReviewEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setReviewNo(Integer.parseInt(req.getParameter("reviewNo")));
			reviewDto.setBookIsbn(req.getParameter("bookIsbn"));
			reviewDto.setReviewSubject(req.getParameter("reviewSubject"));
			reviewDto.setReviewContent(req.getParameter("reviewContent"));

			ReviewDao reviewDao = new ReviewDao();
			reviewDao.edit(reviewDto);
			
			resp.sendRedirect("reviewDetail.jsp?reviewNo="+reviewDto.getReviewNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
