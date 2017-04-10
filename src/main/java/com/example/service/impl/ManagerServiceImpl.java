package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.Page;
import com.example.dao.ManagerDao;
import com.example.dao.UserDao;
import com.example.service.ManagerService;
@Service
public class ManagerServiceImpl implements ManagerService {
	@Autowired
	private ManagerDao managerDao;
	@Autowired
	private UserDao userDao;
	
	@Override
	@Transactional
	public int addManager(Manager manager) {
		// TODO Auto-generated method stub
		managerDao.insertManager(manager);
		manager.setPassword(null);
		userDao.insertUser(manager);
		return 1;
	}

	@Override
	@Transactional
	public int deleteManager(int id) {
		// TODO Auto-generated method stub
		Manager manager = managerDao.selectManagerById(id);
		managerDao.deleteManager(id);
		userDao.deleteUserByPhone(manager.getPhone());
		return 1;
	}

	@Override
	@Transactional
	public int updateManager(Manager manager) {
		// TODO Auto-generated method stub
		 managerDao.updateManager(manager);
		 manager.setPassword(null);
		 userDao.updateUser(manager);
		 return 1;
	}

	@Override
	public Manager selectManagerById(int id) {
		// TODO Auto-generated method stub
		return managerDao.selectManagerById(id);
	}

	@Override
	public List<Manager> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return managerDao.selectAllByPage(page);
	}

	@Override
	public int openMeeting(Meeting meeting) {
		// TODO Auto-generated method stub
		return 0;
	}

	@Override
	public List<Meeting> lookMeeting(int managerId) {
		// TODO Auto-generated method stub
		return null;
	}

	@Override
	public List<Manager> selectAll() {
		// TODO Auto-generated method stub
		return managerDao.selectAll();
	}

	@Override
	public Manager loginManager(String phone, String password) {
		// TODO Auto-generated method stub
		return managerDao.selectManagerByPhoneAndPassword(phone, password);
	}

}
