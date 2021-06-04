package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class PromotionFileDao {

	public void insert(PromotionFileDto promotionFileDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into promotion_file values(promotion_file_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, promotionFileDto.getFileUploadName());
		ps.setString(2, promotionFileDto.getFileSaveName());
		ps.setString(3, promotionFileDto.getFileContentType());
		ps.setLong(4, promotionFileDto.getFileSize());
		ps.setInt(5, promotionFileDto.getFileOrigin());
		ps.execute();

		con.close();
	}

	// 단일 조회 : profileNo, profileOrigin
	public PromotionFileDto getByFileNo(int fileNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from promotion_file where file_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fileNo);
		ResultSet rs = ps.executeQuery();

		PromotionFileDto promotionFileDto;
		if (rs.next()) {
			promotionFileDto = new PromotionFileDto();
			promotionFileDto.setFileNo(rs.getInt("file_no"));
			promotionFileDto
					.setFileUploadName(rs.getString("file_upload_name"));
			promotionFileDto.setFileSaveName(rs.getString("file_save_name"));
			promotionFileDto
					.setFileContentType(rs.getString("file_content_type"));
			promotionFileDto.setFileSize(rs.getLong("file_size"));
			promotionFileDto.setFileOrigin(rs.getInt("file_origin"));
		} else {
			promotionFileDto = null;
		}

		con.close();
		return promotionFileDto;
	}

	public PromotionFileDto getByOrigin(int fileOrigin) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from promotion_file where file_origin = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, fileOrigin);
		ResultSet rs = ps.executeQuery();

		PromotionFileDto promotionFileDto;
		if (rs.next()) {
			promotionFileDto = new PromotionFileDto();
			promotionFileDto.setFileNo(rs.getInt("file_no"));
			promotionFileDto
					.setFileUploadName(rs.getString("file_upload_name"));
			promotionFileDto.setFileSaveName(rs.getString("file_save_name"));
			promotionFileDto
					.setFileContentType(rs.getString("file_content_type"));
			promotionFileDto.setFileSize(rs.getLong("file_size"));
			promotionFileDto.setFileOrigin(rs.getInt("file_origin"));
		} else {
			promotionFileDto = null;
		}

		con.close();
		return promotionFileDto;
	}
}
