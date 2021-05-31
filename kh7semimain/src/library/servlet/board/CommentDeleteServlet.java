package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BoardCommentDao;
import library.beans.BoardCommentDto;

@WebServlet (urlPatterns = "/board/commentDelete.kh")
public class CommentDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardCommentDto commentDto = new BoardCommentDto();
			commentDto.setCommentNo(Integer.parseInt(req.getParameter("commentNo")));
			commentDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			commentDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			
			BoardCommentDao commentDao = new BoardCommentDao();
			commentDao.delete(commentDto);
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+commentDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
