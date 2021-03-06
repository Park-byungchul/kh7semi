package library.servlet.board;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.board.BoardAnswerDao;
import library.beans.board.BoardDao;
import library.beans.board.BoardDto;

@WebServlet (urlPatterns = "/board/boardWrite.kh")
public class BoardWriteServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			BoardDto boardDto = new BoardDto();
			
			if(req.getParameter("areaNo") == null) {
				boardDto.setAreaNo(0);
			}
			else {
				boardDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			}
			
			boardDto.setBoardTypeNo(Integer.parseInt(req.getParameter("boardTypeNo")));
			boardDto.setBoardTitle(req.getParameter("boardTitle"));
			boardDto.setBoardField(req.getParameter("boardField"));
			boardDto.setBoardOpen(req.getParameter("boardOpen"));

			int clientNo = (int)req.getSession().getAttribute("clientNo");
			boardDto.setClientNo(clientNo);
			
			BoardDao boardDao = new BoardDao();
			int boardNo = boardDao.getSequence();
			boardDto.setBoardNo(boardNo);
			
			int boardTypeNo = Integer.parseInt(req.getParameter("boardTypeNo"));
			int boardSepNo = 0;
			if(boardTypeNo == 1) {
				boardSepNo = boardDao.getNoticeSequence();
			}
			else if(boardTypeNo == 2) {
				boardSepNo = boardDao.getQnaSequence();
			}
			else if(boardTypeNo == 3) {
				boardSepNo = boardDao.getFreeBoardSequence();
			}
			boardDto.setBoardSepNo(boardSepNo);

			boardDao.write(boardDto);
			
			if (boardTypeNo == 2) {
				BoardAnswerDao answerDao = new BoardAnswerDao();
				answerDao.receipt(boardNo);
				resp.sendRedirect("qnaDetail.jsp?boardNo="+boardNo);
			}
			else {
				resp.sendRedirect("boardDetail.jsp?boardNo="+boardNo);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
