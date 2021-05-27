package library.servlet.hopelist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.HopelistDao;
import library.beans.HopelistDto;

@WebServlet(urlPatterns = "/hopelist/hopelistEdit.kh")
public class hopelistEditServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//파라미터(hopelistNo,bookIsbn,hopelistReason,hopelistLibrary)+세션(clientNo)
			req.setCharacterEncoding("UTF-8");
			HopelistDto hopelistDto = new HopelistDto();
			hopelistDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			hopelistDto.setBookIsbn(Integer.parseInt(req.getParameter("bookIsbn")));
			hopelistDto.setHopelistNo(Integer.parseInt(req.getParameter("hopelistNo")));
			hopelistDto.setHopelistLibrary(req.getParameter("hopelistLibrary"));
			hopelistDto.setHopelistReason(req.getParameter("hopelistReason"));
			
			//처리
			HopelistDao hopelistDao = new HopelistDao();
			hopelistDao.edit(hopelistDto);
			
			//출력
			resp.sendRedirect("hopelistDetail.jsp?hopelistNo="+hopelistDto.getHopelistNo());
		}
		catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
