package com.example.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Equipment;
import com.example.bean.Invitation;
import com.example.bean.Meeting;
import com.example.bean.Page;
import com.example.dao.MeetingDao;
import com.example.service.EquipmentService;
import com.example.service.InvitatoinService;
import com.example.service.MeetingService;
@Service
public class MeetingServiceImpl implements MeetingService {
	@Autowired
	private MeetingDao meetingDao;
	@Autowired
	private InvitatoinService invitatoinService;
	@Autowired
	private EquipmentService equipmentService;
	@Override
	public int addMeeting(Meeting meeting) {
		// TODO Auto-generated method stub
		return meetingDao.insertMeeting(meeting);
	}

	@Override
	public int deleteMeeting(int id) {
		// TODO Auto-generated method stub
		return meetingDao.deleteMeeting(id);
	}

	@Override
	public int updateMeeting(Meeting meeting) {
		// TODO Auto-generated method stub
		meeting.setIsPass(2);
		List<Equipment> equipments = meeting.getEquipments();
		List<Invitation> invitations = meeting.getInvitations();
		invitatoinService.deleteInvitationByMeetingId(meeting.getId());
		invitatoinService.addInvitations(invitations);
		equipmentService.deleteRelatedEquipment(meeting.getId());
		equipmentService.useEquipments(equipments, meeting.getId());
		return meetingDao.updateMeeting(meeting);
	}

	@Override
	public Meeting selectMeetingById(int id) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingById(id);
	}

	@Override
	public List<Meeting> selectAll() {
		// TODO Auto-generated method stub
		return meetingDao.selectAll();
	}

	@Override
	public List<Meeting> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return meetingDao.selectAllByPage(page);
	}

	@Override
	public int updateMeetingState(int id, int state) {
		// TODO Auto-generated method stub
		return meetingDao.updateMeetingState(id, state);
	}

	@Override
	public List<Meeting> selectMeetingByRoomIdAndDate(int roomId,
			Date startTime, Date endTime, int isPass) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingByRoomIdAndDate(roomId, startTime, endTime, isPass);
	}

	@Override
	public Meeting selectMeetingByDate(Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingByDate(startTime, endTime);
	}

	@Override
	public List<Meeting> selectMeetingByRoomIdAndDate2(int roomId,
			Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingByRoomIdAndDate2(roomId, startTime, endTime);
	}

	@Override
	public List<Meeting> selectMeetingByManagerIdByPage(Page page, int managerId) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingByManagerIdByPage(page, managerId);
	}

	@Override
	public List<Meeting> selectMeetingByRoomIdAndStartTime(int meetingRoomId,
			Date startTime) {
		// TODO Auto-generated method stub
		return meetingDao.selectMeetingByRoomIdAndStartTime(meetingRoomId, startTime);
	}

}
