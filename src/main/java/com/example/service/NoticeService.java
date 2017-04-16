package com.example.service;

import com.example.bean.Notice;

public interface NoticeService {
	void addNotice(Notice notice);
	void updateNotice();
	Notice selectNotice();
}
