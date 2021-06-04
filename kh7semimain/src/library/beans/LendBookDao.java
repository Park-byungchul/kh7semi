package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class LendBookDao {
	
//	도서 대출접수 메소드
//	= 입력 : (대출번호, 회원번호, 입고번호, 책번호, 지점번호, 대출일, 반납기한, 반납일)
//	= 출력(반환) : 없음(void)
	public boolean lendBookInsert(LendBookDto lendbookDto) throws Exception{
		
		
		GetBookDao getBookDao = new GetBookDao();
		ClientDao clientDao = new ClientDao();
		boolean check;
		if(!getBookDao.check(lendbookDto.getGetBookNo())) {
			check = false;
		} else if (!clientDao.checkOverlap(lendbookDto.getClientNo())) {
			check = false;
		} else {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "insert into lend_book values("
					+ "lend_book_seq.nextval, ?, ?, ?, ?, sysdate, sysdate+14, null)";
			
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, lendbookDto.getClientNo());
			ps.setInt(2, lendbookDto.getGetBookNo());
			ps.setString(3, lendbookDto.getBookIsbn());
			ps.setInt(4, lendbookDto.getAreaNo());
			
			ps.execute();
			con.close();
			check = true;
		}
		return check;
	}
	
//	도서 반납 메소드
	public boolean lendBookUpdate(int getBookNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
							//반납한책(getBookNo)의 반납일을 sysdate로 업데이트 해준다.
		String sql = "update lend_book_view set return_book_date = sysdate where get_book_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, getBookNo);
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public boolean get(int getBookNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from lend_book_view where get_book_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, getBookNo);
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		
		return result;
	}
	//lendBookList에 보여질 dto리스트 만드는 함수

		public List<LendBookDto> list(int keyword) throws Exception {
			Connection con = JdbcUtils.getConnection();

			String sql = "select * from lend_book_view "
					+ "where client_no = ? "
					+ "order by lend_book_date desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, keyword);
			ResultSet rs = ps.executeQuery();

			List<LendBookDto> lendBookList = new ArrayList<>();

			while (rs.next()) {
				LendBookDto lendBookDto = new LendBookDto();
				lendBookDto.setClientNo(rs.getInt("client_no"));
				lendBookDto.setGetBookNo(rs.getInt("get_book_no"));
				lendBookDto.setBookTitle(rs.getString("book_title"));
				lendBookDto.setLendBookDate(rs.getDate("lend_book_date"));
				lendBookDto.setLendBookLimit(rs.getDate("lend_book_limit"));
				
				
				lendBookList.add(lendBookDto);
			}

			con.close();

			return lendBookList;
		}
		
		public List<LendBookDto> list() throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from lend_book_view order by lend_book_date desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			
			List<LendBookDto> lendBookList = new ArrayList<>();
			
			while (rs.next()) {
				LendBookDto lendBookDto = new LendBookDto();
				lendBookDto.setClientNo(rs.getInt("client_no"));
				lendBookDto.setGetBookNo(rs.getInt("get_book_no"));
				lendBookDto.setBookTitle(rs.getString("book_title"));
				lendBookDto.setLendBookDate(rs.getDate("lend_book_date"));
				lendBookDto.setLendBookLimit(rs.getDate("lend_book_limit"));
				
				
				lendBookList.add(lendBookDto);
			}
			
			con.close();
			
			return lendBookList;
		}
		
		
}
