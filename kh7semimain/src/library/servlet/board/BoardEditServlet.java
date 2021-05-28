package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BoardDao;
import library.beans.BoardDto;

@WebServlet (urlPatterns = "/board/boardEdit.kh")
public class BoardEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			boardDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			boardDto.setBoardTitle(req.getParameter("boardTitle"));
			boardDto.setBoardField(req.getParameter("boardField"));
			
			System.out.println(req.getParameter("boardNo"));
			System.out.println(req.getParameter("areaNo"));
			System.out.println(req.getParameter("boardTitle"));
			System.out.println(req.getParameter("boardField"));
			
			BoardDao boardDao = new BoardDao();
			boardDao.edit(boardDto);
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+boardDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
