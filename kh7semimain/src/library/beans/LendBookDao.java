package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class LendBookDao {
	
//	도서 대출 메소드
//	= 입력 : (대출번호, 회원번호, 입고번호, 책번호, 지점번호, 대출일, 반납기한, 반납일)
//	= 출력(반환) : 없음(void)
	public void lendBook(LendBookDto lendbookDto) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into lend_book values("
				+ "lend_book_seq.nextval, ?, ?, ?, ?, sysdate, ?, 'null')";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, lendbookDto.getClientNo());
		ps.setInt(2, lendbookDto.getGetBookNo());
		ps.setInt(3, lendbookDto.getBookIsbn());
		ps.setDate(4, lendbookDto.getLendBookLimit());
		ps.setInt(5, lendbookDto.getClientNo());
		
		ps.execute();
		
		con.close();
	}

}
