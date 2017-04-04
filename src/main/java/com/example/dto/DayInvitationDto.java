package com.example.dto;

import java.util.List;

public class DayInvitationDto {
	private int hasMeeting;
	private List<InvitationDto> dtos;

	public List<InvitationDto> getDtos() {
		return dtos;
	}

	public void setDtos(List<InvitationDto> dtos) {
		this.dtos = dtos;
	}

	public int getHasMeeting() {
		return hasMeeting;
	}

	public void setHasMeeting(int hasMeeting) {
		this.hasMeeting = hasMeeting;
	}
	
	
	
	
}
