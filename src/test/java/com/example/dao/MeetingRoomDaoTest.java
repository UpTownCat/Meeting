package com.example.dao;

import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.MeetingRoom;
import com.example.bean.Page;

public class MeetingRoomDaoTest extends BasicTest {
	@Autowired
	private MeetingRoomDao meetingRoomDao;
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Test
	public void insertMeetingRoomTest() {
		MeetingRoom meetingRoom = new MeetingRoom( 100, "2-201", "9¹«Ô¢¶þÂ¥", null);
		int num = meetingRoomDao.insertMeetingRoom(meetingRoom);
		logger.info("num = {}", num);
		logger.info("meetingRoom = {}", meetingRoom);
	}
	
	@Test
	public void updateMeetingRoomTest() {
		MeetingRoom meetingRoom = new MeetingRoom(100, "2-201", "9¹«Ô¢66Â¥", null);
		meetingRoom.setId(3);
		int num = meetingRoomDao.updateMeetingRoom(meetingRoom);
		logger.info("num = {}", num);
		
	}
	
	@Test
	public void selectMeetingRoomByIdTest() {
		int id = 1;
		MeetingRoom room = meetingRoomDao.selectMeetingRoomById(id);
		logger.info("room = {}", room);
	}
	
	@Test
	public void selectAllTest() {
		List<MeetingRoom> all = meetingRoomDao.selectAll();
		logger.info("all = {}", all);
	}
	
	@Test
	public void selectAllByPageTest() {
		Page page = new Page();
		page.setIndex(1);
		List<MeetingRoom> all = meetingRoomDao.selectAllByPage(page);
		logger.info("all = {}" , all);
	}
}
