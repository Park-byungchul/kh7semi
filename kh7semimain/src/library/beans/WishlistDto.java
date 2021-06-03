package library.beans;

public class WishlistDto {
	private int wishlistNo;
	private int clientNo;
	private String bookIsbn;
	public int getWishlistNo() {
		return wishlistNo;
	}
	public void setWishlistNo(int wishlistNo) {
		this.wishlistNo = wishlistNo;
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
	public WishlistDto() {
		super();
	}
}
