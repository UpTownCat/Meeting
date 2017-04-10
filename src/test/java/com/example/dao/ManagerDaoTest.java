//package com.example.dao;
//
//import org.junit.Test;
//import org.slf4j.Logger;
//import org.slf4j.LoggerFactory;
//import org.springframework.beans.factory.annotation.Autowired;
//
//import com.example.bean.Department;
//import com.example.bean.Manager;
//
//public class ManagerDaoTest extends BasicTest {
//	private Logger logger = LoggerFactory.getLogger(getClass());
//	@Autowired
//	private ManagerDao managerDao;
//	
//	@Test
//	public void insertManagerTest() {
//		Manager manager = new Manager(1, "432423423", "dddd", "Manager-R", null, null);
//		Department department = new Department();
//		department.setId(1);
//		manager.setDepartment(department);
//		int num = managerDao.insertManager(manager);
//		logger.info("num = {}", num);
//		logger.info("manager = {}", manager);
//	}
//}
