package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class BoardListDao {
	public List<BoardListDto> list(int boardTypeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board_list where board_type_no = ? order by board_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ResultSet rs = ps.executeQuery();
		
		List<BoardListDto> boardList = new ArrayList<>();
		
		while(rs.next()) {
			BoardListDto boardListDto = new BoardListDto();
			
			boardListDto.setBoardNo(rs.getInt("board_no"));
			boardListDto.setBoardWriter(rs.getInt("board_writer"));
			boardListDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardListDto.setAreaNo(rs.getInt("board_area"));
			boardListDto.setBoardTitle(rs.getString("board_title"));
			boardListDto.setBoardRead(rs.getInt("board_read"));
			boardListDto.setBoardLike(rs.getInt("board_like"));
			boardListDto.setBoardDate(rs.getDate("board_date"));
			boardListDto.setBoardSepNo(rs.getInt("board_sep_no"));
			
			boardListDto.setClientNo(rs.getInt("client_no"));
			boardListDto.setClientName(rs.getString("client_name"));
			
			boardListDto.setAreaNo(rs.getInt("area_no"));
			boardListDto.setAreaName(rs.getString("area_name"));
			
			boardListDto.setTypeNo(rs.getInt("type_no"));
			boardListDto.setBoardTypeName(rs.getString("board_type_no"));
			
			boardList.add(boardListDto);
		}
		
		con.close();
		
		return boardList;
	}
	
	// 상세보기 기능
		public BoardListDto find(int boardNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
				
			String sql = "select * from board_list where board_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, boardNo);
			ResultSet rs = ps.executeQuery();
				
			BoardListDto boardListDto;
				
			if(rs.next()) {
				boardListDto = new BoardListDto();

				boardListDto.setBoardNo(rs.getInt("board_no"));
				boardListDto.setClientNo(rs.getInt("client_no"));
				boardListDto.setBoardTypeNo(rs.getInt("board_type_no"));
				boardListDto.setAreaNo(rs.getInt("area_no"));
				boardListDto.setBoardTitle(rs.getString("board_title"));
				boardListDto.setBoardRead(rs.getInt("board_read"));
				boardListDto.setBoardLike(rs.getInt("board_like"));
				boardListDto.setBoardDate(rs.getDate("board_date"));
				boardListDto.setBoardSepNo(rs.getInt("board_sep_no"));
				
				boardListDto.setClientNo(rs.getInt("client_no"));
				boardListDto.setClientName(rs.getString("client_name"));
				
				boardListDto.setAreaNo(rs.getInt("area_no"));
				boardListDto.setAreaName(rs.getString("area_name"));
				
				boardListDto.setTypeNo(rs.getInt("type_no"));
				boardListDto.setBoardTypeName(rs.getString("board_type_name"));
			}
			else
				boardListDto = null;
				
			con.close();
				
			return boardListDto;
		}
}
