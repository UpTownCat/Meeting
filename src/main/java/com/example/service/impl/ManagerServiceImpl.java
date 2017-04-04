package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.Page;
import com.example.dao.ManagerDao;
import com.example.service.ManagerService;
@Service
public class ManagerServiceImpl implements ManagerService {
	@Autowired
	private ManagerDao managerDao;
	
	@Override
	public int addManager(Manager manager) {
		// TODO Auto-generated method stub
		return managerDao.insertManager(manager);
	}

	@Override
	public int deleteManager(int id) {
		// TODO Auto-generated method stub
		return managerDao.deleteManager(id);
	}

	@Override
	public int updateManager(Manager manager) {
		// TODO Auto-generated method stub
		return managerDao.updateManager(manager);
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
