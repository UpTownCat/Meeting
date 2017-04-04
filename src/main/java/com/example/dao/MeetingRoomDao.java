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
	 * 增加会议室
	 * 
	 * @param meetingRoom
	 * @return 数据库中会议室自增主键的id
	 */
	int insertMeetingRoom(MeetingRoom meetingRoom);

	/**
	 * 删除会议室
	 * 
	 * @param id
	 * @return
	 */
	int delateMeetingRoom(int id);

	/**
	 * 修改会议室属性
	 * 
	 * @param meetingRoom
	 * @return
	 */
	int updateMeetingRoom(MeetingRoom meetingRoom);

	/**
	 * 根据Id查找会议室
	 * 
	 * @param id
	 * @return
	 */
	MeetingRoom selectMeetingRoomById(int id);

	/**
	 * 查找所有会议室
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
