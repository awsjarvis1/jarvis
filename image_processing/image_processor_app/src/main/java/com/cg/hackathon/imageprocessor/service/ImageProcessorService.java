package com.cg.hackathon.imageprocessor.service;

import java.io.BufferedOutputStream;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Value;

import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cg.hackathon.imageprocessor.message.ImageProcessorMessage;


@Service
@Scope("prototype")
public class ImageProcessorService {

  @Value("#{environment['WORKSPACE_IMAGE']}")
	private String scriptPath;
	
	private final static Logger logger = LoggerFactory.getLogger(ImageProcessorService.class);

	private static final String IMAGE_PROCESSOR_DRIVE_SCRIPT = "find_faulty_disk.py";
	private static final String IMAGE_PROCESSOR_SP_SCRIPT = "find_sp_fault.py";
	private static final String IMAGE_PROCESSOR_VIDEO_SCRIPT = "find_sp_blink.py";
	
	private static final String JSON_EXTENSION = "_response.json";
	private final String SCRIPT_FOLDER_LOCATION = "/image_processor_app/src/main/resources/";
	private final String IMAGE_DUMP_LOCATION = "images";
	private final String IMAGE_FOLDER = "images";

	public JSONObject processFile(MultipartFile file, String sessionId, String intent) throws Exception{
                checkWorkspaceEnvironment();
		String fileName = file.getOriginalFilename();
		int startIndex = 0;
		if (fileName.contains("\\")) {
			startIndex = fileName.lastIndexOf("\\") + 1;
		}
		String fileNameWithoutExt = fileName.substring(startIndex, fileName.lastIndexOf("."));
		String fileExtension = fileName.substring(fileName.lastIndexOf("."), fileName.length());
		return processFile(file, sessionId, fileNameWithoutExt, intent, fileExtension);
	}

	public File getImageFile(String responseFileName) throws Exception {
		checkWorkspaceEnvironment();
      	        if (responseFileName == "") {
			throw new Exception("Unable to create image file name");
		}
		File responseImageFile = new File(getImageDumpLocation() + File.separator + responseFileName);
		if (!responseImageFile.exists()) {
			throw new Exception("Unable to locate image file with name : " + getImageDumpLocation() + File.separator
					+ responseFileName);
		}
		logger.info("Retrieved image file from repository : " + responseImageFile);
		return responseImageFile;
	}

	private JSONObject processFile(MultipartFile multipartFile, String sessionId, String fileName, String intent, String fileExtension) {
		// ImageProcessorMessage imageProcessorMessage = null;
    JSONObject responseJSON = null;
		FileOutputStream fileOutputStream = null;
		String updatedFileName = getFileName(fileName, sessionId, "input", fileExtension);
		String responseFileName = getFileName(fileName, sessionId, "output", JSON_EXTENSION);
		
		System.out.println("File input name : " + updatedFileName); 		


		if (!multipartFile.isEmpty()) {
			try {
				byte[] fileBytes = multipartFile.getBytes();
				File file = new File(updatedFileName);
				fileOutputStream = new FileOutputStream(file);
				BufferedOutputStream stream = new BufferedOutputStream(fileOutputStream);
				stream.write(fileBytes);
				stream.close();
				fileOutputStream.close();


				checkDumpLocation();
        
				invokeImageProcessorScript(file.getAbsolutePath(), intent);

			 	responseJSON = processResponseFile(responseFileName, sessionId);

				// logger.info("Received response from the file as : " + response + " ,json object : " + new JSONObject(response));

				// imageProcessorMessage = new ImageProcessorMessage();
				// imageProcessorMessage.setJsonMessage(responseJSON);
				logger.info("File : " + file.getName() + ", size : " + file.length());


				logger.info("Attempting to clean up files ");
				cleanUp(updatedFileName, responseFileName);

			} catch (IOException e) {
				logger.error("Received IO exception " + e.getMessage());
			} catch (Exception e) {
				logger.error("Received Exception " + e.getMessage());
			} finally {
				if (fileOutputStream != null) {
					try {
						fileOutputStream.close();
					} catch (IOException e) {
						logger.error("Received exception while attempting to close fileOutputStream " + e.getMessage());
					}
					fileOutputStream = null;
				}

				logger.info("Attempting to clean up files ");
				cleanUp(updatedFileName, responseFileName);
			}
		}

		return responseJSON;
	}

