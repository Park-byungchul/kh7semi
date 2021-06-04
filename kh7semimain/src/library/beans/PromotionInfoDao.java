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
}
