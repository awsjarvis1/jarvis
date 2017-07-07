package com.jarvis.handler.impl;

import java.sql.Types;
import java.util.ArrayList;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.stereotype.Component;

import com.jarvis.handler.RequestHandler;
import com.jarvis.model.request.Context;
import com.jarvis.model.request.Request;
import com.jarvis.model.response.Response;

@Component
public class CommandRequestHandler implements RequestHandler {

	@Autowired
	private JdbcTemplate jdbcTemplate;


	@Override
	public Response handleRequest(Request request) {
		Response response = new Response();

		ArrayList<Context> contextList = (ArrayList<Context>) request.getResult().getContexts();
		String arrayType = null;
		String contextName = null;

		if (request.getResult().getMetadata().getIntentName().equalsIgnoreCase("Output")) {


			String sr_no=getSRCount().toString();
			String reported_by = request.getSessionId().substring(request.getSessionId().lastIndexOf('-')+1,request.getSessionId().length());
			String problem_type = "mydrivefaultcontext";
			String product = getProductDetails(request,problem_type);
			String date = request.getTimestamp();

			int row = queryUpdateSR(sr_no,reported_by,problem_type,product,date);

			response.setSpeech("We have opened an SR no " + sr_no+" for this issue");
			return response;
		} else {

			String reported_by = request.getSessionId().substring(request.getSessionId().lastIndexOf('-')+1,request.getSessionId().length());

			String role = getUserRole(reported_by);

			if(role.equalsIgnoreCase("escalation") || role.equalsIgnoreCase("customer-eng")){
				boolean problemMatches = false;

				for (Context context : contextList) {

					contextName = context.getName();

					if (contextName.equalsIgnoreCase("lunnotvisible") || contextName.equalsIgnoreCase("mydrivefaultcontext")
							|| contextName.equalsIgnoreCase("yes-cliaccess")
							|| contextName.equalsIgnoreCase("imageusecasearraynotaccessible")) {
						problemMatches = true;
						arrayType = request.getResult().getParameters().getArrayType();
						break;
					}
				}

				if (problemMatches && arrayType.equalsIgnoreCase("Utype")) {
					String command = queryGetCommand(arrayType,contextName);
					response.setSpeech("Please fire the following command: " + command
							+ " and let me know if any of the drives show up as FLT");
				}
			}else{
				response.setSpeech("Sorry, You are not authorize to ask this question.");
			}

		}

		return response;
	}

	private String getProductDetails(Request request,String detailType){
		ArrayList<Context> contextList = (ArrayList<Context>) request.getResult().getContexts();
		String requiredDetail = null;
		for (Context context : contextList) {

			String contextName = context.getName();

			if (contextName.equalsIgnoreCase(detailType)) {
				requiredDetail = context.getParameters().getArrayType();
				break;
			}

		}

		return requiredDetail;
	}




	public String queryGetCommand(String product, String problemType) {
		String sql = "SELECT COMMAND FROM JARVIS_SCHEMA.HW_COMMANDS WHERE PRODUCT = ? AND PROBLEM_TYPE = ?";
		String command  = jdbcTemplate.queryForObject(sql,new Object[]{product,problemType},String.class);
		return command;
	}

	public Integer getSRCount(){

		String sql = "SELECT COUNT(sr_no) FROM JARVIS_SCHEMA.SERVICE_REQUEST";
		Integer row = jdbcTemplate.queryForObject(sql, Integer.class);
		return row + 1;
	}

	public int queryUpdateSR(String sr_no, String reported_by,String problem_type,String product,String date) {
		String sql = "INSERT INTO JARVIS_SCHEMA.SERVICE_REQUEST VALUES(?,?,?,?,?)";
		Object[] obj = new Object[] {sr_no,reported_by,problem_type,product,date};
		int[] types= new int[] {Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR,Types.VARCHAR};
		int row  = jdbcTemplate.update(sql,obj,types);
		return row;
	}

	public String getUserRole(String user){
		String sql = "SELECT ROLE FROM JARVIS_SCHEMA.ACCOUNT WHERE user = ?";
		String role  = jdbcTemplate.queryForObject(sql,new Object[]{user},String.class);
		return role;
	}

}
