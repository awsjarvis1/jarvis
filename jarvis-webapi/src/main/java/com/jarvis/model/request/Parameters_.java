package com.jarvis.model.request;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;
import com.fasterxml.jackson.annotation.JsonPropertyOrder;

@JsonInclude(JsonInclude.Include.NON_NULL)
@JsonPropertyOrder({ "ArrayType", "ArrayType.original" })
public class Parameters_ {

	@JsonProperty("ArrayType")
	private String arrayType;
	@JsonProperty("ArrayType.original")
	private String arrayTypeOriginal;

	@JsonProperty("ArrayType")
	public String getArrayType() {
		return arrayType;
	}

	@JsonProperty("ArrayType")
	public void setArrayType(String arrayType) {
		this.arrayType = arrayType;
	}

	@JsonProperty("ArrayType.original")
	public String getArrayTypeOriginal() {
		return arrayTypeOriginal;
	}

	@JsonProperty("ArrayType.original")
	public void setArrayTypeOriginal(String arrayTypeOriginal) {
		this.arrayTypeOriginal = arrayTypeOriginal;
	}

}
