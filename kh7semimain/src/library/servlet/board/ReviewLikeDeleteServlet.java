package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.ReviewDao;
import library.beans.board.ReviewLikeDao;
import library.beans.board.ReviewLikeDto;

@WebServlet (urlPatterns = "/board/reviewLikeDelete.kh")
public class ReviewLikeDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReviewLikeDto reviewLikeDto = new ReviewLikeDto();
			reviewLikeDto.setClientNo(Integer.parseInt(req.getParameter("clientNo")));
			reviewLikeDto.setReviewNo(Integer.parseInt(req.getParameter("reviewNo")));
			
			ReviewLikeDao reviewLikeDao = new ReviewLikeDao();
			reviewLikeDao.delete(reviewLikeDto);
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.refreshBoardLike(reviewLikeDto.getReviewNo());
			
			resp.sendRedirect("reviewDetail.jsp?reviewNo="+reviewLikeDto.getReviewNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
