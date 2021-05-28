package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class WishlistDao {
	public static final String USERNAME = "kh7semi2";
	public static final String PASSWORD = "kh7semi2";
	
	//관심목록 등록
	public void insert(WishlistDto wishlistDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into wishlist values(?,?,?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, wishlistDto.getWishlistNo());
		ps.setInt(2, wishlistDto.getClientNo());
		ps.setInt(3, wishlistDto.getBookIsbn());
		ps.execute();
		
		con.close();
	}
	//시퀀스 얻기
	public int getSequence() throws Exception {
		Connection con = JdbcUtils.getConnection();;
		
		String sql = "select wishlist_seq.nextval from dual";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		rs.next();
		int no = rs.getInt(1);
		
		con.close();
		return no;
	}
	//관심목록 삭제
	public boolean delete(int wishlistNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "delete wishlist where wishlist_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, wishlistNo);
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
				
	}
	//관심목록 - list
	public List<WishlistDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from hopelist order by hopelist_no desc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		List<WishlistDto> list = new ArrayList<>();
		while(rs.next()) {
			WishlistDto wishlistDto = new WishlistDto();
			wishlistDto.setWishlistNo(rs.getInt("wishlist_no"));
			wishlistDto.setClientNo(rs.getInt("client_no"));
			wishlistDto.setBookIsbn(rs.getInt("book_isbn"));
		
			
			list.add(wishlistDto);
		}
		
		con.close();
		return list;
	}
}
