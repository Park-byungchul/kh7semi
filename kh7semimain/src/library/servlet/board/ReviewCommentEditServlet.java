package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.ReviewCommentDao;
import library.beans.board.ReviewCommentDto;

@WebServlet (urlPatterns = "/board/reviewCommentEdit.kh")
public class ReviewCommentEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			ReviewCommentDto commentDto = new ReviewCommentDto();
			commentDto.setCommentNo(Integer.parseInt(req.getParameter("commentNo")));
			commentDto.setCommentField(req.getParameter("commentField"));
			commentDto.setReviewNo(Integer.parseInt(req.getParameter("reviewNo")));
			commentDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			
			ReviewCommentDao commentDao = new ReviewCommentDao();
			commentDao.edit(commentDto);
			
			resp.sendRedirect("reviewDetail.jsp?reviewNo="+commentDto.getReviewNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
