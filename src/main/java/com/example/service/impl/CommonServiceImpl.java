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

}
