package com.example.dto;

import java.util.Date;
import java.util.List;

public class DayViewDto extends BasicViewDto {
	private int roomId;
	private String roomNumber;
	private List<MsgDto> msgDtos;

	public String getRoomNumber() {
		return roomNumber;
	}

	public void setRoomNumber(String roomNumber) {
		this.roomNumber = roomNumber;
	}

	public List<MsgDto> getMsgDtos() {
		return msgDtos;
	}

	public void setMsgDtos(List<MsgDto> msgDtos) {
		this.msgDtos = msgDtos;
	}

	public int getRoomId() {
		return roomId;
	}

	public void setRoomId(int roomId) {
		this.roomId = roomId;
	}


}
