package com.cg.hackathon.imageprocessor;

import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.util.ArrayList;

import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import org.junit.runner.RunWith;
import org.mockito.MockitoAnnotations;
import org.powermock.modules.junit4.PowerMockRunner;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

@RunWith(PowerMockRunner.class)
public class ImageProcessorServiceTest {

	private static final Logger logger = LoggerFactory.getLogger(ImageProcessorServiceTest.class);

	private static final String IMAGE_PROCESSOR_SCRIPT = "processImage.py";

	@Before
	public void setUp() throws Exception {
		MockitoAnnotations.initMocks(this);
	}

	@After
	public void tearDown() throws Exception {
	}

	@Test
	public void testPythonScripts() throws Exception {
		invokeImageProcessorScript();
	}

	private void invokeImageProcessorScript() throws Exception {
		ArrayList<String> commands = new ArrayList<>();
		// commands.add("/usr/bin/python");
		ClassLoader classLoader = getClass().getClassLoader();
		String path = classLoader.getResource(IMAGE_PROCESSOR_SCRIPT).getPath();

		commands.add("python");
		commands.add(path.substring(1));

		// commands.add("-s");
		// commands.add(imageFilePath);
		// commands.add("-o");
		// commands.add(IMAGE_DUMP_LOCATION);

		logger.info("Starting testing of python script : <" + IMAGE_PROCESSOR_SCRIPT + "> with commands: " + commands);

		if (invokeScript(commands)) {
			logger.info(
					"Successfully tested python script : <" + IMAGE_PROCESSOR_SCRIPT + "> with commands: " + commands);
		} else {
			logger.info(
					"Failed while testing python script : <" + IMAGE_PROCESSOR_SCRIPT + "> with commands: " + commands);
			throw new Exception("Failure while testing script " + IMAGE_PROCESSOR_SCRIPT);
		}

		logger.info("Ended testing of python script : <" + IMAGE_PROCESSOR_SCRIPT);
	}

	private boolean invokeScript(ArrayList<String> commands) throws Exception {

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
				String scriptInfo = istreamLine;
				if (!scriptInfo.contains("PASSED")) {
					return false;
				}
			}
			return true;
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

}