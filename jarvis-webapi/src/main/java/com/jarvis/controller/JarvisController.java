package com.jarvis.controller;

import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RestController;

import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

import engine.ChatEngine;

@RestController
public class JarvisController {

	@RequestMapping(method = RequestMethod.GET, value = "/status")
	public String status() {
		return "running";
	}

	@RequestMapping(method = RequestMethod.POST, value = "/action", produces = "application/json", consumes = "application/json")
	public Response processChatBotRequest(@RequestBody Request request) {
		return new ChatEngine().execute(request);
	}
}
