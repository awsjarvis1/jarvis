package com.cg.hackathon.imageprocessor.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.InputStream;
import java.util.LinkedHashMap;
import java.util.Map;

import org.apache.commons.io.IOUtils;

import org.json.JSONObject;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;
import org.springframework.beans.factory.annotation.Autowired;


import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.CrossOrigin;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;


import com.cg.hackathon.imageprocessor.configuration.AppConfig;
import com.cg.hackathon.imageprocessor.message.ImageProcessorMessage;
import com.cg.hackathon.imageprocessor.service.ImageProcessorService;


import ch.qos.logback.classic.Level;
import ch.qos.logback.classic.LoggerContext;

@CrossOrigin(origins = "*")
@RestController
public class ApplicationController {

	@Autowired
	private AppConfig appConfig;
	
	@Autowired
	private BeanFactory beanFactory;

	private ImageProcessorService imageProcessorService;

	private final static Logger logger = LoggerFactory.getLogger(ApplicationController.class);

	/*
	 * Returns the app name, description , version & build date
	 * 
	 **/
	@RequestMapping("/")
	@ResponseBody
	public Map<String, Object> home() {

		logger.info("Recieved request to return app details");

		Map<String, Object> details = new LinkedHashMap<>();
		details.put("name", appConfig.getName());
		details.put("description", appConfig.getDescription());
		details.put("version", appConfig.getVersion());
		details.put("buildDate", appConfig.getBuildDate());
		return details;
	}

	/*
	 * Set the log level of the application
	 * 
	 */
	@RequestMapping(method = RequestMethod.PUT, value = "/setLogLevel/{level}")
	public void setLogLevel(@PathVariable("level") String level) {
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
		lc.getLogger("com.cg.hackathon.imageprocessoradapter").setLevel(Level.toLevel(level));
		logger.info("setLogLevel: log level changed to " + Level.toLevel(level));
	}

	/*
	 * 
	 * Fetches the current log level of the application
	 * 
	 */
	@RequestMapping(method = RequestMethod.GET, value = "/getLogLevel")
	public String getLogLevel() {
		LoggerContext lc = (LoggerContext) LoggerFactory.getILoggerFactory();
		return lc.getLogger("com.cg.hackathon.imageprocessoradapter").getLevel().toString();
	}

	/*
	 * Returns the description of the microservice
	 * 
	 */
	@RequestMapping(value = "/status", produces = "text/plain; charset=utf-8")
	public ResponseEntity<?> appstatus() {
		logger.debug("Request for micro service status");

		String statusStr = "Service Description: This microservice processes an image to find out the abnormalities related to the array";
		HttpHeaders responseHeader = new HttpHeaders();
		try {
			responseHeader.set("X-Service-Status", "OK");
		} catch (Exception e) {
			logger.debug("Exception encountered when query for service status: " + e);
			return new ResponseEntity<>(statusStr, responseHeader, HttpStatus.OK);
		}
		return new ResponseEntity<>(statusStr, responseHeader, HttpStatus.OK);
	}

	/*
	 * Fetches the file name from the GUI
	 * 
	 */

	@RequestMapping(method = RequestMethod.POST, value = "/api/imageprocessor/receiveFile")
	public ResponseEntity<?> getImageProcessorResponse(@RequestParam("file") MultipartFile file,

			@RequestParam("sessionId") String sessionId, @RequestParam("intent") String intent) throws Exception {


		HttpHeaders responseHeader = new HttpHeaders();

		try {
			logger.info("Received request with image file name :" + file.getOriginalFilename() + ",  size : "
					+ file.getSize());

			setImageProcessorServiceInstance();


			JSONObject responseJSON = imageProcessorService.processFile(file, sessionId, intent);

			if (responseJSON == null) {

				logger.error("Could not process image");
				responseHeader.set("500", "Unexpected Error");
				return new ResponseEntity<>("Could not process image. Cannot proceed", responseHeader,
						HttpStatus.INTERNAL_SERVER_ERROR);
			}

			responseHeader.set("200", "SUCCESS");

			return new ResponseEntity<>(responseJSON.toString(), responseHeader, HttpStatus.OK);

		} catch (Exception e) {
			logger.error("Received exception while processing image : " + e.getMessage());
			responseHeader.set("500", "Unexpected Error");
			return new ResponseEntity<>("Could not process image. Cannot proceed", responseHeader,
					HttpStatus.INTERNAL_SERVER_ERROR);
		}
	}

	

	@RequestMapping(value = "/api/imageprocessor/getImage")

       public ResponseEntity<?> getImages(@RequestParam("fileName") String fileName) throws Exception{


              HttpHeaders responseHeader = new HttpHeaders();

              InputStream is = null;

              try {

                     logger.info("Received request to upload file with name : " + fileName);
 		     
                     setImageProcessorServiceInstance();
                     File file = imageProcessorService.getImageFile(fileName);
                     is = new FileInputStream(file);
                     responseHeader.set("200", "SUCCESS");
                     return new ResponseEntity<>(IOUtils.toByteArray(is), responseHeader, HttpStatus.OK);

              } catch (Exception e) {
                     logger.error("Received exception while attempting to return image to GUI: " + e.getMessage());
                     responseHeader.set("500", "Unexpected Error");
                     return new ResponseEntity<>("Could not return image to GUI", responseHeader,
                                  HttpStatus.INTERNAL_SERVER_ERROR);
              } finally {
                     logger.info("Attempting to close input stream for image ");
                     if (is != null) {
                           is.close();
                           is = null;
                     }
              }
       }

	private void setImageProcessorServiceInstance() {
		imageProcessorService = beanFactory.getBean(ImageProcessorService.class);
	}

}
