package com.jarvis.handler.impl;

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

		String user = request.getSessionId().substring(request.getSessionId().lastIndexOf('-')+1,request.getSessionId().length());
		String role = getUserRole(user);
		
		
		Response response = new Response();
		
		if(role.equalsIgnoreCase("escalation")){
			String product = request.getResult().getParameters().getArrayType();
			String problemType = request.getResult().getMetadata().getIntentName();
			String command = queryGetCommand(product,problemType);
			
			response.setSpeech("Please fire the following command: " + command);
		}else{
			response.setSpeech("Sorry, You are not authorize to ask this question.");
		}
		
		return response;

	}

	public String queryGetCommand(String product, String problemType) {
		String sql = "SELECT COMMAND FROM JARVIS_SCHEMA.HW_COMMANDS WHERE PRODUCT = ? AND PROBLEM_TYPE = ?";
		String command  = jdbcTemplate.queryForObject(sql,new Object[]{product,problemType},String.class);
		return command;
	}
	
	public String getUserRole(String user){
		String sql = "SELECT ROLE FROM JARVIS_SCHEMA.ACCOUNT WHERE user = ?";
		String role  = jdbcTemplate.queryForObject(sql,new Object[]{user},String.class);
		return role;
	}
}
