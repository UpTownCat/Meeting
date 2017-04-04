package com.example.dao;

import org.apache.ibatis.annotations.Param;

import com.example.bean.Admin;

public interface AdminDao {
	Admin selectAdminByPhoneAndPassword(@Param("phone") String phone, @Param("password") String password);
}
