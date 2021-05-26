package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class HopelistDao {

	public static final String USERNAME = "kh7semi2";
	public static final String PASSWORD = "kh7semi2";
	
	public void insert(HopelistDto hopelistDto) throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "insert into hopelist values(hopelist_seq.nextval,?,?,?,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, hopelistDto.getClientNo());
		ps.setInt(2, hopelistDto.getBookIsbn());
		ps.setString(3, hopelistDto.getHopelistReason());
		ps.setDate(4, hopelistDto.getHopelistDate());
		ps.execute();
		con.close();
	}
}
