package com.vistaluxhms.base;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.autoconfigure.domain.EntityScan;
import org.springframework.context.annotation.ComponentScan;
import org.springframework.data.jpa.repository.config.EnableJpaRepositories;


@SpringBootApplication(scanBasePackages = "com.vistaluxhms")
@EnableJpaRepositories(basePackages = "com.vistaluxhms.repository")
@EntityScan(basePackages = "com.vistaluxhms.entity")
@ComponentScan(basePackages = {"com.vistaluxhms"})
public class BaseApplication {
	public static void main(String[] args) {
		SpringApplication.run(BaseApplication.class, args);
	}

}
