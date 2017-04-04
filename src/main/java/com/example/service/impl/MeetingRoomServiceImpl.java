package com.example.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.MeetingRoom;
import com.example.bean.Page;
import com.example.dao.MeetingRoomDao;
import com.example.service.MeetingRoomService;
@Service
public class MeetingRoomServiceImpl implements MeetingRoomService {
	@Autowired
	private MeetingRoomDao meetingRoomDao;
	@Override
	public List<MeetingRoom> selectAll() {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectAll();
	}

	@Override
	public MeetingRoom selectMeetingRoomById(int id) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectMeetingRoomById(id);
	}

	@Override
	public int addMeetingRoom(MeetingRoom room) {
		// TODO Auto-generated method stub
		return meetingRoomDao.insertMeetingRoom(room);
	}

	@Override
	public int delateRoom(int id) {
		// TODO Auto-generated method stub
		return meetingRoomDao.delateMeetingRoom(id);
	}

	@Override
	public int updateRoom(MeetingRoom room) {
		// TODO Auto-generated method stub
		return meetingRoomDao.updateMeetingRoom(room);
	}

	@Override
	public List<MeetingRoom> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectAllByPage(page);
	}

	@Override
	public List<MeetingRoom> selectAllByCapacity(int capacity) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectAllByCapacity(capacity);
	}

	@Override
	public List<MeetingRoom> selectAllByCapacityAndDate(int capacity,
			Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return meetingRoomDao.selectAllByCapacityAndDate(capacity, startTime, endTime);
	}

}
