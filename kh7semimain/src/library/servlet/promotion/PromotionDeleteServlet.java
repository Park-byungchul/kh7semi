package library.servlet.promotion;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.PromotionDao;
import library.beans.PromotionFileDao;
import library.beans.PromotionFileDto;

@WebServlet(urlPatterns = "/promotion/promotionDelete.kh")
public class PromotionDeleteServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			
			int promotionNo = Integer.parseInt(req.getParameter("promotionNo"));
			
			PromotionDao promotionDao = new PromotionDao();
			
			PromotionFileDao promotionFileDao = new PromotionFileDao();
			PromotionFileDto promotionFileDto = promotionFileDao.getByOrigin(promotionNo);
			String filename = promotionFileDto.getFileSaveName();
			String path = PromotionFilePath.SAVEPATH + "/";
			File uploadFile = new File(path + filename);
			if(uploadFile.exists() && uploadFile.isFile()) {
				uploadFile.delete();
			}
			
			promotionDao.delete(promotionNo);
			
			resp.sendRedirect(req.getContextPath()+"/promotion/promotionList.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}