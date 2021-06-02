package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ReviewDao;
import library.beans.ReviewDto;

@WebServlet (urlPatterns = "/board/reviewInsert.kh")
public class ReviewInsertServelt extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReviewDto reviewDto = new ReviewDto();
			reviewDto.setBookIsbn(req.getParameter("bookIsbn"));
			reviewDto.setReviewSubject(req.getParameter("reviewSubject"));
			reviewDto.setReviewContent(req.getParameter("reviewContent"));
			
			int clientNo = (int)req.getSession().getAttribute("clientNo");
			reviewDto.setClientNo(clientNo);
			
			ReviewDao reviewDao = new ReviewDao();
			int reviewNo = reviewDao.getSequence();
			reviewDto.setReviewNo(reviewNo);
			
			reviewDao.write(reviewDto);

			resp.sendRedirect("reviewDetail.jsp?reviewNo="+reviewDto.getReviewNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
