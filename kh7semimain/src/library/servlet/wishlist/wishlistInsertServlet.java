package library.servlet.wishlist;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.WishlistDao;
import library.beans.WishlistDto;

@WebServlet(urlPatterns="/wishlist/wishlistInsert.kh")
public class wishlistInsertServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : clientNo, bookIsbn
			req.setCharacterEncoding("UTF-8");
			WishlistDto wishlistDto = new WishlistDto();
			wishlistDto.setClientNo(Integer.parseInt(req.getParameter("clientNo"))); 
			wishlistDto.setBookIsbn(req.getParameter("bookIsbn"));
			int getBookNo = Integer.parseInt(req.getParameter("getBookNo"));
			
			//처리
			WishlistDao wishlistDao = new WishlistDao();
			int wishlistNo = wishlistDao.getSequence();//게시글번호(DB시퀀스)
			wishlistDto.setWishlistNo(wishlistNo);
			
			wishlistDao.insert(wishlistDto);
			String root = req.getContextPath();
			
			resp.sendRedirect(root+"/getBook/getBookDetail.jsp?getBookNo="+getBookNo);
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
