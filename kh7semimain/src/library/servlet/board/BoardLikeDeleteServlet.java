package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardDao;
import library.beans.board.BoardLikeDao;
import library.beans.board.BoardLikeDto;

@WebServlet (urlPatterns = "/board/boardLikeDelete.kh")
public class BoardLikeDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardLikeDto boardLikeDto = new BoardLikeDto();
			boardLikeDto.setClientNo(Integer.parseInt(req.getParameter("clientNo")));
			boardLikeDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			
			BoardLikeDao boardLikeDao = new BoardLikeDao();
			boardLikeDao.delete(boardLikeDto);
			
			BoardDao boardDao = new BoardDao();
			boardDao.refreshBoardLike(boardLikeDto.getBoardNo());
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+boardLikeDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
