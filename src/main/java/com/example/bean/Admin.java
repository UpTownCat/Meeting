package com.example.bean;

import java.util.List;

public class Admin {
	private int id;
	private int gender;
	private String phone;
	private String password;
	private String name;
	private String photo;
	private List<Notice> notices;
	public Admin() {
		super();
	}
	public Admin(int gender, String phone, String password, String name,
			String photo) {
		super();
		this.gender = gender;
		this.phone = phone;
		this.password = password;
		this.name = name;
		this.photo = photo;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public int getGender() {
		return gender;
	}
	public void setGender(int gender) {
		this.gender = gender;
	}
	public String getPhone() {
		return phone;
	}
	public void setPhone(String phone) {
		this.phone = phone;
	}
	public String getPassword() {
		return password;
	}
	public void setPassword(String password) {
		this.password = password;
	}
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getPhoto() {
		return photo;
	}
	public void setPhoto(String photo) {
		this.photo = photo;
	}
	
	public List<Notice> getNotices() {
		return notices;
	}
	public void setNotices(List<Notice> notices) {
		this.notices = notices;
	}
	@Override
	public String toString() {
		return "Admin [id=" + id + ", gender=" + gender + ", phone=" + phone
				+ ", password=" + password + ", name=" + name + ", photo="
				+ photo + "]";
	}
	
}
