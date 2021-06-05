package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class NewBookDao {
	
	//전체리스트
	public List<NewBookDto> newBookList(int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
								+ "select rownum rn, TMP.* from("
									+ "select * from newBook where sysdate-90 < to_date(get_book_date, 'YY/MM/DD') order by book_title asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, startRow);
		ps.setInt(2, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<NewBookDto> list = new ArrayList<>();
		while(rs.next()) {
			NewBookDto newBookDto = new NewBookDto();
			newBookDto.setAreaName(rs.getString("area_name"));
			newBookDto.setBookAuthor(rs.getString("book_author"));
			newBookDto.setBookDate(rs.getDate("book_date"));
			newBookDto.setBookImg(rs.getString("book_img"));
			newBookDto.setBookIsbn(rs.getString("book_isbn"));
			newBookDto.setBookPublisher(rs.getString("book_publisher"));
			newBookDto.setBookTitle(rs.getString("book_title"));
			newBookDto.setGenreName(rs.getString("genre_name"));
			newBookDto.setGetBookDate(rs.getDate("get_book_date"));
			
			list.add(newBookDto);
		}
		
		con.close();
		return list;
	}
	
	//도서관 or 장르 중 하나만 선택 + 기간선택(미선택시 기본값 3달이내)
	public List<NewBookDto> newBookList1(String typeVal, int term, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "";
		if(typeVal.equals("강남도서관") || typeVal.equals("종로도서관") || typeVal.equals("당산도서관")) {
		sql = "select * from("
					+ "select rownum rn, TMP.* from("
					+ "select * from newBook where sysdate-? < to_date(get_book_date, 'YY/MM/DD') "
					+ "and area_name = ? order by book_title asc"
					+ ")TMP"
					+ ") where rn between ? and ?";	
		}
		else {
		sql = "select * from("
					+ "select rownum rn, TMP.* from("
					+ "select * from newBook where sysdate-? < to_date(get_book_date, 'YY/MM/DD') "
					+ "and genre_name = ? order by book_title asc"
					+ ")TMP"
					+ ") where rn between ? and ?";	
		}
		PreparedStatement ps = con.prepareStatement(sql);
		
		
		ps.setInt(1, term);
		ps.setString(2, typeVal);
		ps.setInt(3, startRow);
		ps.setInt(4, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<NewBookDto> list = new ArrayList<>();
		while(rs.next()) {
			NewBookDto newBookDto = new NewBookDto();
			newBookDto.setAreaName(rs.getString("area_name"));
			newBookDto.setBookAuthor(rs.getString("book_author"));
			newBookDto.setBookDate(rs.getDate("book_date"));
			newBookDto.setBookImg(rs.getString("book_img"));
			newBookDto.setBookIsbn(rs.getString("book_isbn"));
			newBookDto.setBookPublisher(rs.getString("book_publisher"));
			newBookDto.setBookTitle(rs.getString("book_title"));
			newBookDto.setGenreName(rs.getString("genre_name"));
			newBookDto.setGetBookDate(rs.getDate("get_book_date"));
			
			list.add(newBookDto);
		}
		
		con.close();
		return list;
	}
	
	
	
	//기간만 선택
	public List<NewBookDto> newBookList2(int term, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
								+ "select rownum rn, TMP.* from("
									+ "select * from newBook where sysdate-? < to_date(get_book_date, 'YY/MM/DD') order by book_title asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, term);
		ps.setInt(2, startRow);
		ps.setInt(3, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<NewBookDto> list = new ArrayList<>();
		while(rs.next()) {
			NewBookDto newBookDto = new NewBookDto();
			newBookDto.setAreaName(rs.getString("area_name"));
			newBookDto.setBookAuthor(rs.getString("book_author"));
			newBookDto.setBookDate(rs.getDate("book_date"));
			newBookDto.setBookImg(rs.getString("book_img"));
			newBookDto.setBookIsbn(rs.getString("book_isbn"));
			newBookDto.setBookPublisher(rs.getString("book_publisher"));
			newBookDto.setBookTitle(rs.getString("book_title"));
			newBookDto.setGenreName(rs.getString("genre_name"));
			newBookDto.setGetBookDate(rs.getDate("get_book_date"));
			
			list.add(newBookDto);
		}
		
		con.close();
		return list;
	}
	
	//도서관+기간+장르 선택
	public List<NewBookDto> newBookList3(int term, String areaName, String genreName, int startRow, int endRow) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from("
								+ "select rownum rn, TMP.* from("
									+ "select * from newBook "
									+ "where sysdate-? < to_date(get_book_date, 'YY/MM/DD') "
									+ "and area_name = ? "
									+ "and genre_name = ? order by book_title asc"
								+ ")TMP"
							+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, term);
		ps.setString(2, areaName);
		ps.setString(3, genreName);
		ps.setInt(4, startRow);
		ps.setInt(5, endRow);
		ResultSet rs = ps.executeQuery();
		
		List<NewBookDto> list = new ArrayList<>();
		while(rs.next()) {
			NewBookDto newBookDto = new NewBookDto();
			newBookDto.setAreaName(rs.getString("area_name"));
			newBookDto.setBookAuthor(rs.getString("book_author"));
			newBookDto.setBookDate(rs.getDate("book_date"));
			newBookDto.setBookImg(rs.getString("book_img"));
			newBookDto.setBookIsbn(rs.getString("book_isbn"));
			newBookDto.setBookPublisher(rs.getString("book_publisher"));
			newBookDto.setBookTitle(rs.getString("book_title"));
			newBookDto.setGenreName(rs.getString("genre_name"));
			newBookDto.setGetBookDate(rs.getDate("get_book_date"));
			
			list.add(newBookDto);
		}
		
		con.close();
		return list;
	}
	
	//페이지블럭 계산을 위한 카운트 기능(목록/검색)
	public int getCount() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from newBook";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		
		return count;
	}	
	
	//신착도서 1~3위 메인페이지용
	public List<NewBookDto> rank(int begin, int end) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from newbook order by get_book_date desc"
							+ ") TMP"
						+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		
		//List로 변환
		List<NewBookDto> newBookList = new ArrayList<>();
		while(rs.next()) {
			NewBookDto newBookDto = new NewBookDto();

			newBookDto.setGenreName(rs.getString("genre_name"));
			newBookDto.setBookAuthor(rs.getString("book_author"));
			newBookDto.setBookTitle(rs.getString("book_title"));
			newBookDto.setBookImg(rs.getString("book_img"));
			
			newBookList.add(newBookDto);
		}
		
		con.close();
		
		return newBookList;
	}
}
