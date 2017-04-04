package com.example.basic;

import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.springframework.context.ApplicationContext;
import org.springframework.context.support.ClassPathXmlApplicationContext;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;

import com.example.util.CommonUtil;

public class TestEmail {
	public static void main(String[] args) throws Exception {
		ApplicationContext context = new ClassPathXmlApplicationContext("spring/*.xml");
		JavaMailSender sender = (JavaMailSender) context.getBean("javaMailSender");
		CommonUtil.sendEmail("1347160498@qq.com", "¹þ¹þ¹þ", sender);
		System.out.println("ok");
	}
}
