package library.servlet.reservation;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ReservationDao;
import library.beans.ReservationDto;

@WebServlet(urlPatterns = "/reservation/reservationInsert.kh")
public class ReservationInsertServlet extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			//파라미터(bookIsbn,hopelistLibrary,hopelistReason),세션(clientNo)
			ReservationDto reservationDto = new ReservationDto();
			int clientNo = Integer.parseInt(req.getParameter("clientNo"));
			reservationDto.setClientNo(clientNo);
			reservationDto.setGetBookNo(Integer.parseInt(req.getParameter("getBookNo")));
			
			ReservationDao reservationDao = new ReservationDao();
			
			
			
			//처리
			reservationDao.reservate(reservationDto);
			String root = req.getContextPath();
			resp.sendRedirect(root+"/getBook/getBookDetail.jsp?getBookNo="+reservationDto.getGetBookNo());

		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}