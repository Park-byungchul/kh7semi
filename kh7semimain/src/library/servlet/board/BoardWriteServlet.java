package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BoardDao;
import library.beans.BoardDto;

@WebServlet (urlPatterns = "/board/boardWrite.kh")
public class BoardWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardTypeNo(Integer.parseInt(req.getParameter("boardTypeNo")));
			boardDto.setBoardTitle(req.getParameter("boardTitle"));
			boardDto.setBoardField(req.getParameter("boardField"));
			
			// 이 부분은 Attribute Name이 다를 수도 있으니 유의할 것.
			int memberNo = (int)req.getSession().getAttribute("memberNo");
			boardDto.setClientNo(memberNo);
			
			BoardDao boardDao = new BoardDao();
			int boardNo = boardDao.getSequence();
			boardDto.setBoardNo(boardNo);
			
			// 답글인지 새글인지 처리하는 코드 추가해야 함
			
			boardDao.write(boardDto);
			
			resp.sendRedirect("boardDetail.jsp?boardNo="+boardNo);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
