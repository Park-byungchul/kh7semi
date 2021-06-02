package library.beans;

public class BookDetailDto {
	private String bookIsbn;
	private String bookTitle;
	private String bookAuthor;
	private int genreNo;
	private String genreName;
	public String getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(String bookIsbn) {
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
	public BookDetailDto(String bookIsbn, String bookTitle, String bookAuthor, int genreNo, String genreName) {
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