	private void invokeImageProcessorScript(String imageFilePath, String intent) throws Exception {
		ArrayList<String> commands = new ArrayList<>();
		commands.add("/usr/bin/python");
		if(intent.equalsIgnoreCase("drive_failure")){
			commands.add(getScriptFolderLocation() + IMAGE_PROCESSOR_DRIVE_SCRIPT);
		}else if(intent.equalsIgnoreCase("sp_servicemode")){
			commands.add(getScriptFolderLocation() + IMAGE_PROCESSOR_SP_SCRIPT);
		}else if(intent.equalsIgnoreCase("video")){
			commands.add(getScriptFolderLocation() + IMAGE_PROCESSOR_VIDEO_SCRIPT);
		}else{
			throw new Exception("Received unknown intent " + intent);
		}
		commands.add("-i");
		commands.add(imageFilePath);
		commands.add("-o");
		commands.add(getImageDumpLocation());

		logger.info("Executing script with commands: " + commands);


		invokeScript(commands);
	}


	private JSONObject processResponseFile(String responseFileName, String sessionId) {
		JSONObject responseJSON = null ;
		File file = new File(getImageDumpLocation() + File.separator + responseFileName);


		if (file.exists()) {
			logger.info("Attempting to read file : " + file);
			FileInputStream fileInputStream = null;
			try {

				fileInputStream = new FileInputStream(file);

				String response = IOUtils.toString(fileInputStream);
				responseJSON = new JSONObject(response);
				logger.info("Received response as from file : " + responseFileName + " as ** : " + responseJSON);

				fileInputStream.close();
			} catch (Exception e) {
				logger.error("Error : " + e.getMessage());
			} finally {
				if (fileInputStream != null) {
					try {
						fileInputStream.close();
					} catch (IOException e) {
						logger.error("Error : " + e.getMessage());
					}
					fileInputStream = null;
				}
			}
		}

		return responseJSON;
	}
	
	private void checkWorkspaceEnvironment() throws Exception{
		if(scriptPath == null){
			throw new Exception("Workspace environment is not correctly set");
		}

	}

	private void invokeScript(ArrayList<String> commands) throws Exception {

		Process process = null;
		InputStream istream = null;
		BufferedReader reader = null;
		try {
			process = new ProcessBuilder(commands).start();
			istream = process.getInputStream();
			reader = new BufferedReader(new InputStreamReader(istream));
			String istreamLine = null;
			logger.info("Attempting to start read lines ");
			while ((istreamLine = reader.readLine()) != null) {
				logger.info(" INFO : " + istreamLine);
			}
		} finally {
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
	}

	private String getFileName(String fileName, String sessionId, String type, String fileExtension) {
		if (type.equalsIgnoreCase("input")) {
			return fileName + "_" + sessionId + fileExtension;
		} else if (type.equalsIgnoreCase("output")) {
			return fileName + "_" + sessionId + fileExtension;
		}else {
			return "";
		}
	}
  
	private void checkDumpLocation() {
		File imageRepo = new File(scriptPath + IMAGE_FOLDER);
		if (!imageRepo.exists()) {
			imageRepo.mkdir();
		}
	}
	
	private String getScriptFolderLocation(){
		return scriptPath + SCRIPT_FOLDER_LOCATION;
	}
	
	private String getImageDumpLocation(){
		return scriptPath + IMAGE_DUMP_LOCATION;
	}
	
	private void cleanUp(String fileName1, String fileName2) {
		File inputFile = new File(fileName1);
		File outputFile = new File(fileName2);

		if (inputFile.exists()) {
			inputFile.delete();
			inputFile = null;
		}

		if(outputFile.exists()) {
			outputFile.delete();
			outputFile = null;
		}


	}


}
