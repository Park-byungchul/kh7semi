package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AreaDao {
	public List<AreaDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from area";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while(rs.next()) {
			AreaDto areaDto = new AreaDto();
			areaDto.setAreaNo(rs.getInt("area_no"));
			areaDto.setAreaName(rs.getString("area_name"));
			areaDto.setAreaLocation(rs.getString("area_location"));
			areaDto.setAreaCall(rs.getString("area_call"));
			list.add(areaDto);
		}
		
		con.close();
		return list;
	}
	
	public void insert(AreaDto areaDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into area (area_no, area_name, area_location, area_call) values(area_seq.nextval, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, areaDto.getAreaName());
		ps.setString(2, areaDto.getAreaLocation());
		ps.setString(3, areaDto.getAreaCall());
		ps.execute();
		
		con.close();
	}
	
	public AreaDto detail(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from area where area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ResultSet rs = ps.executeQuery();
		rs.next();
		AreaDto areaDto = new AreaDto();
		areaDto.setAreaNo(rs.getInt("area_no"));
		areaDto.setAreaName(rs.getString("area_name"));
		areaDto.setAreaLocation(rs.getString("area_location"));
		areaDto.setAreaCall(rs.getString("area_call"));
		
		con.close();
		return areaDto;
	}
}
