package com.example.service;

import java.util.List;

import com.example.bean.Page;
import com.example.bean.Record;

public interface RecordService {
	int addRecord(Record reocrd);
	Record selectRecordById(int id);
	List<Record> selectRecordByMeetingId(int id);
	int deleteRecordById(int id);
	List<Record> selectRecordByUserIdByPage(Page page, int userId);
	void updateRecord(Integer id, String file);
}
