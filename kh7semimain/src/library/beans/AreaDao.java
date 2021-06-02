package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class AreaDao {
	public List<AreaDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from area order by area_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while (rs.next()) {
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
	
	public List<AreaDto> list(int strNum, int endNum) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from area order by area_no desc"
				+ ") TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, strNum);
		ps.setInt(2, endNum);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while (rs.next()) {
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
	
	public List<AreaDto> search(String search, int strNum, int endNum) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from("
				+ "select * from area where instr(area_name, ?) > 0 "
				+ "union select * from area where instr(area_location, ?) > 0 "
				+ "union select * from area where instr(area_call, ?) > 0) "
				+ "order by area_no desc) TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, search);
		ps.setString(2, search);
		ps.setString(3, search);
		ps.setInt(4, strNum);
		ps.setInt(5, endNum);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while (rs.next()) {
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
	
	public List<AreaDto> list(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select A.* from area A inner join role R on A.area_no = R.area_no where client_no = ? order by A.area_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while (rs.next()) {
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
	
	public List<AreaDto> list(int clientNo, int strNum, int endNum) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select A.* from area A "
				+ "inner join role R on A.area_no = R.area_no "
				+ "where client_no = ? order by A.area_no desc"
				+ ") TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, strNum);
		ps.setInt(2, endNum);
		ResultSet rs = ps.executeQuery();
		List<AreaDto> list = new ArrayList<>();
		while (rs.next()) {
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

	public boolean edit(AreaDto areaDto) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "update area set area_name = ?, area_location = ?, area_call = ? where area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, areaDto.getAreaName());
		ps.setString(2, areaDto.getAreaLocation());
		ps.setString(3, areaDto.getAreaCall());
		ps.setInt(4, areaDto.getAreaNo());
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}

	public boolean delete(int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();

		String sql = "delete area where area_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		int count = ps.executeUpdate();

		con.close();
		return count > 0;
	}
	
	public int getCount() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from area";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	public int getCount(String search) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from ("
				+ "select * from area where instr(area_name, ?) > 0 "
				+ "union select * from area where instr(area_location, ?) > 0 "
				+ "union select * from area where instr(area_call, ?) > 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, search);
		ps.setString(2, search);
		ps.setString(3, search);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
}
