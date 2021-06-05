package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import library.beans.JdbcUtils;

public class PromotionDao {

	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select promotion_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int promotionNo = rs.getInt(1);

		con.close();
		return promotionNo;
	}
	
	public void insert(PromotionDto promotionDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql;
		if(promotionDto.getAreaNo() == 0) {
			sql = "insert into promotion values(?, null)";
		} else {
			sql = "insert into promotion values(?, ?)";
		}
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, promotionDto.getPromotionNo());
		if(promotionDto.getAreaNo() != 0) {
			ps.setInt(2, promotionDto.getAreaNo());
		}
		ps.execute();

		con.close();
	}
	
	public boolean delete(int promotionNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete promotion where promotion_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, promotionNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
}
