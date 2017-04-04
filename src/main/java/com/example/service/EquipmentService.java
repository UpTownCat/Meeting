package com.example.service;

import java.util.List;

import com.example.bean.Equipment;
import com.example.bean.Meeting;
import com.example.bean.Page;

public interface EquipmentService {
	int addEquipment(Equipment equipment);
	int deleteEquipment(int id);
	int deleteRelatedEquipment(int meetingId);
	int updateEquipment(Equipment equipment);
	Equipment selectEquipmentById(int id);
	List<Equipment> selectAll();
	List<Equipment> selectAllByPage(Page page);
	void useEquipments(List<Equipment> equipments, int meetingId);
	List<Equipment> selectEquipmentByMeetingId(int id);
}
