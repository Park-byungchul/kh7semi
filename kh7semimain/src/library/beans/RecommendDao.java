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
	public void insert(RecommendDto recommendDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into recommend values(recommend_seq.nextval,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recommendDto.getClientNo());
		ps.setInt(2, recommendDto.getBookIsbn());
		ps.execute();
		
		con.close();
	}
	//추천삭제(추천하기 한번 더 클릭)
	public boolean delete(RecommendDto recommendDto) throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "delete recommend where client_no = ? and book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, recommendDto.getClientNo());
		ps.setInt(2, recommendDto.getBookIsbn());
		int count = ps.executeUpdate();
		
		con.close();
		return count > 0;
	}
	
	//구간조회(메인페이지 - 추천도서 뽑아오기)
	public List<RecommendDto> rank(int begin, int end) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from ("
							+ "select rownum rn, TMP.* from ("
								+ "select * from recommendCount order by recommendcount desc"
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

			recommendDto.setBookIsbn(rs.getInt("book_isbn"));
			
			
			recommendRankList.add(recommendDto);
		}
		
		con.close();
		
		return recommendRankList;
	}
	//추천확인 기능
		public boolean check(RecommendDto recommendDto) throws Exception {
			Connection con = JdbcUtils.getConnection();;
			String sql = "select * from recommend where book_isbn=? and client_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, recommendDto.getBookIsbn());
			ps.setInt(2, recommendDto.getClientNo());
			ResultSet rs = ps.executeQuery();
			boolean result = rs.next();
			con.close();
			return result;
		}
}
