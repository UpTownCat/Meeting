package com.example.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Meeting;
import com.example.bean.Page;

public interface MeetingDao {
	int insertMeeting(Meeting meeting);

	int deleteMeeting(int id);

	int updateMeeting(Meeting meeting);

	int updateMeetingState(@Param("id") int id, @Param("state") int state);

	Meeting selectMeetingById(int id);

	List<Meeting> selectAll();

	List<Meeting> selectAllByPage(Page page);
/**
 * ����ͼÿ��ʱ��εĻ�����Ϣ
 * @param meetingRoomId
 * @param startTime
 * @param endTime
 * @return
 */
	List<Meeting> selectMeetingByRoomIdAndDate(
			@Param("meetingRoomId") int meetingRoomId,
			@Param("startTime") Date startTime, @Param("endTime") Date endTime, @Param("isPass")int isPass);
/**
 * ����Ա��˻���ͨ��֮��Ҫ��ȡ��ͻ�Ļ��飬 ���Ҹ���
 * @param meetingRoomId
 * @param startTime
 * @param endTime
 * @return
 */
	List<Meeting> selectMeetingByRoomIdAndDate2(
			@Param("meetingRoomId") int meetingRoomId,
			@Param("startTime") Date startTime, @Param("endTime") Date endTime);
	Meeting selectMeetingByDate(@Param("startTime")Date startTime, @Param("endTime") Date endTime);
	
	List<Meeting> selectMeetingByManagerIdByPage(Page page, @Param("userId")int managerId);
}
