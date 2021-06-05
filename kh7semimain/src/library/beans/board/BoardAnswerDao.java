package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import library.beans.JdbcUtils;

public class BoardAnswerDao {
	public void receipt(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into board_answer "
				+ "values(?, '접수중', null, '아직 답변이 등록되지 않았습니다.', null)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ps.execute();
		
		con.close();
	}
	
	public boolean answer(BoardAnswerDto boardAnswerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update board_answer "
				+ "set board_status = '답변완료', client_no = ?, answer_content = ?, answer_date = sysdate "
				+ "where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardAnswerDto.getClientNo());
		ps.setString(2, boardAnswerDto.getAnswerContent());
		ps.setInt(3, boardAnswerDto.getBoardNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public BoardAnswerDto get(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board_answer where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
		
		BoardAnswerDto answerDto;
		
		if(rs.next()) {
			answerDto = new BoardAnswerDto();
			
			answerDto.setBoardNo(rs.getInt("board_no"));
			answerDto.setBoardStatus(rs.getString("board_status"));
			answerDto.setClientNo(rs.getInt("client_no"));
			answerDto.setAnswerContent(rs.getString("answer_content"));
			answerDto.setAnswerDate(rs.getDate("answer_date"));
		}
		else 
			answerDto = null;
		
		con.close();
		
		return answerDto;
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
	
	public String getAnswerStatus(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select board_status from board_answer where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		String status = rs.getString(1);
		
		con.close();
				
		return status;
	}
}
