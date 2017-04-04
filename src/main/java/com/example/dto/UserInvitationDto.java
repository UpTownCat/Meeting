package com.example.dto;

import java.util.List;

public class UserInvitationDto {
	private String name;
	private List<DayInvitationDto> dayInvitationDtos;

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public List<DayInvitationDto> getDayInvitationDtos() {
		return dayInvitationDtos;
	}

	public void setDayInvitationDtos(List<DayInvitationDto> dayInvitationDtos) {
		this.dayInvitationDtos = dayInvitationDtos;
	}

}
