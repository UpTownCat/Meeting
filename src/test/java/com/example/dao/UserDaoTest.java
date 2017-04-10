package com.example.dao;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.Department;
import com.example.bean.User;

public class UserDaoTest extends BasicTest {
	@Autowired
	private UserDao userDao;
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Test
	public void insertUserTest() {
		User user = new User(1, "33334444", "3423", "DropDown", null, null);
		Department department = new Department();
		department.setId(1);
		user.setDepartment(department);
		int num = userDao.insertUser(user);
		logger.info("num = {}", num);
		logger.info("user = {}", user);
	}
	
	@Test
	public void selectUserByIdTest() {
		int id = 34;
		User user = userDao.selectUserById(id);
		System.out.println(user.getPassword() == null);
		
	}
	
	@Test
	public void userLoginTest() {
		String phone = "1234";
		User user = userDao.selectUserByPhone(phone);
		System.out.println(user);
	}
}
