package library.beans;

public class BookDto {
	private int book_isbn;
	private int genre_no;
	private String book_title;
	private String book_author;
	
	public BookDto() {
		super();
	}

	public int getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(int book_isbn) {
		this.book_isbn = book_isbn;
	}

	public int getGenre_no() {
		return genre_no;
	}

	public void setGenre_no(int genre_no) {
		this.genre_no = genre_no;
	}

	public String getBook_title() {
		return book_title;
	}

	public void setBook_title(String book_title) {
		this.book_title = book_title;
	}

	public String getBook_author() {
		return book_author;
	}

	public void setBook_author(String book_author) {
		this.book_author = book_author;
	}
}
