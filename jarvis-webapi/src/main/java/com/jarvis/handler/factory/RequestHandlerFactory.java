package com.jarvis.handler.factory;

import java.util.ArrayList;

import com.jarvis.handler.RequestHandler;
import com.jarvis.handler.impl.CommandRequestHandler;
import com.jarvis.handler.impl.DefaultRequestHandler;
import com.jarvis.model.request.Context;
import com.jarvis.model.request.Request;

public class RequestHandlerFactory {

	public static RequestHandler getRequestHandler(Request request) {
		ArrayList<Context> contextList = (ArrayList<Context>) request.getResult().getContexts();

		for (Context context : contextList) {
			if (context.getName().equalsIgnoreCase("yes-cliaccess")) {
				return new CommandRequestHandler();
			}
		}

		return new DefaultRequestHandler();
	}
}
