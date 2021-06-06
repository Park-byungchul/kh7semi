package library.servlet.client;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.ClientDao;
import library.beans.ClientDto;

@WebServlet(urlPatterns = "/client/insert.kh")
public class ClientInsertServlet extends HttpServlet {
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			ClientDto clientDto = new ClientDto();
			clientDto.setClientId(req.getParameter("clientId"));
			clientDto.setClientPw(req.getParameter("clientPw"));
			clientDto.setClientName(req.getParameter("clientName"));
			clientDto.setClientEmail(req.getParameter("clientEmail"));
			clientDto.setClientPhone(req.getParameter("clientPhone"));
			
			ClientDao clientDao = new ClientDao();
			if(!clientDao.checkId(clientDto.getClientId())) {
				clientDao.insert(clientDto);
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out=resp.getWriter();
				out.println("<script>alert('회원가입이 완료되었습니다.'); location.href='"+ req.getContextPath()+"/client/login.jsp" +"';</script>");
				out.flush();
			} else {
				resp.setContentType("text/html; charset=UTF-8");
				PrintWriter out=resp.getWriter();
				out.println("<script>alert('아이디가 존재합니다.'); location.href='"+ req.getContextPath()+"/client/clientInsert.jsp" +"';</script>");
				out.flush();
			}
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
