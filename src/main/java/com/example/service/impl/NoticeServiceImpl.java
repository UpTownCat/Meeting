package com.example.service.impl;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Notice;
import com.example.dao.NoticeDao;
import com.example.service.NoticeService;
@Service
public class NoticeServiceImpl implements NoticeService {
	@Autowired
	private NoticeDao noticeDao;
	@Override
	public void addNotice(Notice notice) {
		// TODO Auto-generated method stub
		noticeDao.insertNotice(notice);
	}

	@Override
	public void updateNotice() {
		// TODO Auto-generated method stub
		noticeDao.updateNotice();
	}

	@Override
	public Notice selectNotice() {
		// TODO Auto-generated method stub
		return noticeDao.selectNotice();
	}

}
