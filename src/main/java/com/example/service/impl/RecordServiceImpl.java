package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Page;
import com.example.bean.Record;
import com.example.dao.RecordDao;
import com.example.service.RecordService;
@Service
public class RecordServiceImpl implements RecordService {
	@Autowired
	private RecordDao recordDao;
	@Override
	public int addRecord(Record record) {
		// TODO Auto-generated method stub
		return recordDao.insertRecord(record);
	}

	@Override
	public List<Record> selectRecordByMeetingId(int id) {
		// TODO Auto-generated method stub
		return recordDao.selectRecordByMeetingId(id);
	}

	@Override
	public int deleteRecordById(int id) {
		// TODO Auto-generated method stub
		return recordDao.deleteRecordById(id);
	}

	@Override
	public List<Record> selectRecordByUserIdByPage(Page page, int userId) {
		// TODO Auto-generated method stub
		return recordDao.selectRecordByUserIdByPage(page, userId);
	}

	@Override
	public void updateRecord(Integer id, String file) {
		// TODO Auto-generated method stub
		recordDao.updateRecord(id, file);
	}

	@Override
	public Record selectRecordById(int id) {
		// TODO Auto-generated method stub
		return recordDao.selectRecordById(id);
	}

}
