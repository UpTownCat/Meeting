package com.example.basic;

import java.io.File;
import java.io.InputStream;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.Properties;

import javax.mail.Address;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;

import org.apache.commons.io.FileUtils;

import com.example.util.CommonUtil;

public class Test {
	@org.junit.Test
	public void testRecursion() {
		System.out.println(new Date().getHours());
	}
	
	private int f1(int begin, int end) {
		if(end - begin == 1) {
			return begin;
		}
		int  middle = (begin + end) / 2;
		return f1(begin, middle) + f1(middle, end);
	}
	
	private int f2(int n) {
		if(n == 1) {
			return 1;
		}
		return n + f2(n-1);
	}
	
	@org.junit.Test
	public void testString() {
		Calendar calendar = Calendar.getInstance();
		calendar.setTime(new Date());
		int hour = calendar.AM;
		int year = calendar.YEAR;
		int month = calendar.MONTH;
		int day = calendar.DAY_OF_MONTH;
		System.out.println("hour = " + hour + "  year + " + year + "  month = " + month);
		System.out.println("day = " + day);
		System.out.println(new Date().getHours());
	}
	@org.junit.Test
	public void testDay() {
//		int num1 = CommonUtil.getWeekDay(1900, 1, 1);
//		int num2 = CommonUtil.getWeekDay(2017, 3, 19);
//		System.out.println(num1 + "----" + num2);
		Calendar calendar = Calendar.getInstance();
		SimpleDateFormat format = new SimpleDateFormat("yyyyMMdd");
		try {
			calendar.setTime(format.parse("19000101"));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		
		System.out.println(calendar.get(Calendar.DAY_OF_WEEK));
		
	}
	@org.junit.Test
	public void testProperties() throws Exception {
		System.out.println(CommonUtil.getConfigString("photoLocation"));
	}
	@org.junit.Test
	public void deleteFileTest() {
		FileUtils.deleteQuietly(new File("f:/photo/123.txt"));
	}
	
	@org.junit.Test
	public void testDatabase() throws Exception {
		Class.forName("com.mysql.jdbc.Driver");
		Connection conn = DriverManager.getConnection("jdbc:mysql://localhost:3306/meeting_system?useUnicode=true&characterSet=gbk", "root", "root");
		String sql = "select count(*) from (select meeting_id from invitation where user_id = 1) as a join meeting on (a.meeting_id = meeting.id) where 1 = 1 ";
		PreparedStatement ps = conn.prepareStatement(sql);
		ps.setInt(1, 1);
		ResultSet rs = ps.executeQuery();
		rs.next();
		System.out.println(rs.getInt(1));
	}
	
	@org.junit.Test
	public void testSendEmail() throws MessagingException {
		Properties props = new Properties();
		 
	    // 开启debug调试
	    props.setProperty("mail.debug", "true");
	    // 发送服务器需要身份验证
	    props.setProperty("mail.smtp.auth", "true");
	    // 设置邮件服务器主机名
	    props.setProperty("mail.host", "smtp.qq.com");
	    // 发送邮件协议名称
	    props.setProperty("mail.transport.protocol", "smtp");
	 
	    props.put("mail.smtp.ssl.enable", "true");
	 
	    Session session = Session.getInstance(props);
	 
	    Message msg = new MimeMessage(session);
	    msg.setSubject("seenews 错误");
	    StringBuilder builder = new StringBuilder();
	    builder.append("url = " + "http://blog.csdn.net/never_cxb/article/details/50524571");
	    builder.append("\n页面爬虫错误33333");
	    builder.append("\n时间 " + System.currentTimeMillis());
	    msg.setText(builder.toString());
	    msg.setFrom(new InternetAddress("158668658@qq.com"));
	 
	    Transport transport = session.getTransport();
	    transport.connect("smtp.qq.com", "158668658@qq.com", "izrcqqhtkeaobijg");
	 
	    transport.sendMessage(msg, new Address[] { new InternetAddress("1347160498@qq.com") });
	    transport.close();
	}
}
