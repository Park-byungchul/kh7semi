package library.servlet.recommend;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.RecommendDao;
import library.beans.RecommendDto;

@WebServlet(urlPatterns ="/recommend/recommendInsert.kh")
public class BookRecommendInsertServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : clientNo, bookIsbn
			req.setCharacterEncoding("UTF-8");
			RecommendDto recommendDto = new RecommendDto();
			recommendDto.setClientNo(Integer.parseInt(req.getParameter("clientNo"))); 
			recommendDto.setBookIsbn(req.getParameter("bookIsbn"));
			int getBookNo = Integer.parseInt(req.getParameter("getBookNo"));
			//처리
			RecommendDao recommendDao = new RecommendDao();
			recommendDao.insert(recommendDto);
			String root = req.getContextPath();
			
			//출력 : 책 디테일로 복귀
			resp.sendRedirect(root+"/getBook/getBookDetail.jsp?getBookNo="+getBookNo);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
