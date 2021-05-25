package library.beans;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

public class GenreDao {
	public void insert(GenreDto genreDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "insert into genre "
				+ "(genre_no, genre_name) "
				+ "values(?, ?)";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genreDto.getGenreNo());
		ps.setString(2, genreDto.getGenreName());
		ps.execute();
		
		con.close();
	}
	
	public boolean editGenre(GenreDto genreDto) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "update genre set genre_name = ?  where genre_no = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setString(1, genreDto.getGenreName());
		ps.setInt(2, genreDto.getGenreNo());
		int count = ps.executeUpdate();
		
		con.close();
		
		return count > 0;
	}
	
	public GenreDto get(int genreNo) throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from book where book_isbn = ?";
		PreparedStatement ps = con.prepareStatement(sql);
		ps.setInt(1, genreNo);
		ResultSet rs = ps.executeQuery();
		
		GenreDto genreDto;
		if(rs.next()) {
			genreDto = new GenreDto();
			
			genreDto.setGenreNo(rs.getInt("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
		}
		else {
			genreDto = null;
		}
		
		con.close();
		
		return genreDto;
	}
	
	public List<GenreDto> list() throws Exception {
		Connection con = JdbcUtils.getConnection();
		
		String sql = "select * from genre order by genre_no asc";
		PreparedStatement ps = con.prepareStatement(sql);
		ResultSet rs = ps.executeQuery();
		
		List<GenreDto> genreList = new ArrayList<>();
		
		while(rs.next()) {
			GenreDto genreDto = new GenreDto();
			
			genreDto.setGenreNo(rs.getInt("genre_no"));
			genreDto.setGenreName(rs.getString("genre_name"));
			
			genreList.add(genreDto);
		}
		
		con.close();
		
		return genreList;
	}
}
