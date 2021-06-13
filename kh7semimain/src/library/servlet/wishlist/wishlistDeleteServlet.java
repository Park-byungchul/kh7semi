package library.servlet.wishlist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.websocket.Session;

import library.beans.WishlistDao;
import library.beans.WishlistDto;

@WebServlet(urlPatterns="/wishlist/wishlistDelete.kh")
public class wishlistDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : clientNo, bookIsbn
			req.setCharacterEncoding("UTF-8");
			WishlistDto wishlistDto = new WishlistDto();
			wishlistDto.setClientNo((int)req.getSession().getAttribute("clientNo"));
			wishlistDto.setBookIsbn(req.getParameter("bookIsbn"));
			int wishlistNo = Integer.parseInt(req.getParameter("wishlistNo"));
			wishlistDto.setWishlistNo(wishlistNo);
			//처리
			WishlistDao wishlistDao = new WishlistDao();
			wishlistDao.delete(wishlistDto.getWishlistNo());
			
			String root = req.getContextPath();
			//출력 : 책 디테일로 복귀
		
			resp.sendRedirect("wishlist.jsp");	
		
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
