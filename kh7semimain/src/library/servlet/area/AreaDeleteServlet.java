package library.servlet.area;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.AreaDao;

@WebServlet(urlPatterns = "/area/areaDelete.kh")
public class AreaDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int areaNo = Integer.parseInt(req.getParameter("areaNo"));
			
			AreaDao areaDao = new AreaDao();
			areaDao.delete(areaNo);
			
			resp.sendRedirect("areaList.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
