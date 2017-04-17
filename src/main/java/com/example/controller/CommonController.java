package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;

import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.bean.Admin;
import com.example.bean.Manager;
import com.example.bean.Notice;
import com.example.bean.User;
import com.example.dao.CommonDao;
import com.example.service.AdminService;
import com.example.service.CommonService;
import com.example.service.ManagerService;
import com.example.service.NoticeService;
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
	private CommonDao commonDao;
	@Autowired
	private CommonService commonService;
	@Autowired
	private NoticeService noticeSerivce;
	
	@RequestMapping(value="/login", method=RequestMethod.POST)
	public String userLogin(String email, String password, Integer tag, HttpSession session) {
		if(tag == 1) {
			User user = userService.loginUser(email, password);
			if(user != null) {
				session.setAttribute("user", user);
				session.setAttribute("role", 1);
				return "redirect:/meeting/list?state=3";
			}else {
				return "redirect:/";
			}
		}else {
			if(tag == 2) {
				Manager manager = mananManagerService.loginManager(email, password);
				if(manager == null) {
					return "redirect:/";
				}else {
					session.setAttribute("role", 2);
					session.setAttribute("manager", manager);
					return "redirect:/meeting/list?state=3";
				}
			}else {
				Admin admin = adminService.loginAdmin(email, password);
				if(admin == null) {
					return "redirect:/";
				}else {
					session.setAttribute("role", 3);
					session.setAttribute("admin", admin);
					return "redirect:/meeting/list?index=1&searchContent=&appointment=3&state=2&time=0";
				}
			}
		}
	}
	
	@RequestMapping(value="/photo2", method=RequestMethod.POST)
	public String updatePhoto(Integer id, int table, String file, MultipartFile photo) {
		if(photo != null && photo.getOriginalFilename() != null) {
			File f = new File(CommonUtil.getConfigString("photoLocation") + "/" + file);
			if(f.exists()) {
				f.delete();
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
		String url = "redirect:/" + to + id + "/update";
		
		return url;
	}
	/**
	 * 管理员帮员工找回密码
	 * @param id
	 * @param tag
	 * @param password
	 * @return
	 */
	@RequestMapping(value="/resetPassword", method=RequestMethod.POST)
	@ResponseBody
	public int resetPassword(Integer id, Integer tag, String password) {
		commonService.updataPassword(id, tag, password);
		return 1;
	}
	/**
	 * 员工或者部门经理修改密码
	 * @param old
	 * @param new1
	 * @param session
	 * @return
	 */
	@RequestMapping(value="/reset", method=RequestMethod.POST) 
	@ResponseBody
	public int resetCommon(String old, String new1, HttpSession session) {
		User user = (User)session.getAttribute("user");
		if(user == null) {
			user = (User)session.getAttribute("manager");
		}
		String md5 = DigestUtils.md5DigestAsHex(old.getBytes());
		if(!md5.equals(user.getPassword())) {
			return 0;
		}else {
			commonService.updataPassword(user.getId(), Integer.parseInt(session.getAttribute("role").toString()), DigestUtils.md5DigestAsHex(new1.getBytes()));
		}
		return 1;
	}
	
	@RequestMapping(value = "/{photo}/photo")
	public void getPhoto(@PathVariable String photo,
			HttpServletResponse response) {
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
	
	@RequestMapping(value="/md5", method=RequestMethod.POST)
	@ResponseBody
	public String getMd5(String password) {
		System.out.println(password);
		String md5 = DigestUtils.md5DigestAsHex(password.getBytes());
		return md5;
	}
	
	@RequestMapping(value="/notice", method=RequestMethod.POST)
	@ResponseBody
	@Transactional
	public int addNotice(String content) {
		try {
			content = URLDecoder.decode(content, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Notice notice = new Notice(1, content);
		noticeSerivce.updateNotice();
		noticeSerivce.addNotice(notice);
		return 1;
	}
	
	@RequestMapping(value="/notice", method=RequestMethod.GET)
	@ResponseBody
	public Notice getNotice() {
		Notice notice = noticeSerivce.selectNotice();
		return notice;
	}
	
	@RequestMapping(value="/name", method=RequestMethod.GET) 
	@ResponseBody
	public int validateName(int tag, String name) {
		try {
			name = URLDecoder.decode(name, "utf-8");
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return commonService.selectByName(tag, name);
	}
	
	@RequestMapping(value="/email", method=RequestMethod.GET) 
	@ResponseBody
	public int validateEmail(int tag, String email) {
		return commonService.selectByEmail(tag, email);
	}
	
	@RequestMapping(value="/phone", method=RequestMethod.GET) 
	@ResponseBody
	public int validatePhone(int tag, String phone) {
		return commonService.selectByPhone(tag, phone);
	}
	
	
}
