package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

//searchList에 보여질 dto리스트 만드는 함수
public class GetBookSearchDao {
	public List<GetBookSearchDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from get_book_search_view order by book_title asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();

		List<GetBookSearchDto> getBookSearchList = new ArrayList<>();

		while (rs.next()) {
			GetBookSearchDto getBookSearchDto = new GetBookSearchDto();
			getBookSearchDto.setGetBookNo(rs.getInt("get_book_no"));
			getBookSearchDto.setAreaName(rs.getString("area_name"));
			getBookSearchDto.setBookIsbn(rs.getString("book_isbn"));
			getBookSearchDto.setBookAuthor(rs.getString("book_author"));
			getBookSearchDto.setBookTitle(rs.getString("book_title"));
			getBookSearchDto.setGetBookDate(rs.getDate("get_book_date"));
			getBookSearchDto.setBookPublisher(rs.getString("book_publisher"));
			getBookSearchDto.setBookDate(rs.getDate("book_date"));
			getBookSearchDto.setBookContent(rs.getString("book_content"));
			getBookSearchDto.setBookImg(rs.getString("book_img"));
			if(rs.getString("lend_book_date") != null) {
				getBookSearchDto.setGetBookStatus("대여중");
			}
			else if(rs.getString("reservation_date") != null) {
				getBookSearchDto.setGetBookStatus("예약중");
			}
			else {
				getBookSearchDto.setGetBookStatus("대여가능");
			}
			
			getBookSearchList.add(getBookSearchDto);
		}

		con.close();

		return getBookSearchList;
	}

	// 입고된 책 검색 기능
	public List<GetBookSearchDto> searchList(String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from get_book_search_view "
				+ "where (book_title || book_author) like '%'||?||'%' "
				+ "order by book_title asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<GetBookSearchDto> getBookSearchList = new ArrayList<>();

		while (rs.next()) {
			GetBookSearchDto getBookSearchDto = new GetBookSearchDto();
			getBookSearchDto.setGetBookNo(rs.getInt("get_book_no"));
			getBookSearchDto.setAreaName(rs.getString("area_name"));
			getBookSearchDto.setBookIsbn(rs.getString("book_isbn"));
			getBookSearchDto.setBookAuthor(rs.getString("book_author"));
			getBookSearchDto.setBookTitle(rs.getString("book_title"));
			getBookSearchDto.setGetBookDate(rs.getDate("get_book_date"));
			getBookSearchDto.setBookPublisher(rs.getString("book_publisher"));
			getBookSearchDto.setBookDate(rs.getDate("book_date"));
			getBookSearchDto.setBookContent(rs.getString("book_content"));
			getBookSearchDto.setBookImg(rs.getString("book_img"));
			if(rs.getString("lend_book_date") != null) {
				getBookSearchDto.setGetBookStatus("대여중");
			}
			else if(rs.getString("reservation_date") != null) {
				getBookSearchDto.setGetBookStatus("예약중");
			}
			else {
				getBookSearchDto.setGetBookStatus("대여가능");
			}
			
			getBookSearchList.add(getBookSearchDto);
		}

		con.close();

		return getBookSearchList;

	}

	public List<GetBookSearchDto> searchList(String type, String keyword) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from get_book_search_view " 
				+ "where #1 like '%'||?||'%' order by #1 asc";
		sql = sql.replace("#1", type);
		System.out.println(sql);
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, keyword);
		ResultSet rs = ps.executeQuery();

		List<GetBookSearchDto> getBookSearchList = new ArrayList<>();

		while (rs.next()) {
			GetBookSearchDto getBookSearchDto = new GetBookSearchDto();
			getBookSearchDto.setGetBookNo(rs.getInt("get_book_no"));
			getBookSearchDto.setAreaName(rs.getString("area_name"));
			getBookSearchDto.setBookIsbn(rs.getString("book_isbn"));
			getBookSearchDto.setBookAuthor(rs.getString("book_author"));
			getBookSearchDto.setBookTitle(rs.getString("book_title"));
			getBookSearchDto.setGetBookDate(rs.getDate("get_book_date"));
			getBookSearchDto.setBookPublisher(rs.getString("book_publisher"));
			getBookSearchDto.setBookDate(rs.getDate("book_date"));
			getBookSearchDto.setBookContent(rs.getString("book_content"));
			getBookSearchDto.setBookImg(rs.getString("book_img"));
			if(rs.getString("lend_book_date") != null) {
				getBookSearchDto.setGetBookStatus("대여중");
			}
			else if(rs.getString("reservation_date") != null) {
				getBookSearchDto.setGetBookStatus("예약중");
			}
			else {
				getBookSearchDto.setGetBookStatus("대여가능");
			}
			
			getBookSearchList.add(getBookSearchDto);
		}

		con.close();

		return getBookSearchList;

	}
	
	public GetBookSearchDto get(int getBookNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from get_book_search_view where get_book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, getBookNo);
		ResultSet rs = ps.executeQuery();
		
		GetBookSearchDto getBookSearchDto;
		if(rs.next()) {
			getBookSearchDto = new GetBookSearchDto();
			
			getBookSearchDto.setGetBookNo(rs.getInt("get_book_no"));
			getBookSearchDto.setAreaName(rs.getString("area_name"));
			getBookSearchDto.setBookIsbn(rs.getString("book_isbn"));
			getBookSearchDto.setBookAuthor(rs.getString("book_author"));
			getBookSearchDto.setBookTitle(rs.getString("book_title"));
			getBookSearchDto.setGetBookDate(rs.getDate("get_book_date"));
			getBookSearchDto.setBookPublisher(rs.getString("book_publisher"));
			getBookSearchDto.setBookDate(rs.getDate("book_date"));
			getBookSearchDto.setBookContent(rs.getString("book_content"));
			getBookSearchDto.setBookImg(rs.getString("book_img"));
			if(rs.getString("lend_book_date") != null) {
				getBookSearchDto.setGetBookStatus("대여중");
			}
			else if(rs.getString("reservation_date") != null) {
				getBookSearchDto.setGetBookStatus("예약중");
			}
			else {
				getBookSearchDto.setGetBookStatus("대여가능");
			}
		}
		else {
			getBookSearchDto = null;
		}
		
		con.close();
		
		return getBookSearchDto;
	}
}
