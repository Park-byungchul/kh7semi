package library.servlet.book;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.RecommendDao;
import library.beans.WishlistDao;
import library.beans.WishlistDto;

@WebServlet(urlPatterns ="/book/bookWishlistInsert.kh")
public class BookWishlistInsertServlet extends HttpServlet{
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		try {
			//준비 : clientNo, bookIsbn
			req.setCharacterEncoding("UTF-8");
			WishlistDto wishlistDto = new WishlistDto();
			wishlistDto.setClientNo(Integer.parseInt(req.getParameter("clientNo"))); 
			wishlistDto.setBookIsbn(Long.parseLong(req.getParameter("bookIsbn")));
			
			//처리
			WishlistDao wishlistDao = new WishlistDao();
			int wishlistNo = wishlistDao.getSequence();//게시글번호(DB시퀀스)
			wishlistDto.setWishlistNo(wishlistNo);
			
			wishlistDao.insert(wishlistDto);
			
			//출력 : 책 리스트로 복귀
			resp.sendRedirect("bookList.jsp");
			
		}
		catch(Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
