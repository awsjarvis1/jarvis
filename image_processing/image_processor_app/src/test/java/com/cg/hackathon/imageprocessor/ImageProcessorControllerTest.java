package com.cg.hackathon.imageprocessor;

import static org.junit.Assert.assertEquals;

import static org.mockito.Mockito.when;

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
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.mock.web.MockMultipartFile;
import org.springframework.web.multipart.MultipartFile;

import com.cg.hackathon.imageprocessor.controller.ApplicationController;
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

		ImageProcessorMessage imageProcessorMessage = new ImageProcessorMessage();
		imageProcessorMessage.setMessage("Test message");

		when(bean.getBean(ImageProcessorService.class)).thenReturn(imageProcessorService);
		when(imageProcessorService.processFile(mockMultipartFile, sessionId)).thenReturn(imageProcessorMessage);

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("200", "SUCCESS");
		ResponseEntity<?> responseEntity = new ResponseEntity<>(imageProcessorMessage, responseHeader, HttpStatus.OK);
		logger.info(
				"Starting testing of getImageProcessorResponse() when valid response is received from image processor ");
		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId));
		logger.info(
				"Successfully tested getImageProcessorResponse() when valid response is received from image processor ");
	}

	@Test
	public void testNegativeScenario1GetImageProcessorResponse() throws Exception {
		MultipartFile mockMultipartFile = new MockMultipartFile("data", "testfile.txt", "text/plain",
				"sample test".getBytes());

		final String sessionId = "testSessionId";

		ImageProcessorMessage imageProcessorMessage = null;

		when(imageProcessorService.processFile(mockMultipartFile, sessionId)).thenReturn(imageProcessorMessage);

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("500", "Unexpected Error");
		ResponseEntity<?> responseEntity = new ResponseEntity<>("Could not process image. Cannot proceed",
				responseHeader, HttpStatus.INTERNAL_SERVER_ERROR);
		logger.info(
				"Starting testing of getImageProcessorResponse() when invalid response is received from image processor ");
		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId));
		logger.info(
				"Successfully tested getImageProcessorResponse() when invalid response is received from image processor ");
	}

	@Test
	public void testNegativeScenario2GetImageProcessorResponse() throws Exception {
		MultipartFile mockMultipartFile = null;

		final String sessionId = "testSessionId";

		HttpHeaders responseHeader = new HttpHeaders();
		responseHeader.set("500", "Unexpected Error");
		ResponseEntity<?> responseEntity = new ResponseEntity<>("Could not process image. Cannot proceed",
				responseHeader, HttpStatus.INTERNAL_SERVER_ERROR);
		logger.info(
				"Starting testing of getImageProcessorResponse() when invalid response is received from image processor ");
		assertEquals(responseEntity, appController.getImageProcessorResponse(mockMultipartFile, sessionId));
		logger.info(
				"Successfully tested getImageProcessorResponse() when invalid response is received from image processor ");
	}

}
