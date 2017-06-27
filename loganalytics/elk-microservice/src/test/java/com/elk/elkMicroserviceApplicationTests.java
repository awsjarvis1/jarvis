package com.elk;

import static org.junit.Assert.assertTrue;

import java.nio.file.Path;
import java.nio.file.Paths;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.boot.test.context.TestConfiguration;
import org.springframework.context.annotation.Bean;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.test.context.junit4.SpringRunner;

import com.elk.service.ELKConstants;
import com.elk.service.ElkService;

@RunWith(SpringRunner.class)
@SpringBootTest
public class elkMicroserviceApplicationTests {

	@TestConfiguration
	static class ElkServiceImplTestContextConfiguration {

		@Bean
		public ElkService elkService() {
			return new ElkService();
		}
	}

	@Autowired
	private ElkService elkService;

	@Test
	public void TestInvalidFile(){

		Path path = Paths.get("test.txt");
		ResponseEntity<String> resp = elkService.executeScript(path, "sessionId", "intent",ELKConstants.SCRIPT_NAME);

		assertTrue(resp.getStatusCode().equals(HttpStatus.INTERNAL_SERVER_ERROR));
	}

	@Test
	public void TestInvalidScriptFile(){

		Path path = Paths.get("test.txt");
		ResponseEntity<String> resp = elkService.executeScript(path, "sessionId", "intent","InValid_Test_Script.py");

		assertTrue(resp.getStatusCode().equals(HttpStatus.INTERNAL_SERVER_ERROR));
	}


}
