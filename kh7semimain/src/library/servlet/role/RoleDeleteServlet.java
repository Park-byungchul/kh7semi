package library.servlet.role;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.RoleAreaDao;
import library.beans.RoleDao;

@WebServlet(urlPatterns = "/role/roleDelete.kh")
public class RoleDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			int roleClientNo = Integer.parseInt(req.getParameter("roleClientNo"));
			int roleAreaNo = Integer.parseInt(req.getParameter("roleAreaNo"));
			
			RoleDao roleDao = new RoleDao();
			
			roleDao.delete(roleClientNo, roleAreaNo);

			String type = req.getParameter("type");
			if (type == null) {
				resp.sendRedirect("roleList.jsp");
			} else {
				resp.sendRedirect("rolePartialList.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
