package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Equipment;
import com.example.bean.Page;
import com.example.dao.EquipmentDao;
import com.example.service.EquipmentService;

@Service
public class EquipmentServiceImpl implements EquipmentService{
	@Autowired
	private EquipmentDao equipmentDao;
	@Override
	public int addEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		return equipmentDao.insertEquipment(equipment);
	}

	@Override
	public int deleteEquipment(int id) {
		// TODO Auto-generated method stub
		return equipmentDao.deleteEquipment(id);
	}

	@Override
	public int updateEquipment(Equipment equipment) {
		// TODO Auto-generated method stub
		return equipmentDao.updateEquipment(equipment);
	}

	@Override
	public Equipment selectEquipmentById(int id) {
		// TODO Auto-generated method stub
		return equipmentDao.selectEquipmentById(id);
	}

	@Override
	public List<Equipment> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return equipmentDao.selectAllByPage(page);
	}

	@Override
	public List<Equipment> selectAll() {
		// TODO Auto-generated method stub
		return equipmentDao.selectAll();
	}

	@Override
	public void useEquipments(List<Equipment> equipments, int meetingId) {
		// TODO Auto-generated method stub
		for(int i = 0; i < equipments.size(); i++) {
			Equipment equipment = equipments.get(i);
			if(equipment.getNeed() != 0) {
				equipmentDao.useEquipment(equipment);
				equipmentDao.insertRelated(equipment.getId(), meetingId, equipment.getNeed());
			}
		}
	}

	@Override
	public List<Equipment> selectEquipmentByMeetingId(int id) {
		// TODO Auto-generated method stub
		return equipmentDao.selectEquipmentByMeetingId(id);
	}

	@Override
	public int deleteRelatedEquipment(int meetingId) {
		// TODO Auto-generated method stub
		List<Equipment> equipments = equipmentDao.selectEquipmentByMeetingId(meetingId);
		equipmentDao.deleteRelatedEquipment(meetingId);
		for(int i = 0; i < equipments.size(); i++) {
			Equipment equipment = equipments.get(i);
			equipmentDao.updateEquipment(equipment);
		}
		return 0;
	}

	@Override
	public Equipment selectEquipmentByName(String name) {
		// TODO Auto-generated method stub
		return equipmentDao.selectEquipmentByName(name);
	}

}
