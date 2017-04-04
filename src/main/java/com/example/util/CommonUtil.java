package com.example.util;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;
import java.util.Random;

import javax.mail.Address;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.FileUtils;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

/**
 * 工具类
 * @author Administrator
 *
 */
public final class CommonUtil {
	private final static int[] days = {31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31};
	public final static long DAY = 1000 * 60 * 60 * 24;
	public final static long HOUR = 1000 * 60 * 60;
	private static Properties prop = null;
	public final static String getConfigString(String key) {
		if(prop == null) {
			prop = new Properties();
			try {
				prop.load(CommonUtil.class.getResourceAsStream("/config.properties"));
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		return prop.getProperty(key);
	}
	
	/**
	 * 获得这个月总共有多少天
	 * @param year
	 * @param month
	 * @return
	 */
	public final static int getMonthDay(int year, int month) {
		if((year % 4 == 0 && year % 100 != 0) || year % 400 == 0) {
			if(month == 2)
				return 29;
		}
		return days[month - 1];
	}
	
	/**
	 * 获得该天是星期几
	 * @param year
	 * @param month
	 * @param day
	 * @return
	 */
	public final static int getWeekDay(Date date) {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(date);
		int day = calendar.get(Calendar.DAY_OF_WEEK);
		return (day - 1) == 0 ? 7 : (day - 1);
	}
	
	/**
	 * 日期转换为字符串
	 * @param date
	 * @return
	 */
	public final static String dateToString(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		return format.format(date);
	}
	
	public final static String dateToString2(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		return format.format(date);
	}
	
	public final static String dateToString3(Date date) {
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm:ss");
		return format.format(date);
	}
	/**
	 * 字符串转换为日期
	 * @param day
	 * @return
	 * @throws ParseException
	 */
	public final static Date stringToDate(String day) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		return format.parse(day);
	}
	
	public final static Date stringToDate2(String day) throws ParseException {
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
		return format.parse(day);
	}
	
	public final static void sendEmail(String toEmail, String content, JavaMailSender sender) {
		SimpleMailMessage message = new SimpleMailMessage();
		message.setTo(toEmail);
		message.setText(content);
		message.setSubject("会议通知");
		message.setFrom("158668658@qq.com");
		sender.send(message);
	}
	/**
	 * 保存文件
	 * @param file
	 * @param path
	 * @param tag 1 代表 照片， 0 代表文档
	 * @return 文件名
	 */
	public final static String saveFile(MultipartFile file, String path, int tag) {
		String fileName = "default.jpg";
		if(tag == 0) {
			fileName = null;
		}
		if(file != null); {
			int index = file.getOriginalFilename().lastIndexOf(".");
			fileName = System.currentTimeMillis() + new Random().nextInt(1000) + "split_abcd" +  file.getOriginalFilename().substring(index);
		}
		try {
			if (file != null) {
				file.transferTo(new File(CommonUtil
						.getConfigString("photoLocation") + "/" + fileName));
			}
		} catch (IllegalStateException | IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		return fileName;
	}
	
	public final static void writePhoto(String photo, InputStream inputStream, OutputStream outputStream) throws IOException {
		inputStream = FileUtils.openInputStream(new File(CommonUtil.getConfigString("photoLocation") + "/" + photo));
		byte[] buffer = new byte[1024 * 1024 * 10];
		int count = 0;
		while((count = inputStream.read(buffer, 0, buffer.length)) != -1) {
			outputStream.write(buffer, 0, count);
		}
		outputStream.flush();
	}
}
