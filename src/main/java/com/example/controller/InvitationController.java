package com.example.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.example.bean.Invitation;
import com.example.bean.Meeting;
import com.example.dto.DayInvitationDto;
import com.example.dto.InvitationDto;
import com.example.dto.ResultDto;
import com.example.dto.UserInvitationDto;
import com.example.service.InvitatoinService;
import com.example.service.UserService;
import com.example.util.CommonUtil;

@Controller
@RequestMapping("/invitation")
public class InvitationController {
	@Autowired
	private InvitatoinService invitationService;
	@Autowired
	private UserService userService;
	
	@RequestMapping(value="/{id}/state", method=RequestMethod.PUT, produces="application/json; charset=gbk")
	@ResponseBody
	public ResultDto updateInvitationState(@PathVariable Integer id, Integer state) {
		ResultDto resultDto = null;
		invitationService.updateInvitationState(id, state);
		return resultDto;
	}
	
	@RequestMapping(value="/recent", method=RequestMethod.GET)
	@ResponseBody
	public List<UserInvitationDto> getInvitationDtos(Integer page, HttpSession session) {
		List<UserInvitationDto> userInvitationDtos = new ArrayList<UserInvitationDto>();
		List<Invitation> invitations = (List<Invitation>)session.getAttribute("invitations");
		int begin = (page - 1) * 6;
		int end = page * 6;
		int size = 0;
		if(invitations != null) {
			size = invitations.size();
		}
		if(end <= size) {
			for(int i = begin; i < end; i++) {
				Invitation invitation = invitations.get(i);
				int userId = invitation.getUser().getId();
				UserInvitationDto userInvitationDto = new UserInvitationDto();
				userInvitationDto.setName(userService.selectUserNameById(userId));
				userInvitationDto.setDayInvitationDtos(getDayInvitationDtos(userId));
				userInvitationDtos.add(userInvitationDto);
			}
		}else {
			if(end > size && size >= begin) {
				for(int i = begin; i < size; i++) {
					Invitation invitation = invitations.get(i);
					int userId = invitation.getUser().getId();
					UserInvitationDto userInvitationDto = new UserInvitationDto();
					userInvitationDto.setName(userService.selectUserNameById(userId));
					userInvitationDto.setDayInvitationDtos(getDayInvitationDtos(userId));
					userInvitationDtos.add(userInvitationDto);
				}
			}
		}
		return userInvitationDtos;
	}
	
//	@RequestMapping(value="/{userId}/recent")
//	@ResponseBody
	public List<DayInvitationDto> getDayInvitationDtos(int userId) {
		List<DayInvitationDto> dayInvitationDtos = new ArrayList<DayInvitationDto>();
		//增加一天
		Date startTime = new Date(System.currentTimeMillis() + CommonUtil.DAY);
		try {
			//将增加的一天时分秒归零
			startTime = CommonUtil.stringToDate(CommonUtil.dateToString(startTime));
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Invitation> invitations = invitationService.selectInvitationByUserIdByDate(userId, startTime, new Date(startTime.getTime() + CommonUtil.DAY * 7));
		for(int i = 0; i < 7; i++) {
			DayInvitationDto dayInvitationDto = new DayInvitationDto();
			Date start0 = new Date(startTime.getTime() + CommonUtil.DAY * i);
			List<InvitationDto> dtos = new ArrayList<InvitationDto>();
			int tag1 = 0;
			for(int j = 0; j < 3; j++) {
				Date start = new Date(start0.getTime() + (8 + j * 5) * CommonUtil.HOUR);
				Date end = new Date(start.getTime() + 4 * CommonUtil.HOUR);
				int tag2 = 0;
				for(int l = 0; l < invitations.size(); l++) {
					Invitation invitation = invitations.get(l);
					Meeting meeting = invitation.getMeeting();
					if(meeting.getStartTime().getTime() > start.getTime() && meeting.getEndTime().getTime() < end.getTime()) {
						tag2 = 1;
						tag1 = 1;
						int id = invitation.getId();
						int isAccess = invitation.getIsAccess();
						String title = invitation.getMeeting().getTitle();
						String managerName = invitation.getMeeting().getManager().getName();
						String number = invitation.getMeeting().getMeetingRoom().getNumber();
						InvitationDto dto = new InvitationDto(id, isAccess, managerName, title, number);
						dto.setTime(j);
						dtos.add(dto);
						break;
					}
				}
				if(tag2 == 0) {
					InvitationDto dto = new InvitationDto();
					dto.setTime(j);
					dtos.add(dto);
				}
				
			}
			if(tag1 == 1) {
				dayInvitationDto.setHasMeeting(1);
				dayInvitationDto.setDtos(dtos);
			}
			dayInvitationDtos.add(dayInvitationDto);
		}
//		for(int i = 0; i < invitations.size(); i++) {
//			Invitation invitation = invitations.get(i);
//			int id = invitation.getId();
//			int isAccess = invitation.getIsAccess();
//			String title = invitation.getMeeting().getTitle();
//			String managerName = invitation.getMeeting().getManager().getName();
//			String number = invitation.getMeeting().getMeetingRoom().getNumber();
//			InvitationDto dto = new InvitationDto(id, isAccess, managerName, title, number);
//			dtos.add(dto);
//		}
//		dtos.add(new InvitationDto());
//		dtos.add(new InvitationDto());
//		dtos.add(new InvitationDto());
		return dayInvitationDtos;
	}
}
