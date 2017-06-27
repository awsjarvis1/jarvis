package engine;

import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

import exception.InsufficientInformationException;
import handler.ConversationHandler;
import handler.RequestHandler;
import handler.factory.ConversationHandlerFactory;
import handler.factory.RequestHandlerFactory;

public class ChatEngine {

	public Response execute(Request request) {

		Response response = null;

		RequestHandler requestHandler = RequestHandlerFactory.getRequestHandler(request);
		ConversationHandler conversationHandler = ConversationHandlerFactory.getConversationHandler(request);

		try {
			response = requestHandler.handleRequest(request);
		} catch (InsufficientInformationException exception) {
			response = conversationHandler.handleConversation(request);
		}

		return response;
	}
}
