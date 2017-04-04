package com.example.dao;

import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.Page;
import com.example.bean.Record;


public class RecordDaoTest extends BasicTest{
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private RecordDao recordDao;
	@Test
	public void selectRecordByUserIdByPageTest() {
		int userId = 1;
		Page page = new Page();
		page.setIndex(1);
		page.setSize(6);
		List<Record> records = recordDao.selectRecordByUserIdByPage(page, userId);
		logger.info("records = {}", records);
	}
}
