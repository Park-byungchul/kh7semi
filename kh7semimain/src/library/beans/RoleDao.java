package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;

public class RoleDao {
	public boolean delete(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete role where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	public boolean insert(RoleDto roleDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "insert into role (client_no, area_no) values(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, roleDto.getClientNo());
		ps.setInt(2, roleDto.getAreaNo());
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
}
