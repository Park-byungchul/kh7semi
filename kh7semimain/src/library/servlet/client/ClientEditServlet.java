package library.servlet.client;

import java.io.IOException;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;
import library.beans.ClientDto;

@WebServlet(urlPatterns = "/client/clientEdit.kh")
public class ClientEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int ClientNo = Integer.parseInt(req.getParameter("clientNo"));
			
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(ClientNo);
			clientDto.setClientName(req.getParameter("clientName"));
			clientDto.setClientEmail(req.getParameter("clientEmail"));
			clientDto.setClientPossible(Date.valueOf(req.getParameter("clientPossible")));
			clientDto.setClientType(req.getParameter("clientType"));
			
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.edit(clientDto);
			
			if(result) {
				resp.sendRedirect("clientList.jsp");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
