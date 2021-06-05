package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import library.beans.JdbcUtils;

public class ReviewListDao {
	public List<ReviewListDto> list(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "select * from review_list order by review_no desc"
				+ ")TMP"
			+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<ReviewListDto> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			ReviewListDto reviewListDto = new ReviewListDto();
			
			reviewListDto.setReviewNo(rs.getInt("review_no"));
			reviewListDto.setReviewer(rs.getInt("reviewer"));
			reviewListDto.setBookIsbn(rs.getString("book_isbn"));
			reviewListDto.setReviewSubject(rs.getString("review_subject"));
			reviewListDto.setReviewContent(rs.getString("review_content"));
			reviewListDto.setReviewRead(rs.getInt("review_read"));
			reviewListDto.setReviewLike(rs.getInt("review_like"));
			reviewListDto.setReviewDate(rs.getDate("review_date"));
			reviewListDto.setReviewReply(rs.getInt("review_reply"));
			
			reviewListDto.setClientNo(rs.getInt("client_no"));
			reviewListDto.setClientName(rs.getString("client_name"));

			reviewList.add(reviewListDto);
		}
		
		con.close();
		
		return reviewList;
	}
	
	public int getCount() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from review_list";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	// 상세보기 기능
	public ReviewListDto find(int reviewNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select * from review_list where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		ResultSet rs = ps.executeQuery();
				
		ReviewListDto reviewDto;
				
		if(rs.next()) {
			reviewDto = new ReviewListDto();

			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setReviewer(rs.getInt("reviewer"));
			reviewDto.setBookIsbn(rs.getString("book_isbn"));
			reviewDto.setReviewSubject(rs.getString("review_subject"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRead(rs.getInt("review_read"));
			reviewDto.setReviewLike(rs.getInt("review_like"));
			reviewDto.setReviewDate(rs.getDate("review_date"));
			reviewDto.setReviewReply(rs.getInt("review_reply"));
		
			reviewDto.setClientNo(rs.getInt("client_no"));
			reviewDto.setClientName(rs.getString("client_name"));
		}
		else
			reviewDto = null;
				
		con.close();
				
		return reviewDto;
	}
	
	// 검색
	public List<ReviewListDto> search(String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from review_list where instr(#1, ?) > 0 order by review_no desc"
					+ ")TMP"
				+ ") where rn between ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
			
		List<ReviewListDto> reviewList = new ArrayList<>();
		
		while(rs.next()) {
			ReviewListDto reviewListDto = new ReviewListDto();
				
			reviewListDto.setReviewNo(rs.getInt("review_no"));
			reviewListDto.setReviewer(rs.getInt("reviewer"));
			reviewListDto.setBookIsbn(rs.getString("book_isbn"));
			reviewListDto.setReviewSubject(rs.getString("review_subject"));
			reviewListDto.setReviewContent(rs.getString("review_content"));
			reviewListDto.setReviewRead(rs.getInt("review_read"));
			reviewListDto.setReviewLike(rs.getInt("review_like"));
			reviewListDto.setReviewDate(rs.getDate("review_date"));
			reviewListDto.setReviewReply(rs.getInt("review_reply"));

			reviewListDto.setClientNo(rs.getInt("client_no"));
			reviewListDto.setClientName(rs.getString("client_name"));

			reviewList.add(reviewListDto);
		}
			
		con.close();
			
		return reviewList;
	}
	
	public int getCount(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from review_list where instr(#1, ?) > 0 and board_type_no = ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
}