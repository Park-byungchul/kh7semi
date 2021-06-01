package library.servlet.role;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.RoleDao;
import library.beans.RoleDto;

@WebServlet(urlPatterns = "/role/roleEdit.kh")
public class RoleEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			int roleClientNo = Integer.parseInt(req.getParameter("roleClientNo"));
			int roleAreaNo = Integer.parseInt(req.getParameter("roleAreaNo"));

			RoleDto roleDto = new RoleDto();
			roleDto.setClientNo(Integer.parseInt(req.getParameter("clientNo")));
			roleDto.setAreaNo(Integer.parseInt(req.getParameter("areaNo")));
			
			RoleDao roleDao = new RoleDao();
			roleDao.edit(roleDto, roleClientNo, roleAreaNo);
			
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
