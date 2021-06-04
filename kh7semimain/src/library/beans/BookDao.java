package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BookDao {
	public void insert(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into book values(?,?,?,?,?,?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookDto.getBookIsbn());
		ps.setInt(2, bookDto.getGenreNo());
		ps.setString(3, bookDto.getBookTitle());
		ps.setString(4, bookDto.getBookAuthor());
		ps.setString(5, bookDto.getBookPublisher());
		ps.setDate(6, bookDto.getBookDate());
		ps.setString(7, bookDto.getBookContent());
		ps.setString(8, bookDto.getBookImg());
		ps.execute();
		
		con.close();
	}

	public boolean editBook(BookDto bookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update book set genre_no = ? , book_title = ? , book_author = ? , "
				+ "book_publisher = ? , book_date = ? , book_content = ? , book_img = ? "
				+ "where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, bookDto.getGenreNo());
		ps.setString(2, bookDto.getBookTitle());
		ps.setString(3, bookDto.getBookAuthor());
		ps.setString(4, bookDto.getBookPublisher());
		ps.setDate(5, bookDto.getBookDate());
		ps.setString(6, bookDto.getBookContent());
		ps.setString(7, bookDto.getBookImg());
		ps.setString(8, bookDto.getBookIsbn());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public BookDto get(String bookIsbn) throws Exception {
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
			
			bookDto.setBookIsbn(rs.getString("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDate(rs.getDate("book_date"));
			bookDto.setBookContent(rs.getString("book_content"));
			bookDto.setBookImg(rs.getString("book_img"));
			
			bookList.add(bookDto);
		}
		
		con.close();
		
		return bookList;
	}
	
	//목록 - 페이징
			public List<BookDto> list(int startRow, int endRow) throws Exception {
				Connection con = JdbcUtils.getConnection();
				
				String sql = "select * from("
										+ "select rownum rn, TMP.* from("
											+ "select * from book order by book_isbn asc"
										+ ")TMP"
									+ ") where rn between ? and ?";
				PreparedStatement ps = con.prepareStatement(sql);
				ps.setInt(1, startRow);
				ps.setInt(2, endRow);
				ResultSet rs = ps.executeQuery();
				
				List<BookDto> bookList = new ArrayList<>();
				while(rs.next()) {
					BookDto bookDto = new BookDto();
					
					bookDto.setBookIsbn(rs.getString("book_isbn"));
					bookDto.setGenreNo(rs.getInt("genre_no"));
					bookDto.setBookTitle(rs.getString("book_title"));
					bookDto.setBookAuthor(rs.getString("book_author"));
					bookDto.setBookPublisher(rs.getString("book_publisher"));
					bookDto.setBookDate(rs.getDate("book_date"));
					bookDto.setBookContent(rs.getString("book_content"));
					bookDto.setBookImg(rs.getString("book_img"));
					
					bookList.add(bookDto);
				}
				
				con.close();
				
				return bookList;
	}
	
	public List<BookDto> search(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book "
	               + "where (book_title || book_author) like '%'||?||'%'";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<BookDto> bookList = new ArrayList<>();
		
		while(rs.next()) {
			BookDto bookDto = new BookDto();
			
			bookDto.setBookIsbn(rs.getString("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDate(rs.getDate("book_date"));
			bookDto.setBookContent(rs.getString("book_content"));
			bookDto.setBookImg(rs.getString("book_img"));
			
			bookList.add(bookDto);
		}
		
		con.close();
		
		return bookList;
	}
	
	public List<BookDto> search(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from book "
				+ "where #1 like '%'||?||'%' order by #1 asc";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<BookDto> bookList = new ArrayList<>();
		
		while(rs.next()) {
			BookDto bookDto = new BookDto();
			
			bookDto.setBookIsbn(rs.getString("book_isbn"));
			bookDto.setGenreNo(rs.getInt("genre_no"));
			bookDto.setBookTitle(rs.getString("book_title"));
			bookDto.setBookAuthor(rs.getString("book_author"));
			bookDto.setBookPublisher(rs.getString("book_publisher"));
			bookDto.setBookDate(rs.getDate("book_date"));
			bookDto.setBookContent(rs.getString("book_content"));
			bookDto.setBookImg(rs.getString("book_img"));
			
			bookList.add(bookDto);
		}
		
		con.close();
		
		return bookList;
	}
	
	public boolean delete(String bookIsbn) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete book where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, bookIsbn);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
			public int getCount() throws Exception {
				Connection con = JdbcUtils.getConnection();
				
				String sql = "select count(*) from book";
				PreparedStatement ps = con.prepareStatement(sql);
				ResultSet rs = ps.executeQuery();
				rs.next();
				int count = rs.getInt(1);
				
				con.close();
				
				return count;
		}
}
