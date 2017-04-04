package com.example.dto;

import java.util.Date;

public class MsgDto {
	private int meetingId;
	private int isEmpty;
	private int avialable;
	private String managerName;
	private String title;
	private String time;
	private Date startTime;
	private Date endTime;
	
	
	public int getMeetingId() {
		return meetingId;
	}

	public void setMeetingId(int meetingId) {
		this.meetingId = meetingId;
	}

	public int getAvialable() {
		return avialable;
	}

	public void setAvialable(int avialable) {
		this.avialable = avialable;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public int getIsEmpty() {
		return isEmpty;
	}
	
	public void setIsEmpty(int isEmpty) {
		this.isEmpty = isEmpty;
	}
	
	public String getManagerName() {
		return managerName;
	}

	public void setManagerName(String managerName) {
		this.managerName = managerName;
	}

	public String getTitle() {
		return title;
	}


	public void setTitle(String title) {
		this.title = title;
	}

	public Date getStartTime() {
		return startTime;
	}

	public void setStartTime(Date startTime) {
		this.startTime = startTime;
	}

	public Date getEndTime() {
		return endTime;
	}

	public void setEndTime(Date endTime) {
		this.endTime = endTime;
	}
	

	public int getAvailable() {
		return avialable;
	}

	public void setAvailable(int avialable) {
		this.avialable = avialable;
	}

	public MsgDto(String managerName, String title, Date startTime, Date endTime) {
		super();
		this.managerName = managerName;
		this.title = title;
		this.startTime = startTime;
		this.endTime = endTime;
	}

	public MsgDto() {
		super();
	}
	
	
}
