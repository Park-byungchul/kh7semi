package library.beans;

public class PromotionInfoDto {
	private int promotionNo;
	private int areaNo;

	private int fileNo;
	private String fileUploadName;
	private String fileSaveName;
	private String fileContentType;
	private long fileSize;
	private int fileOrigin;

	public PromotionInfoDto() {
		super();
	}

	public int getPromotionNo() {
		return promotionNo;
	}

	public void setPromotionNo(int promotionNo) {
		this.promotionNo = promotionNo;
	}

	public int getAreaNo() {
		return areaNo;
	}

	public void setAreaNo(int areaNo) {
		this.areaNo = areaNo;
	}

	public int getFileNo() {
		return fileNo;
	}

	public void setFileNo(int fileNo) {
		this.fileNo = fileNo;
	}

	public String getFileUploadName() {
		return fileUploadName;
	}

	public void setFileUploadName(String fileUploadName) {
		this.fileUploadName = fileUploadName;
	}

	public String getFileSaveName() {
		return fileSaveName;
	}

	public void setFileSaveName(String fileSaveName) {
		this.fileSaveName = fileSaveName;
	}

	public String getFileContentType() {
		return fileContentType;
	}

	public void setFileContentType(String fileContentType) {
		this.fileContentType = fileContentType;
	}

	public long getFileSize() {
		return fileSize;
	}

	public void setFileSize(long fileSize) {
		this.fileSize = fileSize;
	}

	public int getFileOrigin() {
		return fileOrigin;
	}

	public void setFileOrigin(int fileOrigin) {
		this.fileOrigin = fileOrigin;
	}

}
