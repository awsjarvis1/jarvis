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
import org.springframework.context.annotation.Scope;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.cg.hackathon.imageprocessor.ImageProcessorMessage;

@Service
@Scope("prototype")
public class ImageProcessorService {

	private final static Logger logger = LoggerFactory.getLogger(ImageProcessorService.class);

	private static final String IMAGE_PROCESSOR_SCRIPT = "find_faulty_disk.py";
	private static final String IMAGE_EXTENSION = ".jpg";
	private static final String JSON_EXTENSION = "_response.json";
        private static final String OUTPUT_IMAGE_EXTENSION = "_processed.jpg";
        private static final String IMAGE_DUMP_LOCATION = "/root/image_processor_app/images";        


	public ImageProcessorMessage processFile(MultipartFile file, String sessionId) {
		String fileName = file.getOriginalFilename();
		String fileNameWithoutExt = fileName.substring(0, fileName.indexOf("."));
		return processFile(file, sessionId, fileNameWithoutExt);
	}
	
	public File getImageFile(String fileName, String sessionId) throws Exception{
	      String fileNameWithoutExt = fileName.substring(0, fileName.indexOf("."));
              String responseFileName = getFileName(fileNameWithoutExt, sessionId, "getFile");
	      if(responseFileName == ""){
                  throw new Exception("Unable to create image file name");
              }
              File responseImageFile = new File(IMAGE_DUMP_LOCATION + "/" + responseFileName);
              if(!responseImageFile.exists()){
                  throw new Exception("Unable to locate image file with name : " + IMAGE_DUMP_LOCATION + "/" + responseFileName);
              }
              logger.info("Retrieved image file from repository : " + responseImageFile);
              return responseImageFile;
       }

	private ImageProcessorMessage processFile(MultipartFile multipartFile, String sessionId, String fileName) {
		ImageProcessorMessage imageProcessorMessage = null;
		FileOutputStream fileOutputStream = null;
		String updatedFileName = getFileName(fileName, sessionId, "input");
		String responseFileName = getFileName(fileName, sessionId, "output");

		if (!multipartFile.isEmpty()) {
			try {
				byte[] fileBytes = multipartFile.getBytes();
				File file = new File(updatedFileName);
				fileOutputStream = new FileOutputStream(file);
				BufferedOutputStream stream = new BufferedOutputStream(fileOutputStream);
				stream.write(fileBytes);
				stream.close();
				fileOutputStream.close();

				invokeImageProcessorScript(file.getAbsolutePath());

				String response = processResponseFile(responseFileName, sessionId);

				logger.info("Received response from the file as : " + response);

				imageProcessorMessage = new ImageProcessorMessage();
				imageProcessorMessage.setMessage(response);
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
		return imageProcessorMessage;
	}

	private void invokeImageProcessorScript(String imageFilePath) throws Exception {
		ArrayList<String> commands = new ArrayList<>();
		commands.add("/usr/bin/python");
		commands.add("/root/image_processor_app/src/main/resources/" + IMAGE_PROCESSOR_SCRIPT);
		commands.add("-i");
                commands.add(imageFilePath);
                commands.add("-o");
                commands.add(IMAGE_DUMP_LOCATION);

		logger.info("Executing script <" + IMAGE_PROCESSOR_SCRIPT + "> with commands: " + commands);

		invokeScript(commands);
	}

	private String processResponseFile(String responseFileName, String sessionId) {
		String response = "";
		File file = new File(IMAGE_DUMP_LOCATION+ "/" + responseFileName);

		if (file.exists()) {
			logger.info("Attempting to read file : " + file);
			FileInputStream fileInputStream = null;
			try {

				fileInputStream = new FileInputStream(file);
				response = IOUtils.toString(fileInputStream);
				logger.info("Received response as from file : " + responseFileName + " as : " + response);
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
		return response;
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

	private String getFileName(String fileName, String sessionId, String type) {
		if (type.equalsIgnoreCase("input")) {
			return fileName + "_" + sessionId + IMAGE_EXTENSION;
		} else if (type.equalsIgnoreCase("output")) {
			return fileName + "_" + sessionId + JSON_EXTENSION;
		} else if(type.equalsIgnoreCase("getFile")){
			return fileName + "_" + sessionId + OUTPUT_IMAGE_EXTENSION;
		} else {
			return "";
		}
	}
	
	private void cleanUp(String fileName1, String fileName2) {
		File inputFile = new File(fileName1);
		File outputFile = new File(fileName2);

		if (inputFile.exists()) {
			inputFile.delete();
			inputFile = null;
		}

		if (outputFile.exists()) {
			outputFile.delete();
			outputFile = null;
		}

	}	

}
