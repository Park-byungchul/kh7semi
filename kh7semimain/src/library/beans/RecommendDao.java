package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;



public class RecommendDao {
	
	public static final String USERNAME = "kh7semi2";
	public static final String PASSWORD = "kh7semi2";
	
	//추천하기
	public void insert(RecommendDto recomendDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into recommend values(recommend_seq.nextval)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.execute();
		
		con.close();
	}
	//추천삭제(추천하기 한번 더 클릭)
	public boolean delete(int recommendNo) throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "delete recommend where recommend_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recommendNo);
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	//구간조회(메인페이지 - 추천도서 뽑아오기)
	public List<RecommendDto> rank(int begin, int end) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from recommendCount order by recommendcount asc"
							+ ") TMP"
						+ ") where rn between ? and ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, begin);
		ps.setInt(2, end);
		ResultSet rs = ps.executeQuery();
		
		//List로 변환
		List<RecommendDto> recommendRankList = new ArrayList<>();
		while(rs.next()) {
			RecommendDto recommendDto = new RecommendDto();
			recommendDto.setRecommendNo(rs.getInt("recommend_no"));
			recommendDto.setClientNo(rs.getInt("client_no"));
			recommendDto.setBookIsbn(rs.getInt("book_isbn"));
			
			
			recommendRankList.add(recommendDto);
		}
		
		con.close();
		
		return recommendRankList;
	}
	
}
