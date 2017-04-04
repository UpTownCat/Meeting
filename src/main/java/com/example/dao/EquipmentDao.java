package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Equipment;
import com.example.bean.Page;

public interface EquipmentDao {
	int insertEquipment(Equipment equipment);
	int insertRelated(@Param("equipmentId")int equipmentId, @Param("meetingId")int meetingId, @Param("need")int need);
	int deleteEquipment(int id);
	int deleteRelatedEquipment(int meetingId);
	int updateEquipment(Equipment equipment);
	int useEquipment(Equipment equipment);
	Equipment selectEquipmentById(int id);
	List<Equipment> selectAll();
	List<Equipment> selectAllByPage(Page page);
	List<Equipment> selectEquipmentByMeetingId(int id);
}
