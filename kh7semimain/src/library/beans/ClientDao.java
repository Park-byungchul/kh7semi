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
		}
		else {
			find = null;
			}
		con.close();
		
		return find;
		}
}
