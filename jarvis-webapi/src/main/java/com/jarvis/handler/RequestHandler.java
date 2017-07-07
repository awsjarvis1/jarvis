package com.jarvis.handler;

import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

public interface RequestHandler {
	public Response handleRequest(Request request);
}
