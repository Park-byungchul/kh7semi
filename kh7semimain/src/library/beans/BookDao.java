package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
	public void insert(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into book "
				+ "(book_isbn, genre_no, book_title, book_,author) "
				+ "values(?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookDto.getBookIsbn());
		ps.setInt(2, bookDto.getGenreNo());
		ps.setString(3, bookDto.getBookTitle());
		ps.setString(4, bookDto.getBookAuthor());
		ps.execute();
		
		con.close();
	}

	public boolean editBook(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update book set book_title=? , book_author = ? "
				+ ", genre_no = ? where book_isbn=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookDto.getBookTitle());
		ps.setString(2, bookDto.getBookAuthor());
		ps.setInt(3, bookDto.getGenreNo());
		ps.setInt(4, bookDto.getBookIsbn());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public BookDto get(int bookIsbn) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookIsbn);
		ResultSet rs = ps.executeQuery();
		
		BookDto bookDto;
		if(rs.next()) {
			bookDto = new BookDto();
			
			bookDto.setBookIsbn(rs.getInt("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
		}
		else {
			bookDto = null;
		}
		
		con.close();
		
		return bookDto;
	}
	
	public List<BookDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book order by book_isbn asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BookDto> bookList = new ArrayList<>();
		
		while(rs.next()) {
			BookDto bookDto = new BookDto();
			
			bookDto.setBookIsbn(rs.getInt("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			
			bookList.add(bookDto);
		}
		
		con.close();
		
		return bookList;
	}
	
	public boolean delete(int bookIsbn) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete book where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookIsbn);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
}
