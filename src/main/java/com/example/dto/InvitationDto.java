package com.example.dto;

public class InvitationDto {
	private int id;
	private int isAccess;
	private String managerName;
	private String title;
	private String number;
	private int time;

	public int getTime() {
		return time;
	}

	public void setTime(int time) {
		this.time = time;
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

	public String getNumber() {
		return number;
	}

	public void setNumber(String number) {
		this.number = number;
	}

	public InvitationDto(int id, int isAccess, String managerName,
			String title, String number) {
		super();
		this.id = id;
		this.isAccess = isAccess;
		this.managerName = managerName;
		this.title = title;
		this.number = number;
	}

	public InvitationDto() {
		super();
	}

}
