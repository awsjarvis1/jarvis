package com.jarvis.model.request;

import java.util.List;

public class Fulfillment {

	private List<Message> messages = null;
	private String speech;

	public List<Message> getMessages() {
		return messages;
	}

	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}

	public String getSpeech() {
		return speech;
	}

	public void setSpeech(String speech) {
		this.speech = speech;
	}

}