package library.beans;

public class BookDto {
	private long bookIsbn;
	private int genreNo;
	private String bookTitle;
	private String bookAuthor;
	
	public BookDto() {
		super();
	}

	public long getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(long bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public int getGenreNo() {
		return genreNo;
	}

	public void setGenreNo(int genreNo) {
		this.genreNo = genreNo;
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
}
