package com.example.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Admin;
import com.example.dao.AdminDao;
import com.example.service.AdminService;
@Service
public class AdminServiceImpl implements AdminService{
	@Autowired
	private AdminDao adminDao;
	@Override
	public Admin loginAdmin(String phone, String password) {
		// TODO Auto-generated method stub
		return adminDao.selectAdminByPhoneAndPassword(phone, password);
	}

}
