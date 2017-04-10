package com.example.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Page;
import com.example.bean.User;

public interface UserDao {
	/**
	 * ����û�
	 * @param user
	 * @return
	 */
	int insertUser(User user);
	/**
	 * ����Idsɾ���û�
	 * @param id
	 * @return
	 */
	int deleteUser(int id);
	
	void deleteUserByPhone(String phone);
	/**
	 * �����û���Ϣ
	 * @param user
	 * @return
	 */
	int updateUser(User user);
	/**
	 * ����Id��ѯ�û�
	 * @param id
	 * @return
	 */
	User selectUserById(int id);
	String selectUserNameById(int id);
	List<User> selectUserByDepartmentId(int id);
	/**
	 * ��ѯ�����û�
	 * @return
	 */
	List<User> selectAll();
	
	List<User> selectAllByPage(Page page);
	User selectUserByPhoneAndPassword(@Param("phone")String phone, @Param("password")String password);
	User selectUserByPhone(String phone);
}
