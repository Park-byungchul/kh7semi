package library.beans.board;

import java.sql.Date;

public class BoardLikeDto {
	private int clientNo;
	private int boardNo;
	private Date likeTime;
	
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public Date getLikeTime() {
		return likeTime;
	}
	public void setLikeTime(Date likeTime) {
		this.likeTime = likeTime;
	}
}
