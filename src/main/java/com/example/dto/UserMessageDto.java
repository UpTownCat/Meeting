package com.example.dto;

public class UserMessageDto {
	private int id;
	private String name;
	private String phone;
	private String email;
	private int gender;

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getPhone() {
		return phone;
	}

	public void setPhone(String phone) {
		this.phone = phone;
	}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public UserMessageDto(int id, String name, String phone, String email,
			int gender) {
		super();
		this.id = id;
		this.name = name;
		this.phone = phone;
		this.email = email;
		this.gender = gender;
	}

	public UserMessageDto() {
		super();
	}

}
