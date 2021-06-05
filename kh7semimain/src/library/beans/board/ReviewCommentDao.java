package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import library.beans.JdbcUtils;

public class ReviewCommentDao {
	public void insert(ReviewCommentDto reviewCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into review_comment "
				+ "values(comment_seq.nextval, ?, ?, ?, sysdate, 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewCommentDto.getClientNo());
		ps.setInt(2, reviewCommentDto.getReviewNo());
		ps.setString(3, reviewCommentDto.getCommentField());
		ps.execute();
		
		con.close();
	}
	
	public boolean edit(ReviewCommentDto reviewCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update review_comment set comment_field = ? "
				+ "where comment_no = ? and client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, reviewCommentDto.getCommentField());
		ps.setInt(2, reviewCommentDto.getCommentNo());
		ps.setInt(3, reviewCommentDto.getClientNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean delete(ReviewCommentDto reviewCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete review_comment where comment_no = ? and client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewCommentDto.getCommentNo());
		ps.setInt(2, reviewCommentDto.getClientNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public List<ReviewCommentDto> list(int reviewNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from review_comment where review_no = ? order by comment_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewCommentDto> commentList = new ArrayList<>();
		
		while(rs.next()) {
			ReviewCommentDto reviewCommentDto = new ReviewCommentDto();
			
			reviewCommentDto.setCommentNo(rs.getInt("comment_no"));
			reviewCommentDto.setClientNo(rs.getInt("client_no"));
			reviewCommentDto.setReviewNo(rs.getInt("review_no"));
			reviewCommentDto.setCommentField(rs.getString("comment_field"));
			reviewCommentDto.setCommentDate(rs.getDate("comment_date"));
			reviewCommentDto.setCommentLike(rs.getInt("comment_like"));
			
			commentList.add(reviewCommentDto);
		}
		
		con.close();
		
		return commentList;
	}
	
	public String getClientName(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select client_name from client where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		String name = rs.getString(1);
		con.close();
				
		return name;
	}
}
