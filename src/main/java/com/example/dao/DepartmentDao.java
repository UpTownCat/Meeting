package com.example.dao;

import java.util.List;

import com.example.bean.Department;
import com.example.bean.Page;

public interface DepartmentDao {
	/**
	 * ���Ӳ���
	 * @param department
	 * @return
	 */
	int insertDepartment(Department department);
	/**
	 * ɾ������
	 * @param id
	 * @return
	 */
	int deleteDepartment(int id);
	/**
	 * ���²���
	 * @param department
	 * @return
	 */
	int updateDepartment(Department department);
	/**
	 * ����id��ѯ����
	 * @param id
	 * @return
	 */
	Department selectDepartmentById(int id);
	/**
	 * ��ѯ˵�в���
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
