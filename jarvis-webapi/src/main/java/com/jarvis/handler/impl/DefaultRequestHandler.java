package com.jarvis.handler.impl;

import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.jarvis.handler.RequestHandler;
import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

@Component
public class DefaultRequestHandler implements RequestHandler {

	@Autowired
	private JdbcTemplate jdbcTemplate;

	@Override
	public Response handleRequest(Request request) {

		System.out.println("Session id: " + request.getSessionId());

		String user = request.getSessionId().substring(request.getSessionId().lastIndexOf('-') + 1,
				request.getSessionId().length());

		System.out.println("User: " + user);

		String role = getUserRole(user);

		System.out.println("Got role as: " + role);

		Response response = new Response();

		String product = request.getResult().getParameters().getArrayType();
		String problemType = request.getResult().getMetadata().getIntentName();
		
		Map<String, Object> dbResponse = queryGetCommand(product, problemType);

		String category = (String) dbResponse.get("category");
		System.out.println("Got category as: " + category);

		if (category.equalsIgnoreCase("restricted") && !role.equalsIgnoreCase("escalation")) {
			System.out.println("Unauthorized for category: " + category + "  and role: " + role);
			response.setSpeech("Sorry, you are not authorized to access this information");
		} else {
			String command = (String) dbResponse.get("command");
			System.out.println("Got command as: " + command);
			response.setSpeech("Please execute the following command: " + command);
		}

		return response;

	}

	public Map<String, Object> queryGetCommand(String product, String problemType) {
		System.out.println("Query parameters - product is: " + product + " and problem type is: " + problemType);
		String sql = "SELECT CATEGORY, COMMAND FROM JARVIS_SCHEMA.HW_COMMANDS WHERE PRODUCT = ? AND PROBLEM_TYPE = ?";
		Map<String, Object> dbResponse = jdbcTemplate.queryForMap(sql, new Object[] { product, problemType });
		return dbResponse;
	}

	public String getUserRole(String user) {
		System.out.println("Query parameters - user is: " + user);
		String sql = "SELECT ROLE FROM JARVIS_SCHEMA.ACCOUNT WHERE user = ?";
		String role = jdbcTemplate.queryForObject(sql, new Object[] { user }, String.class);
		return role;
	}
}
