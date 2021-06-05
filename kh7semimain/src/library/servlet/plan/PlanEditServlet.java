package library.servlet.plan;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.PlanDao;
import library.beans.PlanDto;

@WebServlet(urlPatterns = "/plan/planEdit.kh")
public class PlanEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			PlanDto planDto = new PlanDto();
			planDto.setPlanNo(Integer.parseInt(req.getParameter("planNo")));
			planDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			planDto.setPlanStartDate(Date.valueOf(req.getParameter("planStartDate")));
			planDto.setPlanEndDate(Date.valueOf(req.getParameter("planEndDate")));
			planDto.setPlanContent(req.getParameter("planContent"));
			
			PlanDao planDao = new PlanDao();
			planDao.edit(planDto);
			
			String[] date = req.getParameter("planStartDate").split("-");
			
			resp.sendRedirect(req.getContextPath()+"/plan/plan.jsp?year="+date[0]+"&month="+date[1]+"&day="+date[2]);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
