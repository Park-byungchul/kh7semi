package library.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;
import library.beans.ClientDto;

@WebServlet(urlPatterns = "/client/login.kh")
public class ClientLoginServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			ClientDto clientDto = new ClientDto();
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			
			ClientDao clientDao = new ClientDao();
			ClientDto find = clientDao.login(clientDto);
			
			if(find != null) {
				req.getSession().setAttribute("clientNo", find.getClientNo());
				resp.sendRedirect(req.getContextPath());
			}
			else {
				resp.sendRedirect("login.jsp?error");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
