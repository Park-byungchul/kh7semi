package library.servlet.reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.HopelistDao;
import library.beans.ReservationDao;

@WebServlet(urlPatterns="/reservation/reservationDelete.kh")
public class ReservationDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			// 준비 : 파라미터(신청번호) 
			req.setCharacterEncoding("UTF-8");
			
			int clientNo = Integer.parseInt(req.getParameter("clientNo"));
			int getBookNo = Integer.parseInt(req.getParameter("getBookNo"));
			
			ReservationDao reservationDao = new ReservationDao();
			reservationDao.delete(clientNo, getBookNo);
			// 출력
			String root = req.getContextPath();
			resp.sendRedirect(root+"/getBook/getBookDetail.jsp?getBookNo="+getBookNo);
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}

}
