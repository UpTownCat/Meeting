package com.example.bean;

public class Invitation {
	private int id;
	private int isAccess;
	private int isSend;
	private User user;
	private Meeting meeting;

	public int getIsSend() {
		return isSend;
	}

	public void setIsSend(int isSend) {
		this.isSend = isSend;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIsAccess() {
		return isAccess;
	}

	public void setIsAccess(int isAccess) {
		this.isAccess = isAccess;
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

	@Override
	public String toString() {
		return "Invitation [id=" + id + ", isAccess=" + isAccess + "]";
	}

	public Invitation() {
		super();
	}

	public Invitation(int isAccess, User user, Meeting meeting) {
		super();
		this.isAccess = isAccess;
		this.user = user;
		this.meeting = meeting;
	}

}
