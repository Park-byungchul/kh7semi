package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardCommentDao;
import library.beans.board.BoardCommentDto;

@WebServlet (urlPatterns = "/board/commentEdit.kh")
public class CommentEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardCommentDto commentDto = new BoardCommentDto();
			commentDto.setCommentNo(Integer.parseInt(req.getParameter("commentNo")));
			commentDto.setCommentContent(req.getParameter("commentContent"));
			commentDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			commentDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			
			BoardCommentDao commentDao = new BoardCommentDao();
			commentDao.edit(commentDto);
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+commentDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
