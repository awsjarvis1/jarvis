package com.jarvis;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
@ComponentScan("com.jarvis.*")
public class Jarvis {

	public static void main(String[] args) throws Exception {
		SpringApplication.run(Jarvis.class, args);
	}
}