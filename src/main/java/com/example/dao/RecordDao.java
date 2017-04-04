package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Page;
import com.example.bean.Record;

public interface RecordDao {
	int insertRecord(Record record);
	Record selectRecordById(int id);
	List<Record> selectRecordByMeetingId(int id);
	int deleteRecordById(int id);
	List<Record> selectRecordByUserIdByPage(Page page, @Param("userId") int userId);
	void updateRecord(Record record);
}
