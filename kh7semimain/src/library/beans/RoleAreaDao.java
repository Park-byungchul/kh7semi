package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
}
