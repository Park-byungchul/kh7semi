package library.beans;

import java.sql.Date;

public class RoleDto {
	private int clientNo;
	private int areaNo;
	private Date roleDate;

	public RoleDto() {
		super();
	}

	public int getClientNo() {
		return clientNo;
	}

	public void setClientNo(int clientNo) {
		this.clientNo = clientNo;
	}

	public int getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(int areaNo) {
		this.areaNo = areaNo;
	}

	public Date getRoleDate() {
		return roleDate;
	}

	public void setRoleDate(Date roleDate) {
		this.roleDate = roleDate;
	}

}
