package com.jarvis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;

@SpringBootApplication
public class Jarvis {

	public static void main(String[] args) throws Exception {
                // made code changes to set the default running port 8080 to 8081
                System.getProperties().put("server.port", 8081);
		
                SpringApplication.run(Jarvis.class, args);
	}
}
