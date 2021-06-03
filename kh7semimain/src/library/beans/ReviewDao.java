package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReviewDao {
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select review_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
			
		int no = rs.getInt(1);
		con.close();
			
		return no;
	}
		
	public void write(ReviewDto reviewDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into review "
				+ "values(?, ?, ?, ?, ?, 0, 0, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewDto.getReviewNo());
		ps.setInt(2, reviewDto.getClientNo());
		ps.setString(3, reviewDto.getBookIsbn());
		ps.setString(4, reviewDto.getReviewSubject());
		ps.setString(5, reviewDto.getReviewContent());
		ps.execute();
		
		con.close();
	}
	
	// 조회수 증가 기능
	public boolean read(int reviewNo, int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "update review set "
				+ "review_read = review_read + 1 "
				+ "where review_no = ? and client_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		ps.setInt(2, clientNo);
		int count = ps.executeUpdate();
				
		con.close();
				
		return count > 0;
	}
		
	// 상세보기 기능
	public ReviewDto find(int reviewNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select * from review where review_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reviewNo);
		ResultSet rs = ps.executeQuery();
				
		ReviewDto reviewDto;
				
		if(rs.next()) {
			reviewDto = new ReviewDto();

			reviewDto.setReviewNo(rs.getInt("review_no"));
			reviewDto.setClientNo(rs.getInt("client_no"));
			reviewDto.setBookIsbn(rs.getString("book_isbn"));
			reviewDto.setReviewSubject(rs.getString("review_subject"));
			reviewDto.setReviewContent(rs.getString("review_content"));
			reviewDto.setReviewRead(rs.getInt("review_read"));
			reviewDto.setReviewLike(rs.getInt("review_like"));
			reviewDto.setReviewDate(rs.getDate("review_date"));
		}
		else
			reviewDto = null;
				
		con.close();
				
		return reviewDto;
	}
	
	// 책 가져오는 메소드
	public BookDto getBookInfo(String bookIsbn) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookIsbn);
		ResultSet rs = ps.executeQuery();
		
		BookDto bookDto;
		
		if(rs.next()) {
			bookDto = new BookDto();
			
			bookDto.setBookIsbn(rs.getString("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDate(rs.getDate("book_date"));
			bookDto.setBookContent(rs.getString("book_content"));
			bookDto.setBookImg(rs.getString("book_img"));
		}
		else
			bookDto = null;
		
		con.close();
		
		return bookDto;
	}
}
