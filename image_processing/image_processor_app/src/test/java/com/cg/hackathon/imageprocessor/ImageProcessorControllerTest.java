package com.cg.hackathon.imageprocessor;

import static org.junit.Assert.assertEquals;

import static org.mockito.Mockito.when;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.ObjectOutputStream;
import java.io.OutputStream;

import org.apache.commons.io.IOUtils;
import org.json.JSONObject;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.InjectMocks;
import org.mockito.Mock;
import org.mockito.MockitoAnnotations;
import org.powermock.modules.junit4.PowerMockRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.BeanFactory;



import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import com.cg.hackathon.imageprocessor.controller.ApplicationController;

import com.cg.hackathon.imageprocessor.message.ImageProcessorMessage;

import com.cg.hackathon.imageprocessor.service.ImageProcessorService;

@RunWith(PowerMockRunner.class)
public class ImageProcessorControllerTest {

	private static final Logger logger = LoggerFactory.getLogger(ImageProcessorControllerTest.class);

	@InjectMocks
	private ApplicationController appController;

	@Mock
	private ImageProcessorService imageProcessorService;

	@Mock
	private BeanFactory bean;

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testValidGetImageProcessorResponse() throws Exception {
		MultipartFile mockMultipartFile = new MockMultipartFile("data", "testfile.txt", "text/plain",
				"sample test".getBytes());

		final String sessionId = "testSessionId";

		final String intent = "sp_servicemode";

		JSONObject testJSONObject = new JSONObject("{\"key\" : \"value\"}");

		when(bean.getBean(ImageProcessorService.class)).thenReturn(imageProcessorService);
		when(imageProcessorService.processFile(mockMultipartFile, sessionId, intent)).thenReturn(testJSONObject);

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("200", "SUCCESS");
		ResponseEntity<?> responseEntity = new ResponseEntity<>(testJSONObject.toString(), responseHeader, HttpStatus.OK);
		logger.info(
				"Starting testing of getImageProcessorResponse() when valid response is received from image processor ");
		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId, intent));

		logger.info(
				"Successfully tested getImageProcessorResponse() when valid response is received from image processor ");
	}

	@Test
	public void testNegativeScenario1GetImageProcessorResponse() throws Exception {
		MultipartFile mockMultipartFile = new MockMultipartFile("data", "testfile.txt", "text/plain",
				"sample test".getBytes());

		final String sessionId = "testSessionId";

		final String intent = "sp_servicemode";
 		
		JSONObject testJSONObject = new JSONObject("{\"key\" : \"value\"}");

		when(imageProcessorService.processFile(mockMultipartFile, sessionId, intent)).thenReturn(testJSONObject);


		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("500", "Unexpected Error");
		ResponseEntity<?> responseEntity = new ResponseEntity<>("Could not process image. Cannot proceed",
				responseHeader, HttpStatus.INTERNAL_SERVER_ERROR);
		logger.info(
				"Starting testing of getImageProcessorResponse() when invalid response is received from image processor ");

		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId, intent));

		logger.info(
				"Successfully tested getImageProcessorResponse() when invalid response is received from image processor ");
	}

	@Test
	public void testNegativeScenario2GetImageProcessorResponse() throws Exception {
		MultipartFile mockMultipartFile = null;

		final String sessionId = "testSessionId";

		final String intent = "sp_servicemode";
		
		

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("500", "Unexpected Error");
		ResponseEntity<?> responseEntity = new ResponseEntity<>("Could not process image. Cannot proceed",
				responseHeader, HttpStatus.INTERNAL_SERVER_ERROR);
		logger.info(
				"Starting testing of getImageProcessorResponse() when invalid response is received from image processor ");

		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId, intent));

		logger.info(
				"Successfully tested getImageProcessorResponse() when invalid response is received from image processor ");
	}


	@Test
	public void testValidGetImages() throws Exception {

		final String fileName = "test_file_name";
		File testFile = createTestFile(fileName);

		when(bean.getBean(ImageProcessorService.class)).thenReturn(imageProcessorService);
		when(imageProcessorService.getImageFile(fileName)).thenReturn(testFile);

		InputStream fis = new FileInputStream(testFile);

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("200", "SUCCESS");
		ResponseEntity<?> responseEntity = new ResponseEntity<>(IOUtils.toByteArray(fis), responseHeader,
				HttpStatus.OK);
		logger.info("Starting testing of getImages() when file is present in image repository ");
		assertEquals(responseEntity, appController.getImages(fileName));
		logger.info("Successfully tested getImages() when file is present in image repository  ");

		if (fis != null) {
			fis.close();
		}

		if (testFile.exists()) {
			testFile.delete();
		}
	}

	@Test
	public void testNegativeScenarioGetImages() throws Exception {

		final String fileName = "test_file_name";

		when(bean.getBean(ImageProcessorService.class)).thenReturn(imageProcessorService);

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("500", "Unexpected Error");
		ResponseEntity<?> responseEntity = new ResponseEntity<>("Could not return image to GUI", responseHeader,
				HttpStatus.INTERNAL_SERVER_ERROR);
		logger.info("Starting testing of getImages() when file is not present in image repository ");
		assertEquals(responseEntity, appController.getImages(fileName));
		logger.info("Successfully tested getImages() when file is not present in image repository ");

	}

	private File createTestFile(String fileName) {
		File testFile = new File(fileName);
		try (OutputStream out = new FileOutputStream(testFile);
				ObjectOutputStream writer = new ObjectOutputStream(out);) {
			writer.writeChars("Test file");
		} catch (FileNotFoundException e) {
			e.printStackTrace();
		} catch (IOException e) {
			e.printStackTrace();
		}
		return testFile;
	}


}
