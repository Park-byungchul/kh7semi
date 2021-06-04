package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BookCountDao {
	
	//전체 책
	public int count() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from get_book";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		con.close();
		
		return no;
	}
	
	//지점별 카운트
	public int count(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from get_book where area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		con.close();
		
		return no;
	}
	// 전체 대여가능권수
		public int lendAbleCount() throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select count(*) from get_book_search_view where lend_book_date is null and reservation_date is null";
			PreparedStatement ps = con.prepareStatement(sql);
			
			ResultSet rs = ps.executeQuery();
			rs.next();
			int no = rs.getInt(1);
			con.close();
			
			return no;
		}
		
		public int lendAbleCount(int areaNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select count(*) from get_book_search_view where lend_book_date is null and reservation_date is null and area_name=?";
			PreparedStatement ps = con.prepareStatement(sql);
			AreaDao areaDao = new AreaDao();
			AreaDto areaDto = areaDao.detail(areaNo);
			ps.setString(1, areaDto.getAreaName());

			ResultSet rs = ps.executeQuery();
			rs.next();
			int no = rs.getInt(1);
			con.close();
			
			return no;
		}	
	
}

