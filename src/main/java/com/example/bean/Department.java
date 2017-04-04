package com.example.bean;

import java.util.List;

public class Department {
	private int id;
	private int size;
	private String name;
	private Manager manager;
	private List<User> users;

	
	public int getSize() {
		if(users == null) 
			return 0;
		return users.size();
	}

	public void setSize(int size) {
		this.size = size;
	}

	public List<User> getUsers() {
		return users;
	}

	public void setUsers(List<User> users) {
		this.users = users;
	}

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

	public Manager getManager() {
		return manager;
	}

	public void setManager(Manager manager) {
		this.manager = manager;
	}

	public Department(String name, Manager manager) {
		super();
		this.name = name;
		this.manager = manager;
	}

	public Department() {
		super();
	}

	@Override
	public String toString() {
		return "Department [id=" + id + ", name=" + name + "]";
	}

}
