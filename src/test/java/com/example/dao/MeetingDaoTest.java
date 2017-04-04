package com.example.dao;

import java.util.Date;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.MeetingRoom;

public class MeetingDaoTest extends BasicTest {
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Autowired
	private MeetingDao meetingDao;

	@Test
	public void insertMeetingTest() {
		Meeting meeting = new Meeting(2, "年纪大会", null, new Date(), new Date(
				System.currentTimeMillis() + 1000), null, null);
		Manager manager = new Manager();
		MeetingRoom meetingRoom = new MeetingRoom();
		manager.setId(2);
		meetingRoom.setId(1);
		meeting.setManager(manager);
		meeting.setMeetingRoom(meetingRoom);
		int num = meetingDao.insertMeeting(meeting);
		logger.info("num = {}", num);
		logger.info("meeting = {}", meeting);
	}
	
	@Test
	public void selectMeetingByIdTest() {
		int id = 1;
		Meeting meeting = meetingDao.selectMeetingById(id);
		logger.info("meeting = {}", meeting);
		logger.info("room = {}", meeting.getMeetingRoom());
		logger.info("manager = {}", meeting.getManager());
	}
}
