package library.beans;

public class AreaDto {
	private int areaNo;
	private String areaName;
	private String areaLocation;
	private String areaCall;

	public AreaDto() {
		super();
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

	public String getAreaLocation() {
		return areaLocation;
	}

	public void setAreaLocation(String areaLocation) {
		this.areaLocation = areaLocation;
	}

	public String getAreaCall() {
		return areaCall;
	}

	public void setAreaCall(String areaCall) {
		this.areaCall = areaCall;
	}

}
