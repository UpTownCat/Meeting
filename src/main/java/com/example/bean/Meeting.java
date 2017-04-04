package com.example.bean;

import java.util.Date;
import java.util.List;

public class Meeting {
	private int id;
	private int isPass;
	private int open;
	private String title;
	private Date appointmentTime;
	private Date startTime;
	private Date endTime;
	private Manager manager;
	private MeetingRoom meetingRoom;
	private List<Record> records;
	private List<Invitation> invitations;
	private List<Equipment> equipments;
	public Meeting() {
		super();
	}
	public Meeting(int isPass, String title, Date appointmentTime, Date startTime,
			Date endTime, Manager manager, MeetingRoom meetingRoom) {
		super();
		this.title = title;
		this.appointmentTime = appointmentTime;
		this.startTime = startTime;
		this.endTime = endTime;
		this.isPass = isPass;
		this.manager = manager;
		this.meetingRoom = meetingRoom;
	}
	
	
	
	public int getOpen() {
		return getStartTime().getTime() > new Date().getTime() ? 0 : 1;
	}
	public void setOpen(int open) {
		this.open = open;
	}
	public int getId() {
		return id;
	}
	public void setId(int id) {
		this.id = id;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public Date getAppointmentTime() {
		return appointmentTime;
	}
	public void setAppointmentTime(Date appointmentTime) {
		this.appointmentTime = appointmentTime;
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
	public int getIsPass() {
		return isPass;
	}
	public void setIsPass(int isPass) {
		this.isPass = isPass;
	}
	public Manager getManager() {
		return manager;
	}
	public void setManager(Manager manager) {
		this.manager = manager;
	}
	public MeetingRoom getMeetingRoom() {
		return meetingRoom;
	}
	public void setMeetingRoom(MeetingRoom meetingRoom) {
		this.meetingRoom = meetingRoom;
	}
	public List<Record> getRecords() {
		return records;
	}
	public void setRecords(List<Record> records) {
		this.records = records;
	}
	public List<Invitation> getInvitations() {
		return invitations;
	}
	public void setInvitations(List<Invitation> invitations) {
		this.invitations = invitations;
	}
	public List<Equipment> getEquipments() {
		return equipments;
	}
	public void setEquipments(List<Equipment> equipments) {
		this.equipments = equipments;
	}
	@Override
	public String toString() {
		return "Meeting [id=" + id + ", isPass=" + isPass + ", title=" + title
				+ ", appointmentTime=" + appointmentTime + ", startTime="
				+ startTime + ", endTime=" + endTime + "]";
	}
	
	
}
