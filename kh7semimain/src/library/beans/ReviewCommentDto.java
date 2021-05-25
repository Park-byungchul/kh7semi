package library.beans;

import java.sql.Date;

public class ReviewCommentDto {
	private int commentNo;
	private int clientNo;
	private int reviewNo;
	private String commentField;
	private Date commentDate;
	private int commentLike;
	
	public ReviewCommentDto() {
		super();
	}
	public int getCommentNo() {
		return commentNo;
	}
	public void setCommentNo(int commentNo) {
		this.commentNo = commentNo;
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public int getReviewNo() {
		return reviewNo;
	}
	public void setReviewNo(int reviewNo) {
		this.reviewNo = reviewNo;
	}
	public String getCommentField() {
		return commentField;
	}
	public void setCommentField(String commentField) {
		this.commentField = commentField;
	}
	public Date getCommentDate() {
		return commentDate;
	}
	public void setCommentDate(Date commentDate) {
		this.commentDate = commentDate;
	}
	public int getCommentLike() {
		return commentLike;
	}
	public void setCommentLike(int commentLike) {
		this.commentLike = commentLike;
	}
}
