package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookDetailDao {
	public BookDetailDto get(long bookIsbn) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book_detail_view where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setLong(1, bookIsbn);
		ResultSet rs = ps.executeQuery();
		
		BookDetailDto bookDetailDto;
		if(rs.next()) {
			bookDetailDto = new BookDetailDto();
			
			bookDetailDto.setBookIsbn(rs.getLong("book_isbn"));
			bookDetailDto.setGenreNo(rs.getInt("genre_no"));
			bookDetailDto.setGenreName(rs.getString("genre_name"));
			bookDetailDto.setBookTitle(rs.getString("book_title"));
			bookDetailDto.setBookAuthor(rs.getString("book_author"));
		}
		else {
			bookDetailDto = null;
		}
		
		con.close();
		
		return bookDetailDto;
	}
}
