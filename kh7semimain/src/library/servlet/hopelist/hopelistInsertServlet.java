package library.servlet.hopelist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.HopelistDao;
import library.beans.HopelistDto;

@WebServlet(urlPatterns = "/hopelist/hopelistInsert.kh")
public class hopelistInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			//파라미터(bookIsbn,hopelistLibrary,hopelistReason),세션(clientNo)
			HopelistDto hopelistDto = new HopelistDto();
			int clientNo = (int)req.getSession().getAttribute("clientNo");
			hopelistDto.setClientNo(clientNo);
			hopelistDto.setBookIsbn(Long.parseLong(req.getParameter("bookIsbn")));
			hopelistDto.setHopelistLibrary(req.getParameter("hopelistLibrary"));
			hopelistDto.setHopelistReason(req.getParameter("hopelistReason"));
			
			HopelistDao hopelistDao = new HopelistDao();
			
			int hopelistNo = hopelistDao.getSequence();//희망도서번호(DB시퀀스)
			hopelistDto.setHopelistNo(hopelistNo);	
			
			//처리
			hopelistDao.insert(hopelistDto);

			resp.sendRedirect("hopelistDetail.jsp?hopelistNo="+hopelistNo);

		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
