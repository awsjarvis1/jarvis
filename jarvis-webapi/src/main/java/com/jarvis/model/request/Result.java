package com.jarvis.model.request;

import java.util.List;

public class Result {

	private Parameters parameters;
	private List<Object> contexts = null;
	private String resolvedQuery;
	private String source;
	private Double score;
	private String speech;
	private Fulfillment fulfillment;
	private Boolean actionIncomplete;
	private String action;
	private Metadata metadata;

	public Parameters getParameters() {
		return parameters;
	}

	public void setParameters(Parameters parameters) {
		this.parameters = parameters;
	}

	public List<Object> getContexts() {
		return contexts;
	}

	public void setContexts(List<Object> contexts) {
		this.contexts = contexts;
	}

	public String getResolvedQuery() {
		return resolvedQuery;
	}

	public void setResolvedQuery(String resolvedQuery) {
		this.resolvedQuery = resolvedQuery;
	}

	public String getSource() {
		return source;
	}

	public void setSource(String source) {
		this.source = source;
	}

	public Double getScore() {
		return score;
	}

	public void setScore(Double score) {
		this.score = score;
	}

	public String getSpeech() {
		return speech;
	}

	public void setSpeech(String speech) {
		this.speech = speech;
	}

	public Fulfillment getFulfillment() {
		return fulfillment;
	}

	public void setFulfillment(Fulfillment fulfillment) {
		this.fulfillment = fulfillment;
	}

	public Boolean getActionIncomplete() {
		return actionIncomplete;
	}

	public void setActionIncomplete(Boolean actionIncomplete) {
		this.actionIncomplete = actionIncomplete;
	}

	public String getAction() {
		return action;
	}

	public void setAction(String action) {
		this.action = action;
	}

	public Metadata getMetadata() {
		return metadata;
	}

	public void setMetadata(Metadata metadata) {
		this.metadata = metadata;
	}

}
