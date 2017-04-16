package com.example.dao;

import org.apache.ibatis.annotations.Param;

public interface CommonDao {
	void updatePhoto(@Param("id")int id, @Param("table") int table, @Param("photo") String photo);
	void updatePassword(@Param("id")int id, @Param("tag") int tag, @Param("password") String password);
}
