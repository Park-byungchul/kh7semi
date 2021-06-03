package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

public class LendBookDao {
	
//	도서 대출접수 메소드
//	= 입력 : (대출번호, 회원번호, 입고번호, 책번호, 지점번호, 대출일, 반납기한, 반납일)
//	= 출력(반환) : 없음(void)
	public void lendBookInsert(LendBookDto lendbookDto) throws Exception{
		
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
	}
	
//	도서 반납 메소드
	public boolean lendBookUpdate(LendBookDto lendBookDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
							//반납한책(getBookNo)의 반납일을 sysdate로 업데이트 해준다.
		String sql = "update lend_book set return_book_date = sysdate where get_book_no=?";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, lendBookDto.getGetBookNo());
		
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	//대여가능 여부 확인 메소드??
	public boolean lendBookCheck(int getBookNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from lend_book l right outer join get_book  g on l.get_book_no = g.get_book_no where g.get_book_no = ? order by l.lend_book_no desc;";
	      PreparedStatement ps = con.prepareStatement(sql);
	      ps.setInt(1,  getBookNo);
	      ResultSet rs = ps.executeQuery();
	      
	      
	      if(rs.getDate("lend_book_date") == null) {
	        return (true);//(대여가능)
	      }
	      else if(rs.getDate("return_book_date") == null) {
	        return (false);//(현재대여중)
	      }
		  else {
			  return true; //(대여가능)
		  }
	
	}
}
