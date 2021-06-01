package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.proxy.annotation.Pre;

public class RoleAreaDao {
	public List<RoleAreaDto> areaListByClient(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from roleArea where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();
		List<RoleAreaDto> list = new ArrayList<>();
		while(rs.next()) {
			RoleAreaDto roleAreaDto = new RoleAreaDto();
			roleAreaDto.setClientNo(rs.getInt("client_no"));
			roleAreaDto.setClientName(rs.getString("client_name"));
			roleAreaDto.setAreaNo(rs.getInt("area_no"));
			roleAreaDto.setAreaName(rs.getString("area_name"));
			roleAreaDto.setRoleDate(rs.getDate("role_date"));
			list.add(roleAreaDto);
		}
		
		con.close();
		return list;
	}
	
	public List<RoleAreaDto> clientListByArea(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from roleArea where area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ResultSet rs = ps.executeQuery();
		List<RoleAreaDto> list = new ArrayList<>();
		while(rs.next()) {
			RoleAreaDto roleAreaDto = new RoleAreaDto();
			roleAreaDto.setClientNo(rs.getInt("client_no"));
			roleAreaDto.setClientName(rs.getString("client_name"));
			roleAreaDto.setAreaNo(rs.getInt("area_no"));
			roleAreaDto.setAreaName(rs.getString("area_name"));
			roleAreaDto.setRoleDate(rs.getDate("role_date"));
			list.add(roleAreaDto);
		}
		
		con.close();
		return list;
	}
	
	public RoleAreaDto get(int roleClientNo, int roleAreaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from roleArea where client_no = ? and area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, roleClientNo);
		ps.setInt(2, roleAreaNo);
		ResultSet rs = ps.executeQuery();
		RoleAreaDto roleAreaDto = new RoleAreaDto();
		if(rs.next()) {
			roleAreaDto.setClientNo(rs.getInt("client_no"));
			roleAreaDto.setClientName(rs.getString("client_name"));
			roleAreaDto.setAreaNo(rs.getInt("area_no"));
			roleAreaDto.setAreaName(rs.getString("area_name"));
			roleAreaDto.setRoleDate(rs.getDate("role_date"));
		}
		else {
			roleAreaDto = null;
		}
		con.close();
		return roleAreaDto;
	}
}
