package com.project.myticket.service;

import javax.mail.internet.MimeMessage;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.mail.javamail.MimeMessageHelper;
import org.springframework.stereotype.Service;

@Service
public class MailService {
    @Autowired
    private JavaMailSender mailSender;

    public void sendMail(String to, String subject, String body) {
		MimeMessage message = mailSender.createMimeMessage();
		try {
		    MimeMessageHelper messageHelper = 
				new MimeMessageHelper(message,true,"UTF-8");
		    messageHelper.setSubject(subject);//제목
		    messageHelper.setTo(to); // 수신자
		    messageHelper.setText(body);//내용
		    mailSender.send(message);
		}catch(Exception e) {
		    e.printStackTrace();
		}
    }
}
