package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardDao;

@WebServlet (urlPatterns = "/board/boardDelete.kh")
public class BoardDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			int boardNo = Integer.parseInt(req.getParameter("boardNo"));
			int boardTypeNo = Integer.parseInt(req.getParameter("boardTypeNo"));
			
			BoardDao boardDao = new BoardDao();
			boardDao.delete(boardNo);
			
			String url = "";
			if(boardTypeNo == 1) {
				url = "noticeList.jsp";
			}
			else if(boardTypeNo == 2) {
				url = "qnaList.jsp";
			}
			else if(boardTypeNo == 3) {
				url = "freeBoardList.jsp";
			}
			else if(boardTypeNo == 4) {
				url = "reviewList.jsp";
			}
			resp.sendRedirect(url);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
