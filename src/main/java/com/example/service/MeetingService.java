package com.example.service;

import java.util.Date;
import java.util.List;

import com.example.bean.Meeting;
import com.example.bean.Page;

public interface MeetingService {
	int addMeeting(Meeting meeting);
	int deleteMeeting(int id);
	int updateMeeting(Meeting meeting);
	int updateMeetingState(int id, int state);
	Meeting selectMeetingById(int id);
	List<Meeting> selectAll();
	List<Meeting> selectAllByPage(Page page);
	List<Meeting> selectMeetingByRoomIdAndDate(int roomId, Date startTime, Date endTime, int isPass);
	List<Meeting> selectMeetingByRoomIdAndDate2(int roomId, Date startTime, Date endTime);
	Meeting selectMeetingByDate(Date startTime, Date endTime);
	List<Meeting> selectMeetingByManagerIdByPage(Page page, int managerId);
}	
