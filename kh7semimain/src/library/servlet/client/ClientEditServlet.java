package library.servlet.client;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Date;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;
import library.beans.ClientDto;
import library.beans.RoleDao;

@WebServlet(urlPatterns = "/client/clientEdit.kh")
public class ClientEditServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			int pageNo = Integer.parseInt(req.getParameter("pageNo"));
			int ClientNo = Integer.parseInt(req.getParameter("clientNo"));
			
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(ClientNo);
			clientDto.setClientName(req.getParameter("clientName"));
			clientDto.setClientEmail(req.getParameter("clientEmail"));
			clientDto.setClientPossible(Date.valueOf(req.getParameter("clientPossible")));
			clientDto.setClientType(req.getParameter("clientType"));
			
			ClientDao clientDao = new ClientDao();
			boolean result = clientDao.edit(clientDto);
			
			if(clientDto.getClientType().equals("일반관리자") || clientDto.getClientType().equals("일반사용자")) {
				RoleDao roleDao = new RoleDao();
				roleDao.delete(ClientNo);
			}
			
			String search = URLEncoder.encode(req.getParameter("search"), "UTF-8");
			
			if(req.getParameter("type") == null) {
				if(req.getParameter("search") == null) {
					resp.sendRedirect("clientList.jsp?pageNo="+pageNo);
				}
				else {
					resp.sendRedirect("clientList.jsp?pageNo=" + pageNo + "&search=" + search);
				}
			}
			else {
				if(req.getParameter("search") == null) {
					resp.sendRedirect("clientPartialList.jsp?pageNo="+pageNo);
				}
				else {
					resp.sendRedirect("clientPartialList.jsp?pageNo=" + pageNo + "&search=" + search);
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
