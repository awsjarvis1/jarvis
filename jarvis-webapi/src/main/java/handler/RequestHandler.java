package handler;

import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

import exception.InsufficientInformationException;

public interface RequestHandler {
	public Response handleRequest(Request request) throws InsufficientInformationException;
}
