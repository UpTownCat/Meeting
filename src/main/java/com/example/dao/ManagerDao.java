package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Manager;
import com.example.bean.Page;

public interface ManagerDao {
	int insertManager(Manager manager);
	int deleteManager(int id);
	int updateManager(Manager manager);
	Manager selectManagerById(int id);
	List<Manager> selectAll();
	List<Manager> selectAllByPage(Page page);
	Manager selectManagerByDepartmentId(int id);
	Manager selectManagerByMeetingId(int id);
	Manager selectManagerByPhoneAndPassword(@Param("phone") String phone, @Param("password") String password);
}
