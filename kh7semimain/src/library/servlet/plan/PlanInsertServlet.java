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

@WebServlet(urlPatterns = "/plan/planInsert.kh")
public class PlanInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			PlanDto planDto = new PlanDto();
			planDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			planDto.setPlanContent(req.getParameter("planContent"));
			planDto.setPlanStartDate(Date.valueOf(req.getParameter("planStartDate")));
			planDto.setPlanEndDate(Date.valueOf(req.getParameter("planEndDate")));
			
			PlanDao planDao = new PlanDao();
			planDao.insert(planDto);
			
			String date = req.getParameter("planStartDate");
			
			resp.sendRedirect(req.getContextPath() + "/plan/plan.jsp?year="+date.split("-")[0]+"&month="+date.split("-")[1]+"&day="+date.split("-")[2]);
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
