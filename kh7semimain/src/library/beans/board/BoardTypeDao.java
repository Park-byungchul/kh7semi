package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import library.beans.JdbcUtils;

public class BoardTypeDao {
	public String getBoardName(int boardTypeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select board_type_name from board_type "
				+ "where board_type_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		String name = rs.getString(1);
		
		con.close();
		
		return name;
	}
}
