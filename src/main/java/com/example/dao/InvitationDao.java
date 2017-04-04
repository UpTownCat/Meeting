package com.example.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Invitation;
import com.example.bean.Page;

public interface InvitationDao {
	int insertInvitationBatch(@Param("list") List<Invitation> invitations);

	int deleteInvitation(int id);

	int deleteInvitationByMeetingId(int id);

	int updateInvitation(@Param("id") int id, @Param("state") int state);

	Invitation selectInvitationById(int id);

	List<Invitation> selectInvitationByMeetingId(int id);

	List<Invitation> selectInvitationByUserIdByPage(Page page,
			@Param("userId") int userId);

	List<Invitation> selectInvitationByUserIdByDate(
			@Param("userId") int userId, @Param("startTime") Date startTime,
			@Param("endTime") Date endTime);

	Invitation selectInvitationByUserIdAndMeetingId(
			@Param("userId") int userId, @Param("meetingId") int meetingId);

}
