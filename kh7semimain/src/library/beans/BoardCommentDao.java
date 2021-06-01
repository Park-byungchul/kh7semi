package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardCommentDao {
	public void insert(BoardCommentDto boardCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into board_comment "
				+ "values(comment_seq.nextval, ?, ?, ?, sysdate, 0, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardCommentDto.getClientNo());
		ps.setInt(2, boardCommentDto.getBoardNo());
		ps.setString(3, boardCommentDto.getCommentContent());
		ps.setInt(4, boardCommentDto.getBoardTypeNo());
		ps.execute();
		
		con.close();
	}
	
	public boolean edit(BoardCommentDto boardCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update board_comment set comment_content = ? "
				+ "where comment_no = ? and client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, boardCommentDto.getCommentContent());
		ps.setInt(2, boardCommentDto.getCommentNo());
		ps.setInt(3, boardCommentDto.getClientNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean delete(BoardCommentDto boardCommentDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete board_comment where comment_no = ? and client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardCommentDto.getCommentNo());
		ps.setInt(2, boardCommentDto.getClientNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public List<BoardCommentDto> list(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board_comment where board_no = ? order by comment_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
		
		List<BoardCommentDto> commentList = new ArrayList<>();
		
		while(rs.next()) {
			BoardCommentDto boardCommentDto = new BoardCommentDto();
			
			boardCommentDto.setCommentNo(rs.getInt("comment_no"));
			boardCommentDto.setClientNo(rs.getInt("client_no"));
			boardCommentDto.setBoardNo(rs.getInt("board_no"));
			boardCommentDto.setCommentContent(rs.getString("comment_content"));
			boardCommentDto.setCommentDate(rs.getDate("comment_date"));
			boardCommentDto.setCommentLike(rs.getInt("comment_like"));
			boardCommentDto.setBoardTypeNo(rs.getInt("board_type_no"));
			
			commentList.add(boardCommentDto);
		}
		
		con.close();
		
		return commentList;
	}
	
	public String getClientName(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select client_name from client where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		String name = rs.getString(1);
		con.close();
				
		return name;
	}
}
