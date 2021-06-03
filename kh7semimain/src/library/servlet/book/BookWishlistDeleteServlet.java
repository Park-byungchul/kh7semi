package library.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


import library.beans.WishlistDao;
import library.beans.WishlistDto;

@WebServlet(urlPatterns= {
		"/book/bookWishlistDelete.kh"
})
public class BookWishlistDeleteServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : clientNo, bookIsbn
			req.setCharacterEncoding("UTF-8");
			WishlistDto wishlistDto = new WishlistDto();
			wishlistDto.setClientNo(Integer.parseInt(req.getParameter("clientNo"))); 
			wishlistDto.setBookIsbn(req.getParameter("bookIsbn"));
			
			//처리
			WishlistDao wishlistDao = new WishlistDao();
			wishlistDao.delete(wishlistDto.getClientNo(), wishlistDto.getBookIsbn());
			
			
			//출력 : 책 리스트로 복귀
		
			resp.sendRedirect("bookList.jsp");	
		
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
