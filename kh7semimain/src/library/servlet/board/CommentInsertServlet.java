package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardCommentDao;
import library.beans.board.BoardCommentDto;
import library.beans.board.BoardDao;

@WebServlet (urlPatterns = "/board/commentInsert.kh")
public class CommentInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardCommentDto commentDto = new BoardCommentDto();
			commentDto.setCommentContent(req.getParameter("commentContent"));
			commentDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			commentDto.setBoardTypeNo(Integer.parseInt(req.getParameter("boardTypeNo")));
			
			int clientNo = (int)req.getSession().getAttribute("clientNo");
			commentDto.setClientNo(clientNo);
			
			BoardCommentDao commentDao = new BoardCommentDao();
			commentDao.insert(commentDto);
			
			BoardDao boardDao = new BoardDao();
			boardDao.refreshComment(commentDto.getBoardNo());
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+commentDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
