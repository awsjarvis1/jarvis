package com.jarvis.engine;

import java.util.ArrayList;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;

import com.jarvis.handler.RequestHandler;
import com.jarvis.model.request.Context;
import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;



@Component
public class ChatEngine {
	
	private static final Logger logger = LoggerFactory.getLogger(ChatEngine.class);
	
	@Autowired
	private RequestHandler commandRequestHandler;
	
	
	@Autowired
	private RequestHandler defaultRequestHandler;
	

	public Response execute(Request request) {

		RequestHandler requestHandler = getRequestHandler(request);
		
		logger.debug("RequestHandler found");

		Response response = requestHandler.handleRequest(request);

		return response;
	}
	
	private RequestHandler getRequestHandler(Request request){
		
		ArrayList<Context> contextList = (ArrayList<Context>) request.getResult().getContexts();

		for (Context context : contextList) {
			if (context.getName().equalsIgnoreCase("yes-cliaccess")) {
				return commandRequestHandler;
			}
		}

		return defaultRequestHandler;
	}
}
