package library.beans;

import java.sql.Date;

public class BoardListDto {
	private int boardNo;
	private int boardWriter;
	private int boardTypeNo;
	private int boardArea;
	private String boardTitle;
	private int boardRead;
	private int boardLike;
	private Date boardDate;
	private int boardSepNo;
	private int boardReply;
	
	private int clientNo;
	private String clientName;
	
	private int areaNo;
	private String areaName;
	
	private int typeNo;
	private String boardTypeName;
	
	public int getBoardNo() {
		return boardNo;
	}
	public void setBoardNo(int boardNo) {
		this.boardNo = boardNo;
	}
	public int getBoardWriter() {
		return boardWriter;
	}
	public void setBoardWriter(int boardWriter) {
		this.boardWriter = boardWriter;
	}
	public int getBoardTypeNo() {
		return boardTypeNo;
	}
	public void setBoardTypeNo(int boardTypeNo) {
		this.boardTypeNo = boardTypeNo;
	}
	public int getBoardArea() {
		return boardArea;
	}
	public void setBoardArea(int boardArea) {
		this.boardArea = boardArea;
	}
	public String getBoardTitle() {
		return boardTitle;
	}
	public void setBoardTitle(String boardTitle) {
		this.boardTitle = boardTitle;
	}
	public int getBoardRead() {
		return boardRead;
	}
	public void setBoardRead(int boardRead) {
		this.boardRead = boardRead;
	}
	public int getBoardLike() {
		return boardLike;
	}
	public void setBoardLike(int boardLike) {
		this.boardLike = boardLike;
	}
	public Date getBoardDate() {
		return boardDate;
	}
	public void setBoardDate(Date boardDate) {
		this.boardDate = boardDate;
	}
	public int getBoardSepNo() {
		return boardSepNo;
	}
	public void setBoardSepNo(int boardSepNo) {
		this.boardSepNo = boardSepNo;
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public String getClientName() {
		return clientName;
	}
	public void setClientName(String clientName) {
		this.clientName = clientName;
	}
	public int getAreaNo() {
		return areaNo;
	}
	public void setAreaNo(int areaNo) {
		this.areaNo = areaNo;
	}
	public String getAreaName() {
		return areaName;
	}
	public void setAreaName(String areaName) {
		this.areaName = areaName;
	}
	public int getTypeNo() {
		return typeNo;
	}
	public void setTypeNo(int typeNo) {
		this.typeNo = typeNo;
	}
	public String getBoardTypeName() {
		return boardTypeName;
	}
	public void setBoardTypeName(String boardTypeName) {
		this.boardTypeName = boardTypeName;
	}
	public int getBoardReply() {
		return boardReply;
	}
	public void setBoardReply(int boardReply) {
		this.boardReply = boardReply;
	}
}
