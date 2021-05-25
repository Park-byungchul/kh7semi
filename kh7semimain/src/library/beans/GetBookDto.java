package library.beans;

import java.sql.Date;

public class GetBookDto {
	private int get_book_no;
	private int book_isbn;
	private int area_no;
	private Date get_book_date;
	private String get_book_status;
	
	public GetBookDto() {
		super();
	}

	public int getGet_book_no() {
		return get_book_no;
	}

	public void setGet_book_no(int get_book_no) {
		this.get_book_no = get_book_no;
	}

	public int getBook_isbn() {
		return book_isbn;
	}

	public void setBook_isbn(int book_isbn) {
		this.book_isbn = book_isbn;
	}

	public int getArea_no() {
		return area_no;
	}

	public void setArea_no(int area_no) {
		this.area_no = area_no;
	}

	public Date getGet_book_date() {
		return get_book_date;
	}

	public void setGet_book_date(Date get_book_date) {
		this.get_book_date = get_book_date;
	}

	public String getGet_book_status() {
		return get_book_status;
	}

	public void setGet_book_status(String get_book_status) {
		this.get_book_status = get_book_status;
	}
}
