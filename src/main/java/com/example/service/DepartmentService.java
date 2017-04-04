package com.example.service;

import java.util.List;

import com.example.bean.Department;
import com.example.bean.Page;

public interface DepartmentService {
	int addDepartment(Department department);
	int deleteDepartment(int id);
	int updateDepartment(Department department);
	Department selectDepartmentById(int id);
	List<Department> selectAllByPage(Page page);
	List<Department> selectAll();
	List<Department> selectAllDepartmentName();
	List<Department> selectAllByCondiction();
}
