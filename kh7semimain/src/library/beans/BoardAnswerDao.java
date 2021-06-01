package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class BoardAnswerDao {
	public void write(BoardAnswerDto boardAnswerDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into board_answer "
				+ "values(?, '답변완료', ?, ?, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardAnswerDto.getBoardNo());
		ps.setInt(2, boardAnswerDto.getClientNo());
		ps.setString(3, boardAnswerDto.getAnswerContent());
		ps.execute();
		
		con.close();
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
}
