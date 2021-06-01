package library.servlet.client;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;

@WebServlet(urlPatterns = "/client/clientDelete.kh")
public class ClientDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {

			int clientNo = Integer.parseInt(req.getParameter("clientNo"));
			
			ClientDao clientDao = new ClientDao();
			clientDao.delete(clientNo);
			
			if(req.getParameter("type") == null) {
				resp.sendRedirect("clientList.jsp");
			} else {
				resp.sendRedirect("clientPartialList.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
