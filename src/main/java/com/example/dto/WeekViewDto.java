package com.example.dto;

import java.util.List;

public class WeekViewDto extends BasicViewDto {
	private String roomNumber;
	private List<DayViewDto> dayViewDtos;

	public List<DayViewDto> getDayViewDtos() {
		return dayViewDtos;
	}

	public void setDayViewDtos(List<DayViewDto> dayViewDtos) {
		this.dayViewDtos = dayViewDtos;
	}

	public String getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

}
