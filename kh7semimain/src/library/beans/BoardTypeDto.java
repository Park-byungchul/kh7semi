package library.beans;

public class BoardTypeDto {
	private int boardTypeNo;
	private String boardTypeName;
	
	public BoardTypeDto() {
		super();
	}
	public int getBoardTypeNo() {
		return boardTypeNo;
	}
	public void setBoardTypeNo(int boardTypeNo) {
		this.boardTypeNo = boardTypeNo;
	}
	public String getBoardTypeName() {
		return boardTypeName;
	}
	public void setBoardTypeName(String boardTypeName) {
		this.boardTypeName = boardTypeName;
	}
}
