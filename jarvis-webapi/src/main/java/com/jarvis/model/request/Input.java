package com.jarvis.model.request;

import java.util.List;

public class Input {

	private List<RawInput> rawInputs = null;
	private String intent;
	private List<Argument> arguments = null;

	public List<RawInput> getRawInputs() {
		return rawInputs;
	}

	public void setRawInputs(List<RawInput> rawInputs) {
		this.rawInputs = rawInputs;
	}

	public String getIntent() {
		return intent;
	}

	public void setIntent(String intent) {
		this.intent = intent;
	}

	public List<Argument> getArguments() {
		return arguments;
	}

	public void setArguments(List<Argument> arguments) {
		this.arguments = arguments;
	}

}
