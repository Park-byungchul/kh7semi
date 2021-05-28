package library.servlet.area;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.AreaDao;
import library.beans.AreaDto;

@WebServlet(urlPatterns = "/area/areaEdit.kh")
public class AreaEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			int areaNo = Integer.parseInt(req.getParameter("areaNo"));
			
			AreaDto areaDto = new AreaDto();
			areaDto.setAreaNo(areaNo);
			areaDto.setAreaName(req.getParameter("areaName"));
			areaDto.setAreaLocation(req.getParameter("areaLocation"));
			areaDto.setAreaCall(req.getParameter("areaCall"));
			
			AreaDao areaDao = new AreaDao();
			areaDao.edit(areaDto);
			
			resp.sendRedirect("areaList.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
