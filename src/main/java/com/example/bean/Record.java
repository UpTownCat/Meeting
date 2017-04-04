package com.example.bean;

public class Record {
	private int id;
	private String file;
	private User user;
	private Meeting meeting;

	public Record(String file, User user, Meeting meeting) {
		super();
		this.file = file;
		this.user = user;
		this.meeting = meeting;
	}

	public Record() {
		super();
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}
	
	public String getRealFile() {
		return file;
	}

	public String getFile() {
		if(file == null) {
			return null;
		}
		if(file.lastIndexOf("split") == -1) {
			return null;
		}
		return file.substring(file.lastIndexOf("split") + 5);
	}

	public void setFile(String file) {
		this.file = file;
	}

	public User getUser() {
		return user;
	}

	public void setUser(User user) {
		this.user = user;
	}

	public Meeting getMeeting() {
		return meeting;
	}

	public void setMeeting(Meeting meeting) {
		this.meeting = meeting;
	}
}
