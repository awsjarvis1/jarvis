package com.elk.service;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;

import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Service;

@Service
public class ElkService {

	private static final Logger logger = LoggerFactory.getLogger(ElkService.class);

	public ResponseEntity<String> executeScript(String filePath, String sessionId, String intent, String driveList,String scriptName){

		return callpythonScript( filePath, sessionId , intent , driveList, scriptName);
	}

	private ResponseEntity<String> callpythonScript(String filePath, String sessionId, String intent , String driveList, String scriptName){

		String scriptOutput = null;
		List<String> output = null;

		ResponseEntity<String> response = null;


		try{
			ArrayList<String> commands = new ArrayList<>();
			commands.add("python");
			commands.add(scriptName);
			commands.add("-p");
			commands.add(filePath);
			commands.add("-s");
			commands.add(sessionId);
			commands.add("-i");
			commands.add(intent);
			if(driveList != null){
				commands.add("-d");
				commands.add(driveList);

			}
			
			logger.debug("Executing script <" + scriptName + "> with commands: " + commands);

			scriptOutput = invokeScript(commands);
			logger.info(" elk script output " + scriptOutput);


		}catch(IOException e){
			logger.error("Error in getting script file path : " + e.getMessage());
			response = new ResponseEntity<>("Could not process Log File.",HttpStatus.INTERNAL_SERVER_ERROR);
			return response;
		}catch(Exception e){
			logger.error("Error in executing script  : " + e.getMessage());
			response = new ResponseEntity<>("Could not process Log File.",HttpStatus.INTERNAL_SERVER_ERROR);
			return response;
		}

		if(scriptOutput == null){
			logger.error("script output File not created ." );
			response = new ResponseEntity<>("Could not process Log File.",HttpStatus.INTERNAL_SERVER_ERROR);
			return response;
		}

		Path outputResponse = Paths.get(scriptOutput);
		JSONObject jsonObj = new JSONObject();
		StringBuilder builder = null;

		if(Files.exists(outputResponse)){
			try{
				output = Files.readAllLines(outputResponse);
				builder = new StringBuilder();

				for(String str : output){
					builder.append(str);
				}

				logger.debug("output of script : : " + builder); 
				jsonObj.put("result", builder);

			}catch(IOException e){
				logger.error("Error in reading output : " + e.getMessage());
				response = new ResponseEntity<>("Could not process Log File.",HttpStatus.INTERNAL_SERVER_ERROR);
				return response;
			}

		}else{
			logger.error("Error in executing script");
			response = new ResponseEntity<>("Could not process Log File.",HttpStatus.INTERNAL_SERVER_ERROR);
			return response;

		}

		response = new ResponseEntity<>(jsonObj.toString(),HttpStatus.OK);

		return response;

	}


	private String invokeScript(ArrayList<String> commands) throws Exception {

		Process process = null;
		InputStream istream = null;
		BufferedReader reader = null;
		String res = null;

		try {
			process = new ProcessBuilder(commands).start();
			istream = process.getInputStream();

			reader = new BufferedReader(new InputStreamReader(istream));

			String istreamLine = null;


			while ((istreamLine = reader.readLine()) != null) {
				res = "" + istreamLine; 
			}
		} 
		catch(Exception e){
			logger.error("Error in invoke script: " + e.getMessage());
		}
		finally {
			if (reader != null) {
				reader.close();
				reader = null;
			}

			if (istream != null) {
				istream.close();
				istream = null;
			}

			if (process != null) {
				process.destroy();
				process = null;
			}
		}

		return res;
	}


}
