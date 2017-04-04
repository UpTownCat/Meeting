package com.example.service;

import java.util.Date;
import java.util.List;

import com.example.bean.MeetingRoom;
import com.example.bean.Page;


public interface MeetingRoomService {
	int addMeetingRoom(MeetingRoom room);
	int delateRoom(int id);
	int updateRoom(MeetingRoom room);
	List<MeetingRoom> selectAll();
	List<MeetingRoom> selectAllByCapacity(int capacity);
	List<MeetingRoom> selectAllByPage(Page page);
	MeetingRoom selectMeetingRoomById(int id);
	List<MeetingRoom> selectAllByCapacityAndDate(int capacity, Date startTime, Date endTime);
}
