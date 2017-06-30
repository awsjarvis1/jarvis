package com.jarvis.model.response;

import java.util.List;

public class Response {
	private String speech;
	private String displayText;
	private DataObj dataObj;
	private List<ContextOutObj> contextOutObj;
	private String source;
	private List<FollowUpEvent> followUpEvent;

	public String getSpeech() {
		return speech;
	}

	public void setSpeech(String speech) {
		this.speech = speech;
	}

	public String getDisplayText() {
		return displayText;
	}

	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	public DataObj getDataObj() {
		return dataObj;
	}

	public void setDataObj(DataObj dataObj) {
		this.dataObj = dataObj;
	}

	public List<ContextOutObj> getContextOutObj() {
		return contextOutObj;
	}

	public void setContextOutObj(List<ContextOutObj> contextOutObj) {
		this.contextOutObj = contextOutObj;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public List<FollowUpEvent> getFollowUpEvent() {
		return followUpEvent;
	}

	public void setFollowUpEvent(List<FollowUpEvent> followUpEvent) {
		this.followUpEvent = followUpEvent;
	}
}
