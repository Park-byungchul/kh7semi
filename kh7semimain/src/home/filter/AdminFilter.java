package home.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;

@WebFilter(urlPatterns = {
		"/admin/*",
		"/area/*",
		"/role/*"
})
public class AdminFilter implements Filter {

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		try {
			int clientNo;
			int areaNo;
			if(req.getSession().getAttribute("clientNo") != null) {
				clientNo = (int) req.getSession().getAttribute("clientNo");
			} else {
				clientNo = 0;
			}
			if(req.getSession().getAttribute("areaNo") != null) {
				areaNo = (int)req.getSession().getAttribute("areaNo");
			} else {
				areaNo = 0;
			}

			ClientDao clientDao = new ClientDao();
			boolean isAdminCurrentArea = clientDao.isAdminCurrentArea(clientNo, areaNo);
			if (isAdminCurrentArea) {
				chain.doFilter(request, response);
			} else if(clientDao.get(clientNo).getClientType().equals("권한관리자")) {
				resp.sendRedirect(req.getContextPath());
			} else {
				resp.sendError(403);
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
	
}
