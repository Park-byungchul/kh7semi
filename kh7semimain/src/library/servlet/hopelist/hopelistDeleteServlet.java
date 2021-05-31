package library.servlet.hopelist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import library.beans.HopelistDao;




@WebServlet(urlPatterns="/hopelist/hopelistDelete.kh")
public class hopelistDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 : 파라미터(신청번호) 
			req.setCharacterEncoding("UTF-8");
			
			int hopelistNo = Integer.parseInt(req.getParameter("hopelistNo"));
						
			// 처리
			HopelistDao hopelistDao = new HopelistDao();
			hopelistDao.delete(hopelistNo);
			
			
			// 출력
			resp.sendRedirect("hopelist.jsp");
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
