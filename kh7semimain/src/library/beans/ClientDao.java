package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class ClientDao {
	public void insert(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into client "
				+ "(client_no, client_id, client_pw, client_name, client_email) "
				+ "values(client_seq.nextval, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ps.setString(3, clientDto.getClientName());
		ps.setString(4, clientDto.getClientEmail());
		ps.execute();
		
		con.close();
	}
}
