package com.jarvis.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "ArrayType" })
public class Parameters {

	@JsonProperty("ArrayType")
	private String arrayType;

	@JsonProperty("ArrayType")
	public String getArrayType() {
		return arrayType;
	}

	@JsonProperty("ArrayType")
	public void setArrayType(String arrayType) {
		this.arrayType = arrayType;
	}

}
