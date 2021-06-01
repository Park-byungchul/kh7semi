package library.beans;

public class RecommendDto {
	private int recommendNo;
	private int clientNo;
	private Long bookIsbn;
	public int getRecommendNo() {
		return recommendNo;
	}
	public void setRecommendNo(int recommendNo) {
		this.recommendNo = recommendNo;
	}
	public int getClientNo() {
		return clientNo;
	}
	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}
	public Long getBookIsbn() {
		return bookIsbn;
	}
	public void setBookIsbn(Long bookIsbn) {
		this.bookIsbn = bookIsbn;
	}
	public RecommendDto() {
		super();
	}
}
