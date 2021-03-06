package com.example.service.impl;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.dao.CommonDao;
import com.example.service.CommonService;
@Service
public class CommonServiceImpl implements CommonService {
	@Autowired
	private CommonDao commonDao;
	
	@Override
	public void updatePhoto(int id, int table, String photo) {
		// TODO Auto-generated method stub
		commonDao.updatePhoto(id, table, photo);
	}

	@Override
	public void updataPassword(int id, int tag, String password) {
		// TODO Auto-generated method stub
		commonDao.updatePassword(id, tag, password);
	}

	@Override
	public int selectByName(int tag, String number) {
		// TODO Auto-generated method stub
		return commonDao.selectByName(tag, number);
	}

	@Override
	public int selectByPhone(int tag, String phone) {
		// TODO Auto-generated method stub
		return commonDao.selectByPhone(tag, phone);
	}

	@Override
	public int selectByEmail(int tag, String email) {
		// TODO Auto-generated method stub
		return commonDao.selectByEmail(tag, email);
	}

}
