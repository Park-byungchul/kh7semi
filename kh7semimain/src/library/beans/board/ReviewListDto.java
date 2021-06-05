package library.beans.board;

import java.sql.Date;

public class ReviewListDto {
	private int reviewNo;
	private int reviewer;
	private String bookIsbn;
	private String reviewSubject;
	private String reviewContent;
	private int reviewRead;
	private int reviewLike;
	private Date reviewDate;
	private int reviewReply;
	
	private int clientNo;
	private String clientName;
	
	public ReviewListDto() {
		super();
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
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
	public String getReviewSubject() {
		return reviewSubject;
	}
	public void setReviewSubject(String reviewSubject) {
		this.reviewSubject = reviewSubject;
	}
	public String getReviewContent() {
		return reviewContent;
	}
	public void setReviewContent(String reviewContent) {
		this.reviewContent = reviewContent;
	}
	public int getReviewRead() {
		return reviewRead;
	}
	public void setReviewRead(int reviewRead) {
		this.reviewRead = reviewRead;
	}
	public int getReviewLike() {
		return reviewLike;
	}
	public void setReviewLike(int reviewLike) {
		this.reviewLike = reviewLike;
	}
	public Date getReviewDate() {
		return reviewDate;
	}
	public void setReviewDate(Date reviewDate) {
		this.reviewDate = reviewDate;
	}
	public int getReviewer() {
		return reviewer;
	}
	public void setReviewer(int reviewer) {
		this.reviewer = reviewer;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public int getReviewReply() {
		return reviewReply;
	}
	public void setReviewReply(int reviewReply) {
		this.reviewReply = reviewReply;
	}
}
