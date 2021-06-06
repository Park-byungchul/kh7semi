package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Types;
import java.util.ArrayList;
import java.util.List;

import oracle.jdbc.proxy.annotation.Pre;

public class PlanDao {
	public List<PlanDto> list(int year, int month, int day) throws Exception {

		String searchYear = Integer.toString(year);
		String searchMonth;
		if (month < 10) {
			searchMonth = "0" + Integer.toString(month);
		} else {
			searchMonth = Integer.toString(month);
		}
		String searchDay;
		if (day < 10) {
			searchDay = "0" + Integer.toString(day);
		} else {
			searchDay = Integer.toString(day);
		}

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, searchYear + searchMonth + searchDay);
		ResultSet rs = ps.executeQuery();

		List<PlanDto> planList = new ArrayList<>();

		while (rs.next()) {
			PlanDto planDto = new PlanDto();
			planDto.setPlanNo(rs.getInt("plan_no"));
			planDto.setAreaNo(rs.getInt("area_no"));
			planDto.setPlanStartDate(rs.getDate("plan_start_date"));
			planDto.setPlanEndDate(rs.getDate("plan_end_date"));
			planDto.setPlanContent(rs.getString("plan_content"));
			planList.add(planDto);
		}

		con.close();
		return planList;
	}
	
	public List<PlanDto> list(int year, int month, int day, int strNum, int endNum) throws Exception {

		String searchYear = Integer.toString(year);
		String searchMonth;
		if (month < 10) {
			searchMonth = "0" + Integer.toString(month);
		} else {
			searchMonth = Integer.toString(month);
		}
		String searchDay;
		if (day < 10) {
			searchDay = "0" + Integer.toString(day);
		} else {
			searchDay = Integer.toString(day);
		}

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from"
				+ "(select rownum rn, TMP.* from"
				+ "(select * from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD') "
				+ "order by (case when plan_content like '%휴관일%' then 1 else 0 end) desc, plan_end_date asc)"
				+ "TMP)"
				+ "where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, searchYear + searchMonth + searchDay);
		ps.setInt(2, strNum);
		ps.setInt(3, endNum);
		ResultSet rs = ps.executeQuery();

		List<PlanDto> planList = new ArrayList<>();

		while (rs.next()) {
			PlanDto planDto = new PlanDto();
			planDto.setPlanNo(rs.getInt("plan_no"));
			planDto.setAreaNo(rs.getInt("area_no"));
			planDto.setPlanStartDate(rs.getDate("plan_start_date"));
			planDto.setPlanEndDate(rs.getDate("plan_end_date"));
			planDto.setPlanContent(rs.getString("plan_content"));
			planList.add(planDto);
		}

		con.close();
		return planList;
	}
	
	public List<PlanDto> list(int year, int month, int day, int strNum, int endNum, int areaNo) throws Exception {

		String searchYear = Integer.toString(year);
		String searchMonth;
		if (month < 10) {
			searchMonth = "0" + Integer.toString(month);
		} else {
			searchMonth = Integer.toString(month);
		}
		String searchDay;
		if (day < 10) {
			searchDay = "0" + Integer.toString(day);
		} else {
			searchDay = Integer.toString(day);
		}

		Connection con = JdbcUtils.getConnection();

		String sql = "select * from"
				+ "(select rownum rn, TMP.* from"
				+ "(select * from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD') "
				+ "and (area_no = ? or area_no is null) "
				+ "order by (case when plan_content like '%휴관일%' then 1 else 0 end) desc, plan_end_date asc)"
				+ "TMP)"
				+ "where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, searchYear + searchMonth + searchDay);
		ps.setInt(2, areaNo);
		ps.setInt(3, strNum);
		ps.setInt(4, endNum);
		ResultSet rs = ps.executeQuery();

		List<PlanDto> planList = new ArrayList<>();

		while (rs.next()) {
			PlanDto planDto = new PlanDto();
			planDto.setPlanNo(rs.getInt("plan_no"));
			planDto.setAreaNo(rs.getInt("area_no"));
			planDto.setPlanStartDate(rs.getDate("plan_start_date"));
			planDto.setPlanEndDate(rs.getDate("plan_end_date"));
			planDto.setPlanContent(rs.getString("plan_content"));
			planList.add(planDto);
		}

		con.close();
		return planList;
	}
	
	public boolean isBreakDay(String today) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from plan where plan_content like '%휴관일%' and (? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD'))";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, today);
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public boolean isPlanDay(String today) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, today);
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public boolean isBreakDay(String today, int areaNo) throws Exception{
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from plan where plan_content like '%휴관일%' and (? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD'))"
				+ "and (area_no = ? or area_no is null)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, today);
		ps.setInt(2, areaNo);
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public boolean isPlanDay(String today, int areaNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD')"
				+ "and (area_no = ? or area_no is null)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, today);
		ps.setInt(2, areaNo);
		ResultSet rs = ps.executeQuery();
		boolean result = rs.next();
		
		con.close();
		return result;
	}
	
	public int count(int year, int month, int day) throws Exception {

		String searchYear = Integer.toString(year);
		String searchMonth;
		if (month < 10) {
			searchMonth = "0" + Integer.toString(month);
		} else {
			searchMonth = Integer.toString(month);
		}
		String searchDay;
		if (day < 10) {
			searchDay = "0" + Integer.toString(day);
		} else {
			searchDay = Integer.toString(day);
		}

		Connection con = JdbcUtils.getConnection();

		String sql = "select count(*) from plan where ? between to_char(plan_start_date, 'YYYYMMDD') and to_char(plan_end_date, 'YYYYMMDD')";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, searchYear + searchMonth + searchDay);
		ResultSet rs = ps.executeQuery();

		rs.next();
		
		int count = rs.getInt(1);
		
		con.close();
		return count;
	}
	
	public void insert(PlanDto planDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into plan values(plan_seq.nextval, ?, ?, ?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		if(planDto.getAreaNo() == 0) {
			ps.setNull(1, Types.INTEGER);
		} else {
			ps.setInt(1, planDto.getAreaNo());
		}
		ps.setDate(2, planDto.getPlanStartDate());
		ps.setDate(3, planDto.getPlanEndDate());
		ps.setString(4, planDto.getPlanContent());
		ps.execute();

		con.close();
	}
	
	public PlanDto detail(int planNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from plan where plan_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, planNo);
		ResultSet rs = ps.executeQuery();
		PlanDto planDto;
		if(rs.next()) {
			planDto = new PlanDto();
			planDto.setPlanNo(rs.getInt("plan_no"));
			planDto.setAreaNo(rs.getInt("area_no"));
			planDto.setPlanStartDate(rs.getDate("plan_start_date"));
			planDto.setPlanEndDate(rs.getDate("plan_end_date"));
			planDto.setPlanContent(rs.getString("plan_content"));
		} else {
			planDto = null;
		}
		
		con.close();
		return planDto;
	}
	
	public boolean delete(int planNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete plan where plan_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, planNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	public boolean edit(PlanDto planDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update plan set area_no = ?, plan_start_date = ?, plan_end_date = ?, plan_content = ? where plan_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		if(planDto.getAreaNo() > 0) {
			ps.setInt(1, planDto.getAreaNo());
		} else {
			ps.setNull(1, Types.INTEGER);
		}
		ps.setDate(2, planDto.getPlanStartDate());
		ps.setDate(3, planDto.getPlanEndDate());
		ps.setString(4, planDto.getPlanContent());
		ps.setInt(5, planDto.getPlanNo());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
}
