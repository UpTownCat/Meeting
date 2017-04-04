package com.example.dao;

import java.util.List;

import com.example.bean.Department;
import com.example.bean.Page;

public interface DepartmentDao {
	/**
	 * 增加部门
	 * @param department
	 * @return
	 */
	int insertDepartment(Department department);
	/**
	 * 删除部门
	 * @param id
	 * @return
	 */
	int deleteDepartment(int id);
	/**
	 * 更新部门
	 * @param department
	 * @return
	 */
	int updateDepartment(Department department);
	/**
	 * 根据id查询部门
	 * @param id
	 * @return
	 */
	Department selectDepartmentById(int id);
	/**
	 * 查询说有部门
	 * @param department
	 * @return
	 */
	List<Department> selectAllByPage(Page page);
	
	List<Department> selectAll();
	
	List<Department> selectAllDepartmentName();
	
	List<Department> selectAllByCondiction();
	
	Department selectDepartmentByUserId(int id);
	
	Department selectDepartmentByManagerId(int id);
	
}
