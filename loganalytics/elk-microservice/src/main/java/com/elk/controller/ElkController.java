package com.elk.controller;

import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.bind.annotation.CrossOrigin;
import com.elk.service.ELKConstants;
import com.elk.service.ElkService;

@CrossOrigin
@RestController
public class ElkController {

	@Value("#{environment['WORKSPACE']}")
	private String scriptPath;

	private static final Logger logger = LoggerFactory.getLogger(ElkController.class);


	private ElkService service;


	public ElkService getService() {
		return service;
	}

	@Autowired
	public void setService(ElkService service) {
		this.service = service;
	}

	@RequestMapping("/status")
	@ResponseStatus(HttpStatus.OK)
	@ResponseBody
	public String info() {
		return "ELK Service";
	}

	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public ResponseEntity<String>  fileUpload(@RequestParam("file")MultipartFile file, @RequestParam("sessionId") String sessionId,
			@RequestParam("intent") String intent,@RequestParam(value = "driveList", required = false) String driveList,  HttpServletRequest request){

		logger.debug("Received request param : fileName : " + file.getName() + " sessionId : " + sessionId + " intent : " + intent);


		if (file.isEmpty()) {
			logger.error("Uploaded File is empty.Please upload correct File");
			ResponseEntity<String> res = new ResponseEntity<>(HttpStatus.BAD_REQUEST);
			return res;
		}


		Path path =  Paths.get(ELKConstants.UPLOADED_FILE_LOCATION + file.getOriginalFilename()+"_"+ sessionId);

		try {

			// Get the file and save it 
			byte[] bytes = file.getBytes();
			if(!Files.exists(path)){
				Files.createDirectories(path.getParent());
			}
			Files.write(path, bytes);
			logger.debug("Debug File Path : " +  path.toFile().getPath());

		} catch (IOException e) {
			logger.error("Error in downloading File: " + e.getMessage());
			ResponseEntity<String> res = new ResponseEntity<>(HttpStatus.INTERNAL_SERVER_ERROR);
			return res;

		}

		String script = scriptPath + File.separator + ELKConstants.SCRIPT_NAME;

		return elkService(path.toString(),request.getSession().getId(),intent,driveList,script);

	}

	public ResponseEntity<String> elkService(String path,String sessionId,String intent,String driveList,String script){

		return service.executeScript(path.toString(),sessionId,intent,driveList,script);
	}








}
