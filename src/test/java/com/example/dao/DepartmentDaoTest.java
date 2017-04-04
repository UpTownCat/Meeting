package com.example.dao;

import org.junit.Test;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;

import com.example.bean.Department;

public class DepartmentDaoTest extends BasicTest{
	@Autowired
	private DepartmentDao departmentDao;
	private Logger logger = LoggerFactory.getLogger(getClass());
	@Test
	public void insertDepartmentTest() {
		Department department = new Department("销售部门", null);
		int num = departmentDao.insertDepartment(department);
		logger.info("num = {}", num);
		logger.info("department = {}", department);
	}
	
	@Test
	public void selectDepartmentByIdTest() {
		int id = 1;
		Department department = departmentDao.selectDepartmentById(id);
		logger.info("department = {}", department);
	}
}
