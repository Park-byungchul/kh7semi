package library.servlet.promotion;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import library.beans.PromotionFileDao;
import library.beans.PromotionFileDto;

@WebServlet(urlPatterns = "/promotion/promotionFile.kh")
public class PromotionDownloadServlet extends HttpServlet {
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp)
			throws ServletException, IOException {
		try {
			int fileNo = Integer.parseInt(req.getParameter("fileNo"));

			PromotionFileDao promotionFileDao = new PromotionFileDao();
			PromotionFileDto promotionFileDto = promotionFileDao
					.getByFileNo(fileNo);

			String fileName = URLEncoder
					.encode(promotionFileDto.getFileUploadName(), "UTF-8");
			resp.setHeader("Content-Type",
					promotionFileDto.getFileContentType());
			resp.setHeader("Content-Encoding", "UTF-8");
			resp.setHeader("Content-length",
					String.valueOf(promotionFileDto.getFileSize()));
			resp.setHeader("Content-Disposition",
					"attachment;  filename=\"" + fileName + "\"");
			
			File dir = new File(PromotionFilePath.SAVEPATH);
			File target = new File(dir, promotionFileDto.getFileSaveName());

			byte[] buffer = new byte[1024];
			FileInputStream in = new FileInputStream(target);

			while (true) {
				int size = in.read(buffer);
				if (size == -1)
					break;
				resp.getOutputStream().write(buffer, 0, size);
			}

			in.close();

		} catch (Exception e) {
			e.printStackTrace();
			resp.sendError(500);
		}
	}
}
