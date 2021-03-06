package library.beans;

import java.sql.Date;

//searchList리스트에 보여질 것들
public class GetBookSearchDto {
	private int getBookNo;
	private String areaName;
	private String bookIsbn;
	private String bookAuthor;
	private String bookTitle;
	private String getBookStatus;
	private Date getBookDate;
	private String bookPublisher;
	private Date bookDate;
	private String bookContent;
	private String bookImg;
	
	public int getGetBookNo() {
		return getBookNo;
	}
	public void setGetBookNo(int getBookNo) {
		this.getBookNo = getBookNo;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public String getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(String bookIsbn) {
		this.bookIsbn = bookIsbn;
	}
	public String getBookAuthor() {
		return bookAuthor;
	}
	public void setBookAuthor(String bookAuthor) {
		this.bookAuthor = bookAuthor;
	}
	public String getBookTitle() {
		return bookTitle;
	}
	public void setBookTitle(String bookTitle) {
		this.bookTitle = bookTitle;
	}
	public String getGetBookStatus() {
		return getBookStatus;
	}
	public void setGetBookStatus(String getBookStatus) {
		this.getBookStatus = getBookStatus;
	}
	public Date getGetBookDate() {
		return getBookDate;
	}
	public void setGetBookDate(Date getBookDate) {
		this.getBookDate = getBookDate;
	}
	
	public String getBookPublisher() {
		return bookPublisher;
	}
	public void setBookPublisher(String bookPublisher) {
		this.bookPublisher = bookPublisher;
	}
	public Date getBookDate() {
		return bookDate;
	}
	public void setBookDate(Date bookDate) {
		this.bookDate = bookDate;
	}
	public String getBookContent() {
		return bookContent;
	}
	public void setBookContent(String bookContent) {
		this.bookContent = bookContent;
	}
	public String getBookImg() {
		return bookImg;
	}
	public void setBookImg(String bookImg) {
		this.bookImg = bookImg;
	}
	
	public GetBookSearchDto(int getBookNo, String areaName, String bookIsbn, String bookAuthor, String bookTitle,
			String getBookStatus, Date getBookDate, String bookPublisher, Date bookDate, String bookContent,
			String bookImg) {
		super();
		this.getBookNo = getBookNo;
		this.areaName = areaName;
		this.bookIsbn = bookIsbn;
		this.bookAuthor = bookAuthor;
		this.bookTitle = bookTitle;
		this.getBookStatus = getBookStatus;
		this.getBookDate = getBookDate;
		this.bookPublisher = bookPublisher;
		this.bookDate = bookDate;
		this.bookContent = bookContent;
		this.bookImg = bookImg;
	}
	public GetBookSearchDto() {
		super();
	}
}
