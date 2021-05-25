package library.beans;

import java.sql.Date;

public class ClientDto {
	private int clientNo;
	private String clientId;
	private String clientPw;
	private String clientName;
	private String clientEmail;
	private Date clientMade;
	private Date clientPossible;
	private String clientType;

	public ClientDto() {
		super();
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}

	public String getClientId() {
		return clientId;
	}

	public void setClientId(String clientId) {
		this.clientId = clientId;
	}

	public String getClientPw() {
		return clientPw;
	}

	public void setClientPw(String clientPw) {
		this.clientPw = clientPw;
	}

	public String getClientName() {
		return clientName;
	}

	public void setClientName(String clientName) {
		this.clientName = clientName;
	}

	public String getClientEmail() {
		return clientEmail;
	}

	public void setClientEmail(String clientEmail) {
		this.clientEmail = clientEmail;
	}

	public Date getClientMade() {
		return clientMade;
	}

	public void setClientMade(Date clientMade) {
		this.clientMade = clientMade;
	}

	public Date getClientPossible() {
		return clientPossible;
	}

	public void setClientPossible(Date clientPossible) {
		this.clientPossible = clientPossible;
	}

	public String getClientType() {
		return clientType;
	}

	public void setClientType(String clientType) {
		this.clientType = clientType;
	}

}
