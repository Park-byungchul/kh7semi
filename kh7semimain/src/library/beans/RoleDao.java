package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

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
	
	public boolean delete(int roleClientNo, int roleAreaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete role where client_no = ? and area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, roleClientNo);
		ps.setInt(2, roleAreaNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0 ;
	}
	
	
	public boolean edit(RoleDto roleDto, int roleClientNo, int roleAreaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update role set client_no = ?, area_no = ? where client_no = ? and area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, roleDto.getClientNo());
		ps.setInt(2, roleDto.getAreaNo());
		ps.setInt(3, roleClientNo);
		ps.setInt(4, roleAreaNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	public boolean isAdmin(int clientNo, int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from role where client_no = ? and area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ps.setInt(2, areaNo);
		ResultSet rs = ps.executeQuery();
		boolean isAdmin = rs.next();
		
		con.close();
		return isAdmin;
	}
}
