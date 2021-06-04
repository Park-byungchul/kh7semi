package library.beans;

import java.sql.Date;

//DTO
public class LendBookDto {
	private int lendBookNo;
	private int clientNo;
	private int getBookNo;
	private String bookIsbn;
	private String bookTitle;
	private int areaNo;
	private Date lendBookDate;
	private Date lendBookLimit;
	private Date returnBookDate;
	
	public LendBookDto() {
		super();
	}

	
	public String getBookTitle() {
		return bookTitle;
	}


	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}


	public int getLendBookNo() {
		return lendBookNo;
	}

	public void setLendBookNo(int lendBookNo) {
		this.lendBookNo = lendBookNo;
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
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

	public Date getLendBookDate() {
		return lendBookDate;
	}

	public void setLendBookDate(Date lendBookDate) {
		this.lendBookDate = lendBookDate;
	}

	public Date getLendBookLimit() {
		return lendBookLimit;
	}

	public void setLendBookLimit(Date lendBookLimit) {
		this.lendBookLimit = lendBookLimit;
	}

	public Date getReturnBookDate() {
		return returnBookDate;
	}

	public void setReturnBookDate(Date returnBookDate) {
		this.returnBookDate = returnBookDate;
	}

	public LendBookDto(int lendBookNo, int clientNo, int getBookNo, String bookIsbn, int areaNo, Date lendBookDate,
			Date lendBookLimit, Date returnBookDate) {
		super();
		this.lendBookNo = lendBookNo;
		this.clientNo = clientNo;
		this.getBookNo = getBookNo;
		this.bookIsbn = bookIsbn;
		this.areaNo = areaNo;
		this.lendBookDate = lendBookDate;
		this.lendBookLimit = lendBookLimit;
		this.returnBookDate = returnBookDate;
	}

}
