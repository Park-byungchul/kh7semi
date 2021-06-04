package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReviewLikeDao {
	public void insert(ReviewLikeDto reviewLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into review_like values(?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewLikeDto.getClientNo());
		ps.setInt(2, reviewLikeDto.getReviewNo());
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(ReviewLikeDto reviewLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete review_like where client_no = ? and review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewLikeDto.getClientNo());
		ps.setInt(2, reviewLikeDto.getReviewNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean check(ReviewLikeDto reviewLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from review_like where client_no = ? and review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewLikeDto.getClientNo());
		ps.setInt(2, reviewLikeDto.getReviewNo());
		ResultSet rs = ps.executeQuery();
		
		boolean isTrue = false;
		if(rs.next()) {
			isTrue = true;
		}
		
		con.close();
		
		return isTrue;
	}
}
