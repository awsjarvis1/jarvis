package com.jarvis.model.request;

public class Conversation {

	private String conversationId;
	private Integer type;
	private String conversationToken;

	public String getConversationId() {
		return conversationId;
	}

	public void setConversationId(String conversationId) {
		this.conversationId = conversationId;
	}

	public Integer getType() {
		return type;
	}

	public void setType(Integer type) {
		this.type = type;
	}

	public String getConversationToken() {
		return conversationToken;
	}

	public void setConversationToken(String conversationToken) {
		this.conversationToken = conversationToken;
	}

}
