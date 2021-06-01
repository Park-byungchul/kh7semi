package library.servlet.role;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.RoleDao;
import library.beans.RoleDto;

@WebServlet(urlPatterns = "/role/roleInsert.kh")
public class RoleInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");

			int clientNo = Integer.parseInt(req.getParameter("clientNo"));
			int areaNo = Integer.parseInt(req.getParameter("areaNo"));
			RoleDto roleDto = new RoleDto();
			roleDto.setClientNo(clientNo);
			roleDto.setAreaNo(areaNo);

			RoleDao roleDao = new RoleDao();
			roleDao.insert(roleDto);

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
