package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GetBookDao {
	public void insert(GetBookDto getBookDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into get_book "
				+ "(get_book_no, book_isbn, area_no, "
				+ "get_book_date, get_book_status) "
				+ "values(get_book_seq.next(), ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, getBookDto.getBookIsbn());
		ps.setInt(2, getBookDto.getAreaNo());
		ps.setDate(3, getBookDto.getGetBookDate());
		ps.setString(4, getBookDto.getGetBookStatus());
		ps.execute();
		
		con.close();
	}
	
		public boolean editGetBook(GetBookDto getBookDto) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "update get_book set get_book_status=? where get_book_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, getBookDto.getGetBookStatus());
			ps.setInt(2, getBookDto.getGetBookNo());
			int count = ps.executeUpdate();
			
			con.close();
			
			return count > 0;
		}
		
		public GetBookDto get(int getBookNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from get_book where get_book_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, getBookNo);
			ResultSet rs = ps.executeQuery();
			
			GetBookDto getBookDto;
			if(rs.next()) {
				getBookDto = new GetBookDto();
				
				
				getBookDto.setGetBookNo(rs.getInt("get_book_no"));
				getBookDto.setBookIsbn(rs.getString("book_isbn"));
				getBookDto.setAreaNo(rs.getInt("area_no"));
				getBookDto.setGetBookDate(rs.getDate("get_Book_date"));
				getBookDto.setGetBookStatus(rs.getString("get_book_status"));
			}
			else {
				getBookDto = null;
			}
			
			con.close();
			
			return getBookDto;
		}
		
		public List<GetBookDto> list() throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from get_book order by get_book_no asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			List<GetBookDto> getBookList = new ArrayList<>();
			
			while(rs.next()) {
				GetBookDto getBookDto = new GetBookDto();
				getBookDto.setGetBookNo(rs.getInt("get_book_no"));
				getBookDto.setBookIsbn(rs.getString("book_isbn"));
				getBookDto.setAreaNo(rs.getInt("area_no"));
				getBookDto.setGetBookDate(rs.getDate("get_Book_date"));
				getBookDto.setGetBookStatus(rs.getString("get_book_status"));
				
				
				getBookList.add(getBookDto);
			}
			
			con.close();
			
			return getBookList;
		}
		
		public boolean delete(int getBookNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "delete get_book where get_book_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, getBookNo);
			int count = ps.executeUpdate();
	
			con.close();
			return count > 0;
		}
		
		//입고된 책 검색 기능
		public List<GetBookDto> searchList(String keyword) throws Exception{
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from get_book "
					+ "where (get_book_title || get_book_author) like '%'||?||'%'";
//			+ "where instr(get_book_title || get_book_author, ?) > 0 order by get_book_title asc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();
			
			List<GetBookDto> getBookList = new ArrayList<>();
			
			while(rs.next()) {
				GetBookDto getBookDto = new GetBookDto();
				getBookDto.setGetBookNo(rs.getInt("get_book_no"));
				getBookDto.setBookIsbn(rs.getString("book_isbn"));
				getBookDto.setAreaNo(rs.getInt("area_no"));
				getBookDto.setGetBookDate(rs.getDate("get_book_date"));
				getBookDto.setGetBookStatus(rs.getString("get_book_status"));
				
				
				getBookList.add(getBookDto);
			}
			
			con.close();
			
			return getBookList;
					
		}
		
		public List<GetBookDto> searchList(String type, String keyword) throws Exception{
			Connection con = JdbcUtils.getConnection();
			
//			String sql = "select * from get_book where instr(#1, ?) > 0 order by #1 asc";
			String sql = "select * from get_book "
					+ "where #1 like '%'||?||'%' order by #1 asc";
			sql = sql.replace("#1", type);
			System.out.println(sql);
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setString(1, keyword);
			ResultSet rs = ps.executeQuery();
			
			List<GetBookDto> getBookList = new ArrayList<>();
			
			while(rs.next()) {
				GetBookDto getBookDto = new GetBookDto();
				getBookDto.setGetBookNo(rs.getInt("get_book_no"));
				getBookDto.setBookIsbn(rs.getString("book_isbn"));
				getBookDto.setAreaNo(rs.getInt("area_no"));
				getBookDto.setGetBookDate(rs.getDate("get_Book_date"));
				getBookDto.setGetBookStatus(rs.getString("get_book_status"));
		
				
				getBookList.add(getBookDto);
			}
			
			con.close();
			
			return getBookList;

		}
}
