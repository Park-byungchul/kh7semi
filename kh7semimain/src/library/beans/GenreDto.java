package library.beans;

public class GenreDto {
	private int genre_no;
	private String genre_name;
	
	public GenreDto() {
		super();
	}
	
	public int getGenre_no() {
		return genre_no;
	}
	
	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}
	
	public String getGenre_name() {
		return genre_name;
	}
	
	public void setGenre_name(String genre_name) {
		this.genre_name = genre_name;
	}
	
}
