package com.example.service.impl;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.example.bean.Department;
import com.example.bean.Page;
import com.example.dao.DepartmentDao;
import com.example.service.DepartmentService;

@Service
public class DepartmentServiceImpl implements DepartmentService {
	@Autowired
	private DepartmentDao departmentDao;
	@Override
	public int addDepartment(Department department) {
		// TODO Auto-generated method stub
		return departmentDao.insertDepartment(department);
	}

	@Override
	public int deleteDepartment(int id) {
		// TODO Auto-generated method stub
		return departmentDao.deleteDepartment(id);
	}

	@Override
	public int updateDepartment(Department department) {
		// TODO Auto-generated method stub
		return departmentDao.updateDepartment(department);
	}

	@Override
	public Department selectDepartmentById(int id) {
		// TODO Auto-generated method stub
		return departmentDao.selectDepartmentById(id);
	}

	@Override
	public List<Department> selectAllByPage(Page page) {
		// TODO Auto-generated method stub
		return departmentDao.selectAllByPage(page);
	}

	@Override
	public List<Department> selectAll() {
		// TODO Auto-generated method stub
		return departmentDao.selectAll();
	}

	@Override
	public List<Department> selectAllDepartmentName() {
		// TODO Auto-generated method stub
		return departmentDao.selectAllDepartmentName();
	}

	@Override
	public List<Department> selectAllByCondiction() {
		// TODO Auto-generated method stub
		return departmentDao.selectAllByCondiction();
	}

}
