package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ReservationDao {
	
//	도서 예약 메소드
//	= 입력 : 예약번호, 회원번호, 입고번호, 예약일
//	= 출력(반환) : 없음(void)
	public void reservate(ReservationDto reservationDto) throws Exception{
		
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into reservation values("
							+ "reservation_seq.nextval, ?, ?, sysdate)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, reservationDto.getClientNo());
		ps.setInt(2, reservationDto.getGetBookNo());
		
		ps.execute();
		
		con.close();
	}

}
