package com.example.bean;

import java.util.List;

public class MeetingRoom {
	private int id;
	private int capacity;
	private String number;
	private String location;
	private String photo;
	private Meeting morning;
	private Meeting afternoon;
	private Meeting night;
	private List<Meeting> meetings;
	
	

	public String getPhoto() {
		return photo;
	}

	public void setPhoto(String photo) {
		this.photo = photo;
	}

	public Meeting getMorning() {
		return morning;
	}

	public void setMorning(Meeting morning) {
		this.morning = morning;
	}

	public Meeting getAfternoon() {
		return afternoon;
	}

	public void setAfternoon(Meeting afternoon) {
		this.afternoon = afternoon;
	}

	public Meeting getNight() {
		return night;
	}

	public void setNight(Meeting night) {
		this.night = night;
	}

	public List<Meeting> getMeetings() {
		return meetings;
	}

	public void setMeetings(List<Meeting> meetings) {
		this.meetings = meetings;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public String getLocation() {
		return location;
	}

	@Override
	public String toString() {
		return "MeetingRoom [id=" + id + ", number=" + number + ", location="
				+ location + ", capacity=" + capacity + "]";
	}

	public MeetingRoom() {
		super();
	}

	public MeetingRoom(int capacity, String number, String location, String photo) {
		super();
		this.number = number;
		this.location = location;
		this.capacity = capacity;
		this.photo = photo;
	}

	public void setLocation(String location) {
		this.location = location;
	}

	public int getCapacity() {
		return capacity;
	}

	public void setCapacity(int capacity) {
		this.capacity = capacity;
	}

}
