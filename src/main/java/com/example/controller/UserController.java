package com.example.controller;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.servlet.ServletContext;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.example.bean.Department;
import com.example.bean.Page;
import com.example.bean.Record;
import com.example.bean.User;
import com.example.service.DepartmentService;
import com.example.service.RecordService;
import com.example.service.UserService;
import com.example.util.CommonUtil;

@Controller
@RequestMapping("/user")
public class UserController {
	@Autowired
	private UserService userService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private RecordService recordService;
	private final static String LIST_URL = "redirect:/user/list";

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listUser(Page page, Map<String, Object> map) {
		if (page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<User> users = userService.selectAllByPage(page);
		List<Department> departments = departmentService
				.selectAllDepartmentName();
		if(users.size() == 0 && page.getTotal() > 1) {
			page.setIndex(page.getTotal());
			users = userService.selectAllByPage(page);
		}
		map.put("departments", departments);
		map.put("users", users);
		map.put("page", page);
		map.put("size", users.size());
		return "/user/list";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String prepareAdd(Map<String, Object> map) {
		map.put("departments", departmentService.selectAllDepartmentName());
		return "/user/user_add_admin";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addUser(String name, String password, String phone,
			String email, @RequestParam(value="gender", required=false)Integer gender, Integer departmentId,
			MultipartFile photo) {
		if(gender == null) {
			gender = 1;
		}
		String fileName = CommonUtil.saveFile(photo, CommonUtil.getConfigString("photoLocation"), 1);
		User user = new User(gender, phone, password, name, fileName, null);
		user.setEmail(email);
		Department department = new Department();
		department.setId(departmentId);
		user.setDepartment(department);
		userService.addUser(user);
		// String index = "";
		// ServletContext context = req.getSession().getServletContext();
		// String realPath = context.getRealPath("/resources/images/");
		// MultipartResolver resolver = new CommonsMultipartResolver(context);
		// if(resolver.isMultipart(req)) {
		// MultipartHttpServletRequest request = resolver.resolveMultipart(req);
		// MultipartFile file = request.getFile("photo");
		// String name = file.getOriginalFilename();
		// String fileName = System.currentTimeMillis() + new
		// Random().nextInt(10000) + name;
		// File f = new File(realPath + fileName);
		// try {
		// file.transferTo(f);
		// } catch (IllegalStateException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// } catch (IOException e) {
		// // TODO Auto-generated catch block
		// e.printStackTrace();
		// }
		// index = request.getParameter("index");
		// User user = getUser(request);
		// user.setPhoto(fileName);
		// userService.addUser(user);
		// }
		return LIST_URL + "?index=" + 1;
	}

	@RequestMapping(value = "/{id}/delete", method = RequestMethod.DELETE)
	public String deleteUser(@PathVariable Integer id) {
		userService.deleteUser(id);
		return LIST_URL;
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String prepareUpdate(@PathVariable Integer id,
			Map<String, Object> map) {
		List<Department> departments = departmentService.selectAll();
		map.put("departments", departments);
		User user = userService.selectUserById(id);
		map.put("user", user);
		return "/user/user_update_admin";
	}

	@RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
	public String getUserDetail(@PathVariable Integer id,
			Map<String, Object> map) {
		User user = userService.selectUserById(id);
		map.put("user", user);
		return "/user/user_detail_admin";
	}

	@RequestMapping(value = "/{photo}/photo")
	public void getUserPhoto(@PathVariable String photo,
			HttpServletResponse response) {
		String photoLocation = CommonUtil.getConfigString("photoLocation");
		FileInputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			inputStream = FileUtils.openInputStream(new File(photoLocation
					+ "/" + photo));
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

	@RequestMapping(value = "/{id}/update", method = RequestMethod.PUT)
	public String updateUser(Integer index, User user) {
		System.out.println(user);
		userService.updateUser(user);
		return LIST_URL + "?index=" + index;
	}

	@RequestMapping(value = "/{id}/department", method = RequestMethod.GET)
	@ResponseBody
	public List<User> getUsers(@PathVariable Integer id) {
		return userService.selectUserByDepartmentId(id);
	}

	/**
	 * 文件上传
	 * 
	 * @param req
	 * @return
	 */
	@RequestMapping(value = "/upload", method = RequestMethod.POST)
	public String uploadDocument(HttpServletRequest req) {
		MultipartResolver resolver = new CommonsMultipartResolver(req
				.getSession().getServletContext());
		MultipartHttpServletRequest request = resolver.resolveMultipart(req);
		MultipartFile document = request.getFile("document");
		if (document != null) {
			String originalFilename = document.getOriginalFilename();
			String realName = System.currentTimeMillis() + ""
					+ new Random().nextInt(1000) + "split" + originalFilename;
			String location = CommonUtil.getConfigString("documentLocation");
			File file = new File(location + realName);
			try {
				document.transferTo(file);
			} catch (IllegalStateException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			int id = Integer.parseInt(request.getParameter("id").toString());
			Record record = new Record();
			record.setId(id);
			record.setFile(realName);
			recordService.updateRecord(record);
		}
		int state = Integer.parseInt(request.getParameter("state").toString());
		String searchContent = request.getParameter("searchContent");
		int time = Integer.parseInt(request.getParameter("time").toString());
		int index = Integer.parseInt(request.getParameter("index").toString());
		Page page = new Page();
		page.setTime(time);
		page.setSearchContent(searchContent);
		page.setState(state);
		page.setIndex(index);
		return "redirect:/meeting/record?" + page;
	}

	/**
	 * 文件下载
	 * 
	 * @param id
	 * @param response
	 * @param session
	 */
	@RequestMapping(value = "/download", method = RequestMethod.GET)
	public void downloadDocument(Integer id, HttpServletResponse response,
			HttpSession session) {
		Record record = recordService.selectRecordById(id);
		String realFile = record.getRealFile();
		response.setCharacterEncoding("gbk");
		try {
			response.setHeader("Content-Disposition",
					"attachment;filename="
							+ new String(record.getFile().getBytes("gbk"),
									"iso-8859-1"));
		} catch (UnsupportedEncodingException e1) {
			// TODO Auto-generated catch block
			e1.printStackTrace();
		}
		FileInputStream inputStream = null;
		ServletOutputStream outputStream = null;
		try {
			inputStream = FileUtils.openInputStream(new File("F:/document/"
					+ realFile));
			outputStream = response.getOutputStream();
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		if (inputStream != null) {
			byte[] buffer = new byte[1024 * 1024];
			int tag = 0;
			try {
				while ((tag = inputStream.read(buffer, 0, buffer.length)) != -1) {
					outputStream.write(buffer, 0, tag);
				}
				outputStream.flush();
				outputStream.close();
				inputStream.close();
			} catch (IOException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}

		}

	}

	// @ModelAttribute
	// public Model bindUser(@RequestParam(value="id", required=false) Integer
	// id, Model model) {
	// if(id != null) {
	// User user = userService.selectUserById(id);
	// model.addAttribute("user", user);
	// }
	// return model;
	// }
	/**
	 * 获取2进制流中的数据邦定到user
	 * 
	 * @param request
	 * @return
	 */
	private User getUser(MultipartHttpServletRequest request) {
		String name = request.getParameter("name");
		String phone = request.getParameter("phone");
		String password = request.getParameter("password");
		int departmentId = Integer.parseInt(request
				.getParameter("departmentId"));
		User user = new User(1, phone, password, name, "", null);
		Department department = new Department();
		department.setId(departmentId);
		;
		user.setDepartment(department);
		return user;
	}
}
