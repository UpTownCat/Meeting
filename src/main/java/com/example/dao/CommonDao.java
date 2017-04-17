package com.example.dao;

import org.apache.ibatis.annotations.Param;

public interface CommonDao {
	void updatePhoto(@Param("id")int id, @Param("table") int table, @Param("photo") String photo);
	void updatePassword(@Param("id")int id, @Param("tag") int tag, @Param("password") String password);
	int selectByPhone(@Param("tag")int tag, @Param("phone")String phone);
	int selectByEmail(@Param("tag")int tag, @Param("email")String email);
	int selectByName(@Param("tag")int tag, @Param("number")String number);
}
