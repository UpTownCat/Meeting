package com.example.service.impl;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Invitation;
import com.example.bean.Page;
import com.example.dao.InvitationDao;
import com.example.service.InvitatoinService;
@Service
public class InvitationServiceImpl implements InvitatoinService {
	@Autowired
	private InvitationDao invitationDao;
	@Override
	public void addInvitations(List<Invitation> invitations) {
		// TODO Auto-generated method stub
		invitationDao.insertInvitationBatch(invitations);
	}

	@Override
	public Invitation selectInvitationById(int id) {
		// TODO Auto-generated method stub
		return invitationDao.selectInvitationById(id);
	}

	@Override
	public List<Invitation> selectInvitationByMeetingId(int id) {
		// TODO Auto-generated method stub
		return invitationDao.selectInvitationByMeetingId(id);
	}

	@Override
	public int deleteInvitationByMeetingId(int id) {
		// TODO Auto-generated method stub
		return invitationDao.deleteInvitationByMeetingId(id);
	}

	@Override
	public int deleteInvitation(int id) {
		// TODO Auto-generated method stub
		return invitationDao.deleteInvitation(id);
	}

	@Override
	public Invitation selectInvitationByUserIdAndMeetingId(int userId,
			int meetingId) {
		// TODO Auto-generated method stub
		return invitationDao.selectInvitationByUserIdAndMeetingId(userId, meetingId);
	}

	@Override
	public List<Invitation> selectInvitaionByUserIdByPage(Page page, int userId) {
		// TODO Auto-generated method stub
		return invitationDao.selectInvitationByUserIdByPage(page, userId);
	}

	@Override
	public int updateInvitationState(int id, int state) {
		// TODO Auto-generated method stub
		return invitationDao.updateInvitation(id, state);
	}

	@Override
	public List<Invitation> selectInvitationByUserIdByDate(int userId,
			Date startTime, Date endTime) {
		// TODO Auto-generated method stub
		return invitationDao.selectInvitationByUserIdByDate(userId, startTime, endTime);
	}

}
