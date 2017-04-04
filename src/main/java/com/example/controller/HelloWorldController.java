package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import jdk.nashorn.internal.runtime.RewriteException;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.bean.User;

@Controller
public class HelloWorldController {
	@RequestMapping("/hello")
	public String hello(){
		
		return "hello";
	}
	@RequestMapping("/test")
	public String test(@RequestParam(value="index", required=false)Integer index, Map<String, Object> map) {
		if(index == null) {
			index = 1;
		}
		map.put("index", index);
		return "test";
	}
	
	public String testEmail() {
		
		return "";
	}
	@RequestMapping(value="testUpload", method=RequestMethod.PUT)
	public void uploadTest(User user, MultipartFile file) {
		System.out.println(user.getName());
		try {
			file.transferTo(new File("F:/template/123.jpg"));
		} catch (IllegalStateException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
	}
	@RequestMapping(value="/testJson", method=RequestMethod.GET, produces="application/json;charset=gbk")
	@ResponseBody
	public Map<String, Object> testJson() {
		Map<String, Object> map = new HashMap<String, Object>();
		List<User> users = new ArrayList<>();
		for(int i = 0; i < 5; i++) {
			User user = new User();
			user.setName("darkstar" + i);
			user.setGender(i % 2);
			users.add(user);
		}
		map.put("users", users);
		return map;
	}
}
