package library.beans;

import java.sql.Date;

public class GetBookDto {
	private int getBookNo;
	private String bookIsbn;
	private int areaNo;
	
	public GetBookDto() {
		super();
	}
	
	public GetBookDto(int getBookNo, String bookIsbn, int areaNo, Date getBookDate) {
		super();
		this.getBookNo = getBookNo;
		this.bookIsbn = bookIsbn;
		this.areaNo = areaNo;
	}

	public int getGetBookNo() {
		return getBookNo;
	}

	public void setGetBookNo(int getBookNo) {
		this.getBookNo = getBookNo;
	}

	public String getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public int getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(int areaNo) {
		this.areaNo = areaNo;
	}

}
