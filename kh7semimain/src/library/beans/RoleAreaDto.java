package library.beans;

import java.sql.Date;

public class RoleAreaDto {
	private int clientNo;
	private String clientName;
	private int areaNo;
	private String areaName;
	private Date roleDate;

	public RoleAreaDto() {
		super();
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

	public Date getRoleDate() {
		return roleDate;
	}

	public void setRoleDate(Date roleDate) {
		this.roleDate = roleDate;
	}

}
