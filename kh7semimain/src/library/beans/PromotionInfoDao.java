package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class PromotionInfoDao {
	public List<PromotionInfoDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from promotion P left outer join promotion_file F on P.promotion_no = F.file_origin order by promotion_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<PromotionInfoDto> list = new ArrayList<>();
		
		while(rs.next()) {
			PromotionInfoDto promotionInfoDto = new PromotionInfoDto();
			promotionInfoDto.setPromotionNo(rs.getInt("promotion_no"));
			promotionInfoDto.setAreaNo(rs.getInt("area_no"));
			promotionInfoDto.setFileNo(rs.getInt("file_no"));
			promotionInfoDto.setFileUploadName(rs.getString("file_upload_name"));
			promotionInfoDto.setFileSaveName(rs.getString("file_save_name"));
			promotionInfoDto.setFileContentType(rs.getString("file_content_type"));
			promotionInfoDto.setFileSize(rs.getLong("file_size"));
			promotionInfoDto.setFileOrigin(rs.getInt("file_origin"));
			
			list.add(promotionInfoDto);
		}
		
		con.close();
		return list;
	}
	
	public PromotionInfoDto detail(int promotionPage) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from"
				+ "(select rownum rn, TMP.* from"
				+ "(select * from promotion P left outer join promotion_file F on P.promotion_no = F.file_origin order by promotion_no asc)"
				+ "TMP where file_no is not null)"
				+ "where rn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, promotionPage);
		ResultSet rs = ps.executeQuery();
		
		PromotionInfoDto promotionInfoDto = new PromotionInfoDto();
		
		if(rs.next()) {
			promotionInfoDto.setPromotionNo(rs.getInt("promotion_no"));
			promotionInfoDto.setAreaNo(rs.getInt("area_no"));
			promotionInfoDto.setFileNo(rs.getInt("file_no"));
			promotionInfoDto.setFileUploadName(rs.getString("file_upload_name"));
			promotionInfoDto.setFileSaveName(rs.getString("file_save_name"));
			promotionInfoDto.setFileContentType(rs.getString("file_content_type"));
			promotionInfoDto.setFileSize(rs.getLong("file_size"));
			promotionInfoDto.setFileOrigin(rs.getInt("file_origin"));
		} else {
			promotionInfoDto = null;
		}
		
		con.close();
		return promotionInfoDto;
	}
	
	public PromotionInfoDto detail(int promotionPage, int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from"
				+ "(select rownum rn, TMP.* from"
				+ "(select * from promotion P left outer join promotion_file F on P.promotion_no = F.file_origin order by promotion_no asc)"
				+ "TMP where file_no is not null and (area_no = ? or area_no is null))"
				+ "where  rn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ps.setInt(2, promotionPage);
		ResultSet rs = ps.executeQuery();
		
		PromotionInfoDto promotionInfoDto = new PromotionInfoDto();
		
		if(rs.next()) {
			promotionInfoDto.setPromotionNo(rs.getInt("promotion_no"));
			promotionInfoDto.setAreaNo(rs.getInt("area_no"));
			promotionInfoDto.setFileNo(rs.getInt("file_no"));
			promotionInfoDto.setFileUploadName(rs.getString("file_upload_name"));
			promotionInfoDto.setFileSaveName(rs.getString("file_save_name"));
			promotionInfoDto.setFileContentType(rs.getString("file_content_type"));
			promotionInfoDto.setFileSize(rs.getLong("file_size"));
			promotionInfoDto.setFileOrigin(rs.getInt("file_origin"));
		} else {
			promotionInfoDto = null;
		}
		
		con.close();
		return promotionInfoDto;
	}
	
	public int count() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from promotion P left outer join promotion_file F on P.promotion_no = F.file_origin where file_no is not null";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	public int count(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from promotion P left outer join promotion_file F on P.promotion_no = F.file_origin where file_no is not null and (area_no = ? or area_no is null)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
}
