package library.beans.board;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import library.beans.JdbcUtils;

public class BoardListDao {
	public List<BoardListDto> list(int boardTypeNo, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "select * from board_list where board_type_no = ? order by board_no desc"
				+ ")TMP"
			+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
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
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
			
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
	
	public List<BoardListDto> list(int boardTypeNo, int areaNo, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
					+ "select * from board_list where board_type_no = ? and (area_no is null or area_no = ?) order by board_no desc"
				+ ")TMP"
			+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ps.setInt(2, areaNo);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
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
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
			
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

	// 검색 (도서관 포함)
	public List<BoardListDto> search(int boardTypeNo, int areaNo, String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from board_list where instr(#1, ?) > 0 and board_type_no = ? and (area_no is null or area_no = ?) order by board_no desc"
					+ ")TMP"
				+ ") where rn between ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, boardTypeNo);
		ps.setInt(3, areaNo);
		ps.setInt(4, startRow);
		ps.setInt(5, endRow);
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
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
			
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
	
	// 검색
	public List<BoardListDto> search(int boardTypeNo, String type, String keyword, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
					+ "select rownum rn, TMP.* from ("
						+ "select * from board_list where instr(#1, ?) > 0 and board_type_no = ? order by board_no desc"
					+ ")TMP"
				+ ") where rn between ? and ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, boardTypeNo);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
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
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
			
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
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
				
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
	
	public int getCount(int boardTypeNo, int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from board_list where board_type_no = ? and (area_no is null or area_no = ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ps.setInt(2, areaNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount(int boardTypeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from board_list where board_type_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount(String type, int areaNo, String keyword, int boardTypeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from board_list where instr(#1, ?) > 0 and board_type_no = ? and (area_no is null or area_no = ?)";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, boardTypeNo);
		ps.setInt(3, areaNo);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	public int getCount(String type, String keyword, int boardTypeNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from board_list where instr(#1, ?) > 0 and board_type_no = ?";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ps.setInt(2, boardTypeNo);
		
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}
	
	// 메인도서관 공지사항 (상위 1~4번째 글)
	public List<BoardListDto> mainNotice() throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from board_list where board_type_no = 1 "
				+ "order by board_date desc"
				+ ")TMP"
				+ ") where rn between 1 and 4";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
				
		List<BoardListDto> boardList = new ArrayList<>();
				
		while(rs.next()) {
			BoardListDto boardListDto = new BoardListDto();

			boardListDto.setBoardNo(rs.getInt("board_no"));
			boardListDto.setClientNo(rs.getInt("client_no"));
			boardListDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardListDto.setAreaNo(rs.getInt("area_no"));
			boardListDto.setBoardTitle(rs.getString("board_title"));
			boardListDto.setBoardRead(rs.getInt("board_read"));
			boardListDto.setBoardLike(rs.getInt("board_like"));
			boardListDto.setBoardDate(rs.getDate("board_date"));
			boardListDto.setBoardSepNo(rs.getInt("board_sep_no"));
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
				
			boardListDto.setClientNo(rs.getInt("client_no"));
			boardListDto.setClientName(rs.getString("client_name"));
			
			boardListDto.setAreaNo(rs.getInt("area_no"));				
			boardListDto.setAreaName(rs.getString("area_name"));
			
			boardListDto.setTypeNo(rs.getInt("type_no"));
			boardListDto.setBoardTypeName(rs.getString("board_type_name"));
			
			boardList.add(boardListDto);
		}
				
		con.close();
				
		return boardList;
	}
	
	// 지점도서관 공지사항 (상위 1~4번째 글)
	public List<BoardListDto> mainNotice(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from ("
				+ "select * from board_list where board_type_no = 1 "
				+ "and (area_no is null or area_no = ?)"
				+ "order by board_date desc"
				+ ")TMP"
				+ ") where rn between 1 and 4";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ResultSet rs = ps.executeQuery();
				
		List<BoardListDto> boardList = new ArrayList<>();
				
		while(rs.next()) {
			BoardListDto boardListDto = new BoardListDto();

			boardListDto.setBoardNo(rs.getInt("board_no"));
			boardListDto.setClientNo(rs.getInt("client_no"));
			boardListDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardListDto.setAreaNo(rs.getInt("area_no"));
			boardListDto.setBoardTitle(rs.getString("board_title"));
			boardListDto.setBoardRead(rs.getInt("board_read"));
			boardListDto.setBoardLike(rs.getInt("board_like"));
			boardListDto.setBoardDate(rs.getDate("board_date"));
			boardListDto.setBoardSepNo(rs.getInt("board_sep_no"));
			boardListDto.setBoardReply(rs.getInt("board_reply"));
			boardListDto.setBoardOpen(rs.getString("board_open"));
				
			boardListDto.setClientNo(rs.getInt("client_no"));
			boardListDto.setClientName(rs.getString("client_name"));
			
			boardListDto.setAreaNo(rs.getInt("area_no"));				
			boardListDto.setAreaName(rs.getString("area_name"));
			
			boardListDto.setTypeNo(rs.getInt("type_no"));
			boardListDto.setBoardTypeName(rs.getString("board_type_name"));
			
			boardList.add(boardListDto);
		}
				
		con.close();
				
		return boardList;
	}
}
