package com.jarvis.model.request;

public class Request {

	private String lang;
	private Status status;
	private String timestamp;
	private String sessionId;
	private Result result;
	private String id;
	private OriginalRequest originalRequest;

	public String getLang() {
		return lang;
	}

	public void setLang(String lang) {
		this.lang = lang;
	}

	public Status getStatus() {
		return status;
	}

	public void setStatus(Status status) {
		this.status = status;
	}

	public String getTimestamp() {
		return timestamp;
	}

	public void setTimestamp(String timestamp) {
		this.timestamp = timestamp;
	}

	public String getSessionId() {
		return sessionId;
	}

	public void setSessionId(String sessionId) {
		this.sessionId = sessionId;
	}

	public Result getResult() {
		return result;
	}

	public void setResult(Result result) {
		this.result = result;
	}

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public OriginalRequest getOriginalRequest() {
		return originalRequest;
	}

	public void setOriginalRequest(OriginalRequest originalRequest) {
		this.originalRequest = originalRequest;
	}
}