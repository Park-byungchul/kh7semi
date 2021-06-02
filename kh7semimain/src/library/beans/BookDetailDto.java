package library.beans;

public class BookDetailDto {
	private long bookIsbn;
	private String bookTitle;
	private String bookAuthor;
	private int genreNo;
	private String genreName;
	public long getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(long bookIsbn) {
		this.bookIsbn = bookIsbn;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getBookAuthor() {
		return bookAuthor;
	}
	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}
	public int getGenreNo() {
		return genreNo;
	}
	public void setGenreNo(int genreNo) {
		this.genreNo = genreNo;
	}
	public String getGenreName() {
		return genreName;
	}
	public void setGenreName(String genreName) {
		this.genreName = genreName;
	}
	public BookDetailDto(long bookIsbn, String bookTitle, String bookAuthor, int genreNo, String genreName) {
		super();
		this.bookIsbn = bookIsbn;
		this.bookTitle = bookTitle;
		this.bookAuthor = bookAuthor;
		this.genreNo = genreNo;
		this.genreName = genreName;
	}
	public BookDetailDto() {
		super();
	}
	
	
}
