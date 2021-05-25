package library.beans;

import java.sql.Date;

public class GetBookDto {
	private int getBookNo;
	private int bookIsbn;
	private int areaNo;
	private Date getBookDate;
	private String getBookStatus;
	
	public GetBookDto() {
		super();
	}

	public int getGetBookNo() {
		return getBookNo;
	}

	public void setGetBookNo(int getBookNo) {
		this.getBookNo = getBookNo;
	}

	public int getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(int bookIsbn) {
		this.bookIsbn = bookIsbn;
	}

	public int getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(int areaNo) {
		this.areaNo = areaNo;
	}

	public Date getGetBookDate() {
		return getBookDate;
	}

	public void setGetBookDate(Date getBookDate) {
		this.getBookDate = getBookDate;
	}

	public String getGetBookStatus() {
		return getBookStatus;
	}

	public void setGetBookStatus(String getBookStatus) {
		this.getBookStatus = getBookStatus;
	}
}
