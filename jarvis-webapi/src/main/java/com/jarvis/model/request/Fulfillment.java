package com.jarvis.model.request;

import java.util.List;
import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "speech", "source", "displayText", "messages" })
public class Fulfillment {

	@JsonProperty("speech")
	private String speech;
	@JsonProperty("source")
	private String source;
	@JsonProperty("displayText")
	private String displayText;
	@JsonProperty("messages")
	private List<Message> messages = null;

	@JsonProperty("speech")
	public String getSpeech() {
		return speech;
	}

	@JsonProperty("speech")
	public void setSpeech(String speech) {
		this.speech = speech;
	}

	@JsonProperty("source")
	public String getSource() {
		return source;
	}

	@JsonProperty("source")
	public void setSource(String source) {
		this.source = source;
	}

	@JsonProperty("displayText")
	public String getDisplayText() {
		return displayText;
	}

	@JsonProperty("displayText")
	public void setDisplayText(String displayText) {
		this.displayText = displayText;
	}

	@JsonProperty("messages")
	public List<Message> getMessages() {
		return messages;
	}

	@JsonProperty("messages")
	public void setMessages(List<Message> messages) {
		this.messages = messages;
	}

}
