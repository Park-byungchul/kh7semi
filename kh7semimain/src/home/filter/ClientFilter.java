package home.filter;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebFilter(urlPatterns = {
		"/client/clientDetail.jsp"
		})
public class ClientFilter implements Filter{

	@Override
	public void doFilter(ServletRequest request, ServletResponse response,
			FilterChain chain) throws IOException, ServletException {
		HttpServletRequest req = (HttpServletRequest) request;
		HttpServletResponse resp = (HttpServletResponse) response;

		if(req.getSession().getAttribute("clientNo") == null) {
//			resp.setContentType("text/html; charset=UTF-8");
//			PrintWriter out=response.getWriter();
//			out.println("<script>alert('로그인주세요.'); location.href='"+ req.getContextPath()+"/client/login.jsp" +"';</script>");
//			out.flush();
			resp.sendRedirect(req.getContextPath()+"/client/login.jsp");
		}
		else {
			chain.doFilter(request, response);
		}
	}

}
