package library.beans;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;


public class ClientDao {
	public void insert(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into client "
				+ "(client_no, client_id, client_pw, client_name, client_email, client_phone) "
				+ "values(client_seq.nextval, ?, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ps.setString(3, clientDto.getClientName());
		ps.setString(4, clientDto.getClientEmail());
		ps.setString(5, clientDto.getClientPhone());
		ps.execute();
		
		con.close();
	}
	
	public List<ClientDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from client";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<ClientDto> list = new ArrayList<>();
		while(rs.next()) {
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
			list.add(clientDto);
		}
		
		con.close();
		return list;
	}
	
	public List<ClientDto> list(int strNum, int endNum) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+"select * from client order by client_no desc"
				+ ") TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, strNum);
		ps.setInt(2, endNum);
		ResultSet rs = ps.executeQuery();
		List<ClientDto> list = new ArrayList<>();
		while(rs.next()) {
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
			list.add(clientDto);
		}
		
		con.close();
		return list;
	}
	
	public List<ClientDto> search(String search, int strNum, int endNum) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
				+ "select rownum rn, TMP.* from("
				+ "select * from("
				+ "select * from client where instr(client_id, ?) > 0 "
				+ "union select * from client where instr(client_name, ?) > 0 "
				+ "union select * from client where instr(client_email, ?) > 0 "
				+ "union select * from client where instr(client_possible, ?) > 0 "
				+ "union select * from client where instr(client_type, ?) > 0) "
				+ "order by client_no desc) TMP"
				+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, search);
		ps.setString(2, search);
		ps.setString(3, search);
		ps.setString(4, search);
		ps.setString(5, search);
		ps.setInt(6, strNum);
		ps.setInt(7, endNum);
		ResultSet rs = ps.executeQuery();
		List<ClientDto> list = new ArrayList<>();
		while(rs.next()) {
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
			list.add(clientDto);
		}
		
		con.close();
		return list;
	}
	
	public boolean edit(ClientDto clientDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update client set "
				+ "client_name = ?, client_email = ?, client_possible = ?, client_type = ? "
				+ "where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientName());
		ps.setString(2, clientDto.getClientEmail());
		ps.setDate(3, clientDto.getClientPossible());
		ps.setString(4, clientDto.getClientType());
		ps.setInt(5, clientDto.getClientNo());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	public boolean delete(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete client where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	public ClientDto login(ClientDto clientDto) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from client where client_id =? and client_pw = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, clientDto.getClientId());
		ps.setString(2, clientDto.getClientPw());
		ResultSet rs = ps.executeQuery();
		
		ClientDto find;
		if(rs.next()) {
			find = new ClientDto();
			
			find.setClientNo(rs.getInt("client_no"));
			find.setClientId(rs.getString("client_id"));
			find.setClientName(rs.getString("client_name"));
			find.setClientEmail(rs.getString("client_email"));
			find.setClientMade(rs.getDate("client_made"));
			find.setClientPossible(rs.getDate("client_possible"));
			find.setClientType(rs.getString("client_type"));
			find.setClientPhone(rs.getString("client_phone"));
		}
		else {
			find = null;
		}
		con.close();
		
		return find;
	}
	
	public ClientDto get(int clientNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from client where client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, clientNo);
		ResultSet rs = ps.executeQuery();
		
		ClientDto clientDto;
		
		if(rs.next()) {
			clientDto = new ClientDto();
			
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientPw(rs.getString("client_pw"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
		}
		else {
			clientDto = null;
		}
		
		con.close();
		return clientDto;
	}
	
	public List<ClientDto> adminPermmisionList() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from client where client_type = '권한관리자'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<ClientDto> list = new ArrayList<>();
		while(rs.next()) {
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
			list.add(clientDto);
		}
		
		con.close();
		return list;
	}
	
	public List<ClientDto> adminNormalList() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from client where client_type = '일반관리자'";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<ClientDto> list = new ArrayList<>();
		while(rs.next()) {
			ClientDto clientDto = new ClientDto();
			clientDto.setClientNo(rs.getInt("client_no"));
			clientDto.setClientId(rs.getString("client_id"));
			clientDto.setClientName(rs.getString("client_name"));
			clientDto.setClientEmail(rs.getString("client_email"));
			clientDto.setClientMade(rs.getDate("client_made"));
			clientDto.setClientPossible(rs.getDate("client_possible"));
			clientDto.setClientType(rs.getString("client_type"));
			clientDto.setClientPhone(rs.getString("client_phone"));
			list.add(clientDto);
		}
		
		con.close();
		return list;
	}
	
	public boolean isAdminCurrentArea(int clientNo, int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select C.* from client C "
				+ "inner join "
				+ "(select client_no from roleArea where area_no = ?) SC "
				+ "on C.client_no = SC.client_no "
				+ "where C.client_no = ? "
				+ "union "
				+ "select * from client where client_type = '전체관리자' "
				+ "and client_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, areaNo);
		ps.setInt(2, clientNo);
		ps.setInt(3, clientNo);
		ResultSet rs = ps.executeQuery();
		
		ClientDto find;
		if(rs.next()) {
			find = new ClientDto();
			
			find.setClientNo(rs.getInt("client_no"));
			find.setClientId(rs.getString("client_id"));
			find.setClientName(rs.getString("client_name"));
			find.setClientEmail(rs.getString("client_email"));
			find.setClientMade(rs.getDate("client_made"));
			find.setClientPossible(rs.getDate("client_possible"));
			find.setClientType(rs.getString("client_type"));
			find.setClientPhone(rs.getString("client_phone"));
		}
		else {
			find = null;
		}
		
		con.close();
		return find != null;
	}
	
	public int getCount() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select count(*) from client";
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
				+ "select * from client where instr(client_id, ?) > 0 "
				+ "union select * from client where instr(client_name, ?) > 0 "
				+ "union select * from client where instr(client_email, ?) > 0 "
				+ "union select * from client where instr(client_possible, ?) > 0 "
				+ "union select * from client where instr(client_type, ?) > 0)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, search);
		ps.setString(2, search);
		ps.setString(3, search);
		ps.setString(4, search);
		ps.setString(5, search);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
}
