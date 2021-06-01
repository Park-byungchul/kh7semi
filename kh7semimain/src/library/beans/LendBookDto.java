package library.beans;

import java.sql.Date;

//DTO
public class LendBookDto {
	private int lendBookNo;
	private int clientNo;
	private int getBookNo;
	private long bookIsbn;
	private int areaNo;
	private Date lendBookDate;
	private Date lendBookLimit;
	private Date returnBookDate;
	
	public LendBookDto() {
		super();
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

	public long getBookIsbn() {
		return bookIsbn;
	}

	public void setBookIsbn(long bookIsbn) {
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
	
	

}
