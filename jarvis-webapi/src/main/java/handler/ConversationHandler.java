package handler;

import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

public interface ConversationHandler {
	
	public Response handleConversation(Request request);

	public static String getDefaultAnswer() {
		return "Sorry, Could not understand the question";
	}
}
