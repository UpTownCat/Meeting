package com.example.dao;

import java.util.Date;
import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.MeetingRoom;
import com.example.bean.Page;

/**
 * @author Administrator
 * 
 */
public interface MeetingRoomDao {
	/**
	 * ���ӻ�����
	 * 
	 * @param meetingRoom
	 * @return ���ݿ��л���������������id
	 */
	int insertMeetingRoom(MeetingRoom meetingRoom);

	/**
	 * ɾ��������
	 * 
	 * @param id
	 * @return
	 */
	int delateMeetingRoom(int id);

	/**
	 * �޸Ļ���������
	 * 
	 * @param meetingRoom
	 * @return
	 */
	int updateMeetingRoom(MeetingRoom meetingRoom);

	/**
	 * ����Id���һ�����
	 * 
	 * @param id
	 * @return
	 */
	MeetingRoom selectMeetingRoomById(int id);

	/**
	 * �������л�����
	 * 
	 * @return
	 */
	MeetingRoom selectMeetingRoomByMeetingId(int id);

	List<MeetingRoom> selectAll();

	List<MeetingRoom> selectAllByCapacity(int capacity);

	List<MeetingRoom> selectAllByPage(Page page);

	List<MeetingRoom> selectAllByCapacityAndDate(
			@Param("capacity") int capacity,
			@Param("startTime") Date startTime, @Param("endTime") Date endTime);
}
