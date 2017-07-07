package com.jarvis.controller;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.jarvis.engine.ChatEngine;
import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

@RestController
public class JarvisController {
	
	private static final Logger logger = LoggerFactory.getLogger(JarvisController.class);
	
	@Autowired
	private ChatEngine chatEngine;

	@RequestMapping(method = RequestMethod.GET, value = "/status")
	public String status() {
		return "running";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/action", produces = "application/json", consumes = "application/json")
	public Response processChatBotRequest(@RequestBody Request request) {
		logger.debug("Received Request");
		return chatEngine.execute(request);
	}
}
