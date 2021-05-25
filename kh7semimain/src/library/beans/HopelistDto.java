package library.beans;

import java.sql.Date;

public class HopelistDto {
	private int hopelistNo;
	private int clientNo;
	private int bookIsbn;
	private String hopelistReason;
	private Date hopelistDate;
	public HopelistDto() {
		super();
	}
	public int getHopelistNo() {
		return hopelistNo;
	}
	public void setHopelistNo(int hopelistNo) {
		this.hopelistNo = hopelistNo;
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public int getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(int bookIsbn) {
		this.bookIsbn = bookIsbn;
	}
	public String getHopelistReason() {
		return hopelistReason;
	}
	public void setHopelistReason(String hopelistReason) {
		this.hopelistReason = hopelistReason;
	}
	public Date getHopelistDate() {
		return hopelistDate;
	}
	public void setHopelistDate(Date hopelistDate) {
		this.hopelistDate = hopelistDate;
	}
}
