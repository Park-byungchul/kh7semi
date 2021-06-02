package library.beans;

import java.sql.Date;

public class HopelistDto {
	//희망도서 관련 정보
	private int hopelistNo;
	private int clientNo;
	private String bookIsbn;
	private String hopelistReason;
	private Date hopelistDate;
	private String hopelistLibrary;
	
	public String getHopelistLibrary() {
		return hopelistLibrary;
	}
	public void setHopelistLibrary(String hopelistLibrary) {
		this.hopelistLibrary = hopelistLibrary;
	}
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
	public String getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(String bookIsbn) {
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
