package com.jarvis.model.response;

public class Metadata {

	private String intentId;
	private String webhookUsed;
	private String webhookForSlotFillingUsed;
	private Integer webhookResponseTime;
	private String intentName;

	public String getIntentId() {
		return intentId;
	}

	public void setIntentId(String intentId) {
		this.intentId = intentId;
	}

	public String getWebhookUsed() {
		return webhookUsed;
	}

	public void setWebhookUsed(String webhookUsed) {
		this.webhookUsed = webhookUsed;
	}

	public String getWebhookForSlotFillingUsed() {
		return webhookForSlotFillingUsed;
	}

	public void setWebhookForSlotFillingUsed(String webhookForSlotFillingUsed) {
		this.webhookForSlotFillingUsed = webhookForSlotFillingUsed;
	}

	public Integer getWebhookResponseTime() {
		return webhookResponseTime;
	}

	public void setWebhookResponseTime(Integer webhookResponseTime) {
		this.webhookResponseTime = webhookResponseTime;
	}

	public String getIntentName() {
		return intentName;
	}

	public void setIntentName(String intentName) {
		this.intentName = intentName;
	}

}