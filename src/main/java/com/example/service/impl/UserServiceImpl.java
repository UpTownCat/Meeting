package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Invitation;
import com.example.bean.Page;
import com.example.bean.User;
import com.example.dao.UserDao;
import com.example.service.UserService;

@Service
public class UserServiceImpl implements UserService {
	@Autowired
	private UserDao userDao;
	@Override
	public int addUser(User user) {
		// TODO Auto-generated method stub
		return userDao.insertUser(user);
	}

	@Override
	public int deleteUser(int id) {
		// TODO Auto-generated method stub
		return userDao.deleteUser(id);
	}

	@Override
	public int updateUser(User user) {
		// TODO Auto-generated method stub
		return userDao.updateUser(user);
	}

	@Override
	public User selectUserById(int id) {
		// TODO Auto-generated method stub
		return userDao.selectUserById(id);
	}

	@Override
	public List<User> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return userDao.selectAllByPage(page);
	}

	@Override
	public List<User> selectAll() {
		// TODO Auto-generated method stub
		return userDao.selectAll();
	}

	@Override
	public User loginUser(String phone, String password) {
		// TODO Auto-generated method stub
		User user = userDao.selectUserByPhoneAndPassword(phone, password);
		return user;
	}

	@Override
	public boolean enrollUser(String phone, String password) {
		// TODO Auto-generated method stub
		return false;
	}

	@Override
	public List<Invitation> lookInvitation(int userId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<User> selectUserByDepartmentId(int id) {
		// TODO Auto-generated method stub
		return userDao.selectUserByDepartmentId(id);
	}

	@Override
	public String selectUserNameById(int id) {
		// TODO Auto-generated method stub
		return userDao.selectUserNameById(id);
	}

	@Override
	public User selectUserByPhone(String phone) {
		// TODO Auto-generated method stub
		return userDao.selectUserByPhone(phone);
	}

}
