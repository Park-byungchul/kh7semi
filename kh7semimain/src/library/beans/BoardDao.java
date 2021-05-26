package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardDao {
	// sequence에서 글 번호 뽑아오기
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select board_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int no = rs.getInt(1);
		con.close();
		
		return no;
	}
	
	// 새글쓰기
	public void write(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into board "
				+ "values(?, ?, ?, ?, ?, ?, 0, 0, sysdate)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardDto.getBoardNo());
		ps.setInt(2, boardDto.getClientNo());
		ps.setInt(3, boardDto.getBoardTypeNo());
		ps.setInt(4, boardDto.getAreaNo());
		ps.setString(5, boardDto.getBoardTitle());
		ps.setString(6, boardDto.getBoardField());
		
		// 새글/답글일 경우 추가해야 함 (superNo, groupNo, Depth)
		
		ps.execute();
		con.close();
	}
	
	// 목록 조회 (일단 단순하게 구현)
	public List<BoardDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> boardList = new ArrayList<>();
		
		while(rs.next()) {
			BoardDto boardDto = new BoardDto();
			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setClientNo(rs.getInt("client_no"));
			boardDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardDto.setAreaNo(rs.getInt("area_no"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardField(rs.getString("board_field"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardDate(rs.getDate("board_time"));
			
			boardList.add(boardDto);
		}
		
		con.close();
		
		return boardList;
	}
}