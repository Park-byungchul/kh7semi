package library.servlet.area;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet(urlPatterns = "/areaSelect.kh")
public class AreaSelectServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int areaNo = Integer.parseInt(req.getParameter("areaNo"));
			
			req.getSession().removeAttribute("areaNo");
			req.getSession().setAttribute("areaNo", areaNo);
			
			resp.sendRedirect(req.getContextPath());
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
