package com.example.bean;

import java.util.Date;

public class Notice {
	private int id;
	private int isShow;
	private Date time;
	private Admin admin;

	public Notice() {
		super();
	}

	public Notice(int isShow, Date time, Admin admin) {
		super();
		this.isShow = isShow;
		this.time = time;
		this.admin = admin;
	}

	@Override
	public String toString() {
		return "Notice [id=" + id + ", isShow=" + isShow + ", time=" + time
				+ "]";
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getIsShow() {
		return isShow;
	}

	public void setIsShow(int isShow) {
		this.isShow = isShow;
	}

	public Date getTime() {
		return time;
	}

	public void setTime(Date time) {
		this.time = time;
	}

	public Admin getAdmin() {
		return admin;
	}

	public void setAdmin(Admin admin) {
		this.admin = admin;
	}

}
