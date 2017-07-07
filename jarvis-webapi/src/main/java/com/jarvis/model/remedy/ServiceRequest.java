package com.jarvis.model.remedy;

public class ServiceRequest {

	private String srNo;
	private String problemType;
	private String reportedBy;
	private String date;
	private String product;

	public ServiceRequest(String reportedBy, String srNo, String problemType, String product, String date) {
		this.reportedBy = reportedBy;
		this.srNo = srNo;
		this.problemType = problemType;
		this.product = product;
		this.date = date;
	}

	public String getSrNo() {
		return srNo;
	}

	public String getProblemType() {
		return problemType;
	}

	public String getReportedBy() {
		return reportedBy;
	}

	public String getDate() {
		return date;
	}

	public String getProduct() {
		return product;
	}

}
