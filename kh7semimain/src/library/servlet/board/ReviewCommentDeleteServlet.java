package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ReviewCommentDao;
import library.beans.ReviewCommentDto;
import library.beans.ReviewDao;

@WebServlet (urlPatterns = "/board/reviewCommentDelete.kh")
public class ReviewCommentDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReviewCommentDto commentDto = new ReviewCommentDto();
			commentDto.setCommentNo(Integer.parseInt(req.getParameter("commentNo")));
			commentDto.setReviewNo(Integer.parseInt(req.getParameter("reviewNo")));
			commentDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			
			ReviewCommentDao commentDao = new ReviewCommentDao();
			commentDao.delete(commentDto);
			
			ReviewDao reviewDao = new ReviewDao();
			reviewDao.refreshComment(commentDto.getReviewNo());
			
			resp.sendRedirect("reviewDetail.jsp?reviewNo="+commentDto.getReviewNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
