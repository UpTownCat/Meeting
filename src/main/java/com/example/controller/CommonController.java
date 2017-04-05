package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.multipart.MultipartFile;

import com.example.bean.Admin;
import com.example.bean.Manager;
import com.example.bean.User;
import com.example.service.AdminService;
import com.example.service.CommonService;
import com.example.service.ManagerService;
import com.example.service.UserService;
import com.example.util.CommonUtil;
@Controller
@RequestMapping("/common")
public class CommonController {
	@Autowired
	private UserService userService;
	@Autowired
	private ManagerService mananManagerService;
	@Autowired
	private AdminService adminService;
	@Autowired
	private CommonService commonService;
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String userLogin(String phone, String password, Integer tag, HttpSession session) {
		if(tag == 1) {
			User user = userService.loginUser(phone, password);
			if(user != null) {
				session.setAttribute("user", user);
				session.setAttribute("role", 1);
				return "redirect:/meeting/list?state=3";
			}else {
				return "redirect:/";
			}
		}else {
			if(tag == 2) {
				Manager manager = mananManagerService.loginManager(phone, password);
				if(manager == null) {
					return "redirect:/";
				}else {
					session.setAttribute("role", 2);
					session.setAttribute("manager", manager);
					return "redirect:/meeting/list?state=3";
				}
			}else {
				Admin admin = adminService.loginAdmin(phone, password);
				if(admin == null) {
					return "redirect:/";
				}else {
					session.setAttribute("role", 3);
					session.setAttribute("admin", admin);
					return "redirect:/meeting/list?state=3";
				}
			}
		}
	}
	
	@RequestMapping(value="/photo2", method=RequestMethod.POST)
	public String updatePhoto(Integer id, int table, String file, int index, MultipartFile photo) {
		if(photo != null && photo.getOriginalFilename() != null) {
			File f = new File(CommonUtil.getConfigString("photoLoattion") + "/" + file);
			if(f.exists()) {
				FileUtils.deleteQuietly(f);
			}
			String fileName = CommonUtil.saveFile(photo, CommonUtil.getConfigString("photoLocation"), 1);
			commonService.updatePhoto(id, table, fileName);
		}
		String to = "user/";
		if(table == 2){
			to = "manager/";
		}
		if(table == 3) {
			to = "room/";
		}
		String url = "redirect:/" + to + id + "/update?index=" + index;
		
		return url;
	}
	
	@RequestMapping(value = "/{photo}/photo")
	public void getPhoto(@PathVariable String photo,
			HttpServletResponse response) {
		try {
			System.out.println(new String(photo.getBytes("iso-8859-1"), "utf-8"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		String photoLocation = CommonUtil.getConfigString("photoLocation");
		FileInputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			File f  = new File(photoLocation+ "/" + photo);
			if(!f.exists())	 {
				return ;
			}
			inputStream = FileUtils.openInputStream(f);
			outputStream = response.getOutputStream();
			byte[] buffer = new byte[1024 * 1024 * 10];
			int count = 0;
			while ((count = inputStream.read(buffer, 0, buffer.length)) != -1) {
				outputStream.write(buffer, 0, count);
			}
			outputStream.flush();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		} finally {
			if (outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if (inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
}
