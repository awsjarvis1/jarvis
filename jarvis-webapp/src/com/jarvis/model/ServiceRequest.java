package com.jarvis.model;

public class ServiceRequest {

	@Override
	public String toString() {
		return "ServiceRequest [serviceReqNo=" + serviceReqNo + ", reportedBy=" + reportedBy + ", problemType="
				+ problemType + ", product=" + product + ", date=" + date + "]";
	}

	private String serviceReqNo;
	private String reportedBy;
	private String problemType;
	private String product;
	private String date;

	public String getServiceReqNo() {
		return serviceReqNo;
	}

	public void setServiceReqNo(String serviceReqNo) {
		this.serviceReqNo = serviceReqNo;
	}

	public String getReportedBy() {
		return reportedBy;
	}

	public void setReportedBy(String reportedBy) {
		this.reportedBy = reportedBy;
	}

	public String getProblemType() {
		return problemType;
	}

	public void setProblemType(String problemType) {
		this.problemType = problemType;
	}

	public String getProduct() {
		return product;
	}

	public void setProduct(String product) {
		this.product = product;
	}

	public String getDate() {
		return date;
	}

	public void setDate(String date) {
		this.date = date;
	}
}
