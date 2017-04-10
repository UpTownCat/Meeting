package com.example.service;

import java.util.List;

import com.example.bean.Invitation;
import com.example.bean.Page;
import com.example.bean.User;

public interface UserService {
	int addUser(User user);
	int deleteUser(int id);
	int updateUser(User user);
	User selectUserById(int id);
	List<User> selectAllByPage(Page page);
	List<User> selectAll();
	User loginUser(String phone, String password);
	boolean enrollUser(String phone, String password);
	List<Invitation> lookInvitation(int userId);
	List<User> selectUserByDepartmentId(int id);
	String selectUserNameById(int id);
	User selectUserByPhone(String phone);
}
