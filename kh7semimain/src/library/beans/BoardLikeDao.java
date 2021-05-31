package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardLikeDao {
	public void insert(BoardLikeDto boardLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into board_like values(?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardLikeDto.getClientNo());
		ps.setInt(2, boardLikeDto.getBoardNo());
		ps.execute();
		
		con.close();
	}
	
	public boolean delete(BoardLikeDto boardLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete board_like where client_no = ? and board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardLikeDto.getClientNo());
		ps.setInt(2, boardLikeDto.getBoardNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean check(BoardLikeDto boardLikeDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board_like where client_no = ? and board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardLikeDto.getClientNo());
		ps.setInt(2, boardLikeDto.getBoardNo());
		ResultSet rs = ps.executeQuery();
		
		boolean isTrue = false;
		if(rs.next()) {
			isTrue = true;
		}
		
		con.close();
		
		return isTrue;
	}
}
