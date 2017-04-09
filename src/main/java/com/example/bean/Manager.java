package com.example.bean;

public class Manager {
	private int id;
	private int gender;
	private String phone;
	private String email;
	private String password;
	private String name;
	private String photo;
	private Department department;

	
	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public int getGender() {
		return gender;
	}

	public void setGender(int gender) {
		this.gender = gender;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
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

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Department getDepartment() {
		return department;
	}

	public void setDepartment(Department department) {
		this.department = department;
	}

	public Manager(int gender, String phone, String password, String name, String photo, String email,
			Department department) {
		super();
		this.phone = phone;
		this.password = password;
		this.name = name;
		this.gender = gender;
		this.photo = photo;
		this.email = email;
		this.department = department;
	}

	public Manager() {
		super();
	}

	@Override
	public String toString() {
		return "Manager [id=" + id + ", gender=" + gender + ", phone=" + phone
				+ ", password=" + password + ", name=" + name + ", photo="
				+ photo + ", department=" + department + "]";
	}
}
