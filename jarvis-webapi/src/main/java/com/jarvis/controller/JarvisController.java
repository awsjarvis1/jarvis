package com.jarvis.controller;

import java.util.Date;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import com.jarvis.engine.ChatEngine;
import com.jarvis.model.remedy.Issues;
import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;
import com.jarvis.remedy.BugTracker;

@CrossOrigin
@RestController
public class JarvisController {
	
	private static final Logger logger = LoggerFactory.getLogger(JarvisController.class);
	
	@Autowired
	private ChatEngine chatEngine;

	private static final Logger logger = LoggerFactory.getLogger(JarvisController.class);

	@Autowired
	private ChatEngine chatEngine;

	@Autowired
	private BugTracker bugTracker;

	@RequestMapping(method = RequestMethod.GET, value = "/status")
	public String status() {
		return "running";
	}

	@RequestMapping(method = RequestMethod.GET, value = "/getIssues")
	public Issues getIssues(@RequestParam(value = "user") String userName) {
		return bugTracker.viewServiceRequests(userName);
	}

	@RequestMapping(method = RequestMethod.GET, value = "/insertIssue")
	public String insertIssue(@RequestParam(value = "user") String userName,
			@RequestParam(value = "problemType") String problemType, @RequestParam(value = "product") String product) {
		return bugTracker.createServiceRequest(userName, problemType, product, new Date().toString());
	}

	@RequestMapping(method = RequestMethod.POST, value = "/action", produces = "application/json", consumes = "application/json")
	public Response processChatBotRequest(@RequestBody Request request) {
		logger.debug("Received Request");
		return chatEngine.execute(request);
	}
}
