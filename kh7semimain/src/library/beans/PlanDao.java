package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

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
}
