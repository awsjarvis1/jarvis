package com.jarvis.model.request;

public class Metadata {

	private String intentId;
	private String webhookForSlotFillingUsed;
	private String intentName;
	private String webhookUsed;

	public String getIntentId() {
		return intentId;
	}

	public void setIntentId(String intentId) {
		this.intentId = intentId;
	}

	public String getWebhookForSlotFillingUsed() {
		return webhookForSlotFillingUsed;
	}

	public void setWebhookForSlotFillingUsed(String webhookForSlotFillingUsed) {
		this.webhookForSlotFillingUsed = webhookForSlotFillingUsed;
	}

	public String getIntentName() {
		return intentName;
	}

	public void setIntentName(String intentName) {
		this.intentName = intentName;
	}

	public String getWebhookUsed() {
		return webhookUsed;
	}

	public void setWebhookUsed(String webhookUsed) {
		this.webhookUsed = webhookUsed;
	}

}
