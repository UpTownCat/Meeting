package com.example.dao;

import com.example.bean.Notice;

public interface NoticeDao {
	void insertNotice(Notice notice);
	void updateNotice();
	Notice selectNotice();
}
