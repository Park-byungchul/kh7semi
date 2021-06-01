package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
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
	
	// notice sequence
	public int getNoticeSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select notice_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		
		int no = rs.getInt(1);
		con.close();
		
		return no;
	}
	
	// qna sequence
	public int getQnaSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select qna_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
			
		int no = rs.getInt(1);
		con.close();
			
		return no;
	}
	
	// freeboard sequence
	public int getFreeBoardSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select freeboard_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
				
		int no = rs.getInt(1);
		con.close();
				
		return no;
	}
	
	// review sequence
	public int getReviewSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();
				
		String sql = "select review_seq.nextval from dual";
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
				+ "values(?, ?, ?, ?, ?, ?, 0, 0, sysdate, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardDto.getBoardNo());
		ps.setInt(2, boardDto.getClientNo());
		ps.setInt(3, boardDto.getBoardTypeNo());
		
		if(boardDto.getAreaNo() == 0) {
			// 전체 도서관일 경우
			ps.setNull(4, Types.INTEGER);
		}
		else {
			ps.setInt(4, boardDto.getAreaNo());
		}
		
		ps.setString(5, boardDto.getBoardTitle());
		ps.setString(6, boardDto.getBoardField());
		ps.setInt(7, boardDto.getBoardSepNo());
		
		// 새글/답글일 경우 추가해야 함 (superNo, groupNo, Depth)
		
		ps.execute();
		con.close();
	}
	
	// 목록 조회
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
			boardDto.setBoardDate(rs.getDate("board_date"));
			boardDto.setBoardSepNo(rs.getInt("board_sep_no"));
			
			boardList.add(boardDto);
		}
		
		con.close();
		
		return boardList;
	}
	
	// 검색
	public List<BoardDto> search(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from board where instr(#1, ?) > 0";
		sql = sql.replace("#1", type);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();
		
		List<BoardDto> boardList = new ArrayList<>();
		
		while(rs.next()) {
			BoardDto boardDto = new BoardDto();
			
			boardDto.setBoardNo(rs.getInt("boardNo"));
			boardDto.setBoardNo(rs.getInt("clientNo"));
			boardDto.setBoardNo(rs.getInt("boardTypeNo"));
			boardDto.setBoardNo(rs.getInt("areaNo"));
			boardDto.setBoardTitle(rs.getString("boardTitle"));
			boardDto.setBoardTitle(rs.getString("boardContent"));
			boardDto.setBoardNo(rs.getInt("boardRead"));
			boardDto.setBoardNo(rs.getInt("boardLike"));
			boardDto.setBoardDate(rs.getDate("boardDate"));
			boardDto.setBoardNo(rs.getInt("boardSepNo"));
			
			boardList.add(boardDto);
		}
		
		con.close();
		
		return boardList;
	}
	
	// 상세보기 기능
	public BoardDto find(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select * from board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
			
		BoardDto boardDto;
			
		if(rs.next()) {
			boardDto = new BoardDto();

			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setClientNo(rs.getInt("client_no"));
			boardDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardDto.setAreaNo(rs.getInt("area_no"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardField(rs.getString("board_field"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardDate(rs.getDate("board_date"));
			boardDto.setBoardSepNo(rs.getInt("board_sep_no"));
		}
		else
			boardDto = null;
			
		con.close();
			
		return boardDto;
	}
	
	// 게시글 삭제
	public boolean delete(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	// 게시글 수정
	public boolean edit(BoardDto boardDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update board set area_no = ?, board_title = ?, "
				+ "board_field = ? where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		if(boardDto.getAreaNo() == 0) {
			// 전체 도서관일 경우
			ps.setNull(1, Types.INTEGER);
		}
		else {
			ps.setInt(1, boardDto.getAreaNo());
		}
		ps.setString(2, boardDto.getBoardTitle());
		ps.setString(3, boardDto.getBoardField());
		ps.setInt(4, boardDto.getBoardNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	// 상세보기 기능
	public BoardDto get(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
					
		String sql = "select * from board where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ResultSet rs = ps.executeQuery();
					
		BoardDto boardDto;
					
		if(rs.next()) {
			boardDto = new BoardDto();

			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setClientNo(rs.getInt("client_no"));
			boardDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardDto.setAreaNo(rs.getInt("area_no"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardField(rs.getString("board_field"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardDate(rs.getDate("board_date"));
			boardDto.setBoardSepNo(rs.getInt("board_sep_no"));
		}
		else
			boardDto = null;
					
		con.close();
				
		return boardDto;
	}
	
	// 조회수 증가 기능
	public boolean read(int boardNo, int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "update board set "
				+ "board_read = board_read + 1 "
				+ "where board_no = ? and client_no != ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ps.setInt(2, clientNo);
		int count = ps.executeUpdate();
			
		con.close();
			
		return count > 0;
	}
	
	// 좋아요 갱신 기능
	public boolean refreshBoardLike(int boardNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update board "
				+ "set board_like = (select count(*) from board_like where board_no = ?) "
				+ "where board_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardNo);
		ps.setInt(2, boardNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	//이전글 조회 기능
	public BoardDto getPrevious(int boardTypeNo, int boardSepNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select * from board "
				+ "where board_no = "
				+ "(select max(board_no) from board where board_type_no = ? and board_sep_no < ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ps.setInt(2, boardSepNo);
		ResultSet rs = ps.executeQuery();
			
		BoardDto boardDto;
			
		if(rs.next()) {
			boardDto = new BoardDto();
				
			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setClientNo(rs.getInt("client_no"));
			boardDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardDto.setAreaNo(rs.getInt("area_no"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardField(rs.getString("board_field"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardDate(rs.getDate("board_date"));
			boardDto.setBoardSepNo(rs.getInt("board_sep_no"));
		}
		else {
			boardDto = null;
		}
			
		con.close();
			
		return boardDto;
	}
		
	//다음글 조회 기능
	public BoardDto getNext(int boardTypeNo, int boardSepNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
			
		String sql = "select * from board "
				+ "where board_no = "
				+ "(select min(board_no) from board where board_type_no = ? and board_sep_no > ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, boardTypeNo);
		ps.setInt(2, boardSepNo);
		ResultSet rs = ps.executeQuery();
			
		BoardDto boardDto;
			
		if(rs.next()) {
			boardDto = new BoardDto();
				
			boardDto.setBoardNo(rs.getInt("board_no"));
			boardDto.setClientNo(rs.getInt("client_no"));
			boardDto.setBoardTypeNo(rs.getInt("board_type_no"));
			boardDto.setAreaNo(rs.getInt("area_no"));
			boardDto.setBoardTitle(rs.getString("board_title"));
			boardDto.setBoardField(rs.getString("board_field"));
			boardDto.setBoardRead(rs.getInt("board_read"));
			boardDto.setBoardLike(rs.getInt("board_like"));
			boardDto.setBoardDate(rs.getDate("board_date"));
			boardDto.setBoardSepNo(rs.getInt("board_sep_no"));
		}
		else {
			boardDto = null;
		}
		
		con.close();
		
		return boardDto;
	}
}