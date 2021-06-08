package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class ReservationDao {
	
	public void reservate(ReservationDto reservationDto) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into reservation values("
							+ "reservation_seq.nextval, ?, ?, sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reservationDto.getClientNo());
		ps.setInt(2, reservationDto.getGetBookNo());
		
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(int clientNo ,int getBookNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete reservation where client_no = ? and get_book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setInt(2, getBookNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
				
	}
	public int check(int getBookNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		String sql = "select * from reservation where get_book_no=?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, getBookNo);
		ResultSet rs = ps.executeQuery();
		
		int result;
		if(rs.next()) {
			result= rs.getInt("client_no");
			System.out.println(result);
		}
		else {
			result = -1;
		}
		
		con.close();
		return result;
	}
}
