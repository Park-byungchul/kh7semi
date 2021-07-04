package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import library.beans.JdbcUtils;

public class AllBoardDao {
	public List<AllBoardDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select board_type_no, board_no, board_title, "
				+ "client_no, board_date, board_read from board "
				+ "union " 
				+ "select 4, review_no, review_subject, client_no, "
				+ "review_date, review_read from review "
				+ "order by board_date asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<AllBoardDto> boardList = new ArrayList<>();
		
		con.close();
		
		return boardList;
	}
}
