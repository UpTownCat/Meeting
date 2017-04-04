package com.example.service;

import java.util.Date;
import java.util.List;

import com.example.bean.Invitation;
import com.example.bean.Page;

public interface InvitatoinService {
	void addInvitations(List<Invitation> invitations);
	int deleteInvitation(int id);
	Invitation selectInvitationById(int id);
	List<Invitation> selectInvitationByMeetingId(int id);
	int deleteInvitationByMeetingId(int id);
	Invitation selectInvitationByUserIdAndMeetingId(int userId, int meetingId);
	List<Invitation> selectInvitaionByUserIdByPage(Page page, int userId);
	List<Invitation> selectInvitationByUserIdByDate(int userId, Date startTime, Date endTime);
	int updateInvitationState(int id, int state);
}
