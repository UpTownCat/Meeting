package com.example.dao;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.service.CommonService;

public class CommonDaoTest extends BasicTest{
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private CommonService service;
	
	@Test
	public void selectPhoneTest() {
		int tag = 1;
		String phone = "1234";
		int num = service.selectByPhone(tag, phone);
		logger.info("num = {}", num);
	}
}
