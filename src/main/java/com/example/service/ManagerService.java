package com.example.service;

import java.util.List;

import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.Page;

public interface ManagerService {
	int addManager(Manager manager);
	int deleteManager(int id);
	int updateManager(Manager manager);
	void updateManagerDepartment(int id);
	Manager selectManagerById(int id);
	List<Manager> selectAll();
	List<Manager> selectAllByCondiction();
	List<Manager> selectAllByPage(Page page);
	/**
	 * �ٿ�����
	 * @param meeting
	 * @return
	 */
	int openMeeting(Meeting meeting);
	/**
	 * �鿴����
	 * @param managerId
	 * @return
	 */
	List<Meeting> lookMeeting(int managerId);
	Manager loginManager(String phone, String password);
}
