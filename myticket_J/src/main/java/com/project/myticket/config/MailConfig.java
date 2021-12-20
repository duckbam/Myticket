package com.project.myticket.config;

import java.util.Properties;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.JavaMailSenderImpl;

@Configuration
public class MailConfig {
	@Bean
    public static JavaMailSender mailSender() {
		JavaMailSenderImpl jms = new JavaMailSenderImpl();
		jms.setHost("smtp.gmail.com");//google smtp 서버 설정
		jms.setPort(587);//google smtp 메일 서버 포트
		jms.setUsername("ghfkddlaldk@gmail.com");//보내는 계정
		jms.setPassword("dkdks@1223@5325@");
	
		//메일 전달 프로토콜 세부 설정
		Properties prop = new Properties();
		prop.setProperty("mail.transport.protocol", "smtp");
		prop.setProperty("mail.smtp.auth", "true");
		prop.setProperty("mail.smtp.starttls.enable", "true");
		jms.setJavaMailProperties(prop);
	
		return jms;
    }

}