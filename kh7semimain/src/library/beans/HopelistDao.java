package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;







public class HopelistDao {

	public static final String USERNAME = "kh7semi2";
	public static final String PASSWORD = "kh7semi2";
	
	//희망도서 신청하기
	public void insert(HopelistDto hopelistDto) throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "insert into hopelist values(?,?,?,?,sysdate,?)";
		
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, hopelistDto.getHopelistNo());
		ps.setInt(2, hopelistDto.getClientNo());
		ps.setInt(3, hopelistDto.getBookIsbn());
		ps.setString(4, hopelistDto.getHopelistReason());
		ps.setString(5,hopelistDto.getHopelistLibrary());
		ps.execute();
		con.close();
	}
	
	//시퀀스 얻어내기
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "select hopelist_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		
		con.close();
		return no;
	}
	//상세보기 기능
		public HopelistDto detail(int hopelistNo) throws Exception {
			Connection con = JdbcUtils.getConnection();;
			
			String sql = "select * from hopelist where hopelist_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, hopelistNo);
			ResultSet rs = ps.executeQuery();
			
			HopelistDto hopelistDto;
			if(rs.next()) {
				hopelistDto = new HopelistDto();
				
				hopelistDto.setHopelistNo(rs.getInt("hopelist_no"));
				hopelistDto.setClientNo(rs.getInt("client_no"));
				hopelistDto.setBookIsbn(rs.getInt("book_isbn"));
				hopelistDto.setHopelistReason(rs.getString("hopelist_reason"));
				hopelistDto.setHopelistDate(rs.getDate("hopelist_date"));
				hopelistDto.setHopelistLibrary(rs.getString("hopelist_library"));
			}
			else {
				hopelistDto = null;
			}
			
			con.close();
			
			return hopelistDto;
		}
		//삭제 기능
		public boolean delete(int hopelistNo) throws Exception {
			Connection con = JdbcUtils.getConnection();;
			
			String sql = "delete hopelist where hopelist_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, hopelistNo);
			int count = ps.executeUpdate();
			
			con.close();
			return count > 0;
		}
		
		//목록
		public List<HopelistDto> list() throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from hopelist order by hopelist_no desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			List<HopelistDto> list = new ArrayList<>();
			while(rs.next()) {
				HopelistDto hopelistDto = new HopelistDto();
				hopelistDto.setHopelistNo(rs.getInt("hopelist_no"));
				hopelistDto.setClientNo(rs.getInt("client_no"));
				hopelistDto.setBookIsbn(rs.getInt("book_isbn"));
				hopelistDto.setHopelistReason(rs.getString("hopelist_reason"));
				hopelistDto.setHopelistDate(rs.getDate("hopelist_date"));
				hopelistDto.setHopelistLibrary(rs.getString("hopelist_library"));
				
				list.add(hopelistDto);
			}
			
			con.close();
			return list;
		}
		
		public List<HopelistDto> myhopeList(int clientNo) throws Exception {
			Connection con = JdbcUtils.getConnection();
			
			String sql = "select * from hopelist where client_no = ? order by hopelist_no desc";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, clientNo);
			ResultSet rs = ps.executeQuery();
			List<HopelistDto> list = new ArrayList<>();
			while(rs.next()) {
				HopelistDto hopelistDto = new HopelistDto();
				hopelistDto.setHopelistNo(rs.getInt("hopelist_no"));
				hopelistDto.setClientNo(rs.getInt("client_no"));
				hopelistDto.setBookIsbn(rs.getInt("book_isbn"));
				hopelistDto.setHopelistReason(rs.getString("hopelist_reason"));
				hopelistDto.setHopelistDate(rs.getDate("hopelist_date"));
				hopelistDto.setHopelistLibrary(rs.getString("hopelist_library"));
				
				list.add(hopelistDto);
			}
			
			con.close();
			return list;
		}
		//hopelistNo로 Dto 정보 가져오기
		public HopelistDto get(int hopelistNo) throws Exception {
			Connection con = JdbcUtils.getConnection();;
			
			String sql = "select * from hopelist where hopelist_no = ?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, hopelistNo);
			ResultSet rs = ps.executeQuery();
			
			HopelistDto hopelistDto;
			if(rs.next()) {
				hopelistDto = new HopelistDto();
				
				hopelistDto.setHopelistNo(rs.getInt("hopelist_no"));
				hopelistDto.setClientNo(rs.getInt("client_no"));
				hopelistDto.setBookIsbn(rs.getInt("book_isbn"));
				hopelistDto.setHopelistDate(rs.getDate("hopelist_date"));
				hopelistDto.setHopelistReason(rs.getString("hopelist_reason"));
				hopelistDto.setHopelistLibrary(rs.getString("hopelist_library"));
			}
			else {
				hopelistDto = null;
			}
			
			con.close();
			
			return hopelistDto;
		}
		//페이지블럭 계산을 위한 카운트 기능(목록/검색)
		public int getCount() throws Exception {
			Connection con = JdbcUtils.getConnection();;
			
			String sql = "select count(*) from hopelist";
			PreparedStatement ps = con.prepareStatement(sql);
			ResultSet rs = ps.executeQuery();
			rs.next();
			int count = rs.getInt(1);
			
			con.close();
			
			return count;
		}
		//수정기능
		public boolean edit(HopelistDto hopelistDto) throws Exception {
			Connection con = JdbcUtils.getConnection();;
			
			String sql = "update hopelist "
									+ "set book_isbn=?,hopelist_reason=?,hopelist_library=?,hopelist_date=sysdate "
									+ "where hopelist_no=?";
			PreparedStatement ps = con.prepareStatement(sql);
			ps.setInt(1, hopelistDto.getBookIsbn());
			ps.setString(2, hopelistDto.getHopelistReason());
			ps.setString(3, hopelistDto.getHopelistLibrary());
			ps.setInt(4, hopelistDto.getHopelistNo());
			int count = ps.executeUpdate();
			
			con.close();
			return count > 0;
		}
}
