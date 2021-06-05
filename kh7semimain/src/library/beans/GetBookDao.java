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
				+ "get_book_date) "
				+ "values(get_book_seq.nextval, ?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, getBookDto.getBookIsbn());
		ps.setInt(2, getBookDto.getAreaNo());
		ps.execute();
		
		con.close();
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
			}
			else {
				getBookDto = null;
			}
			
			con.close();
			
			return getBookDto;
		}
		
		public boolean check(int getBookCheck) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from get_book where get_book_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, getBookCheck);
			ResultSet rs = ps.executeQuery();
			
			boolean check;
			if(rs.next()) {
				check = true;
			}
			else {
				check = false;
			}
			
			con.close();
			
			return check;
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
}
