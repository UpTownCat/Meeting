package com.example.dao;

import java.util.ArrayList;
import java.util.List;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.transaction.annotation.Transactional;

import com.example.bean.Invitation;
import com.example.bean.Meeting;
import com.example.bean.Page;
import com.example.bean.User;

public class InvitationDaoTest extends BasicTest {
	@Autowired
	private InvitationDao invitationDao;
	private Logger logger = LoggerFactory.getLogger(getClass());
	
	@Test
	@Transactional
	public void insertInvitationBatch() {
		List<Invitation> invitations = new ArrayList<>();
		Invitation invitation = new Invitation();
		User user = new User();
		user.setId(1);
		Meeting meeting = new Meeting();
		meeting.setId(1);
		invitation.setUser(user);
		invitation.setMeeting(meeting);
		invitations.add(invitation);
		Invitation invitation2 = new Invitation();
		User user2 = new User();
		user2.setId(2);
		invitation2.setUser(user2);
		invitation2.setMeeting(meeting);
		invitations.add(invitation2);
		invitationDao.insertInvitationBatch(invitations);
		for(int i = 0; i < invitations.size(); i++) {
			logger.info("invitation = {}", invitations.get(i));
		}
	}
	
	@Test
	public void getInvitationTest() {
		Page page = new Page();
		page.setIndex(1);
		List<Invitation> invitations = invitationDao.selectInvitationByUserIdByPage(page, 1);
		System.out.println(invitations.size());
	}
}
