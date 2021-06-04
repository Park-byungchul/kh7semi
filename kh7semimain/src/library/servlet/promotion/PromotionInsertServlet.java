package library.servlet.promotion;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

import library.beans.PromotionDao;
import library.beans.PromotionDto;
import library.beans.PromotionFileDao;
import library.beans.PromotionFileDto;

@WebServlet(urlPatterns = "/promotion/promotionInsert.kh")
public class PromotionInsertServlet extends HttpServlet{
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			req.setCharacterEncoding("UTF-8");
			
			String path = "D:/promotion";
			
			File filePath = new File(path);
			
			if(!filePath.exists()) {
				filePath.mkdir();
			}
			
			int maximumSize = 10 * 1024 * 1024; // 바이트
			String encoding = "UTF-8";
			DefaultFileRenamePolicy policy = new DefaultFileRenamePolicy();
			
			MultipartRequest mRequest = new MultipartRequest(req, path, maximumSize, encoding, policy);
			
			PromotionDto promotionDto = new PromotionDto();
			
			int areaNo = Integer.parseInt(mRequest.getParameter("areaNo"));
			promotionDto.setAreaNo(areaNo);
			
			PromotionDao promotionDao = new PromotionDao();
			int promotionNo = promotionDao.getSequence();
			promotionDto.setPromotionNo(promotionNo);
			
			promotionDao.insert(promotionDto);
			
			File file = mRequest.getFile("promotionFile");
			if(file != null) {
				PromotionFileDto promotionFileDto = new PromotionFileDto();
				promotionFileDto.setFileSaveName(mRequest.getFilesystemName("promotionFile"));
				promotionFileDto.setFileUploadName(mRequest.getOriginalFileName("promotionFile"));
				promotionFileDto.setFileContentType(mRequest.getContentType("promotionFile"));
				promotionFileDto.setFileSize(file.length());
				promotionFileDto.setFileOrigin(promotionNo);
				
				PromotionFileDao promotionFileDao = new PromotionFileDao();
				promotionFileDao.insert(promotionFileDto);
			}
			
			resp.sendRedirect(req.getContextPath()+"/promotion/promotionList.jsp");
			
		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
