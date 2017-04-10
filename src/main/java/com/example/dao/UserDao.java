package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Page;
import com.example.bean.User;

public interface UserDao {
	/**
	 * 添加用户
	 * @param user
	 * @return
	 */
	int insertUser(User user);
	/**
	 * 根据Ids删除用户
	 * @param id
	 * @return
	 */
	int deleteUser(int id);
	
	void deleteUserByPhone(String phone);
	/**
	 * 更新用户信息
	 * @param user
	 * @return
	 */
	int updateUser(User user);
	/**
	 * 根据Id查询用户
	 * @param id
	 * @return
	 */
	User selectUserById(int id);
	String selectUserNameById(int id);
	List<User> selectUserByDepartmentId(int id);
	/**
	 * 查询所有用户
	 * @return
	 */
	List<User> selectAll();
	
	List<User> selectAllByPage(Page page);
	User selectUserByPhoneAndPassword(@Param("phone")String phone, @Param("password")String password);
	User selectUserByPhone(String phone);
}
