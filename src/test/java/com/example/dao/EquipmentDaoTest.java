package com.example.dao;

import org.junit.Test;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.Equipment;

public class EquipmentDaoTest extends BasicTest {
	@Autowired
	private EquipmentDao equipmentDao;
	@Test
	public void updateEquipmentTest() {
		Equipment equipment = new Equipment();
		equipment.setCount(100);
		equipment.setId(1);
		equipment.setName("´ó¼¤¹â±Ê");
		equipmentDao.updateEquipment(equipment);
	}
}
