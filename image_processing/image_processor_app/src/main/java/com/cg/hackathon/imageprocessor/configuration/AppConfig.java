package com.cg.hackathon.imageprocessor.configuration;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.context.annotation.Configuration;

@Configuration
public class AppConfig {

	@Value("${application.name}")
	private String name;

	@Value("${application.version}")
	private String version;

	@Value("${application.description}")
	private String description;
	
	@Value("${application.builddate}")
	private String buildDate;

	public String getName() {
		return this.name;
	}

	public String getVersion() {
		return this.version;
	}

	public String getDescription() {
		return this.description;
	}

	public String getBuildDate() {
		return buildDate;
	}

	@Override
	public String toString() {
		return "AppConfig [name=" + name + ", version=" + version + ", description=" + description + ", buildDate="
				+ buildDate + "]";
	}
	
}
