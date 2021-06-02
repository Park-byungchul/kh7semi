package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.BoardAnswerDao;
import library.beans.BoardAnswerDto;
import library.beans.BoardDao;
import library.beans.BoardDto;

@WebServlet (urlPatterns = "/board/boardAnswer.kh")
public class AnswerInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardAnswerDto answerDto = new BoardAnswerDto();
			answerDto.setBoardNo(Integer.parseInt(req.getParameter("boardNo")));
			answerDto.setAnswerContent(req.getParameter("answerContent"));
			
			int clientNo = (int)req.getSession().getAttribute("clientNo");
			answerDto.setClientNo(clientNo);

			BoardAnswerDao answerDao = new BoardAnswerDao();
			answerDao.answer(answerDto);
			
			resp.sendRedirect("qnaDetail.jsp?boardNo="+answerDto.getBoardNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
