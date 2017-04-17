package com.example.service;

public interface CommonService {
	void updatePhoto(int id, int table, String photo);
	void updataPassword(int id, int tag, String password);
	int selectByName(int tag, String number);
	int selectByPhone(int tag, String phone);
	int selectByEmail(int tag, String email);
}
