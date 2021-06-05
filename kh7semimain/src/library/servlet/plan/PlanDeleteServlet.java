package library.servlet.plan;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.PlanDao;

@WebServlet(urlPatterns = "/plan/planDelete.kh")
public class PlanDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			int planNo = Integer.parseInt(req.getParameter("planNo"));
			
			PlanDao planDao = new PlanDao();
			planDao.delete(planNo);
			
			resp.sendRedirect(req.getContextPath()+"/plan/plan.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
