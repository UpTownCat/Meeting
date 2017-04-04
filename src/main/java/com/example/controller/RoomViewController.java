package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.bean.Meeting;
import com.example.bean.MeetingRoom;
import com.example.bean.Page;
import com.example.dto.DayViewDto;
import com.example.dto.MonthViewDto;
import com.example.dto.MsgDto;
import com.example.dto.WeekViewDto;
import com.example.service.MeetingRoomService;
import com.example.service.MeetingService;
import com.example.util.CommonUtil;

@Controller
@RequestMapping(value="/room")
public class RoomViewController {
	@Autowired
	private MeetingRoomService meetingRoomService;
	@Autowired
	private MeetingService meetingService;
	private final static long DAY = 1000 * 60 * 60 * 24;
	private final static long HOUR = 1000 * 60 * 60;
	private final static String[] TIME = {"上午", "下午", "晚上"};
	
	@RequestMapping(value="/list", method=RequestMethod.GET)
	public String listRoom(Page page, Map<String, Object> map) {
		if(page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<MeetingRoom> rooms = meetingRoomService.selectAllByPage(page);
		map.put("rooms", rooms);
		map.put("page", page);
		map.put("size", rooms.size());
		return "/room/list";
	}
	@RequestMapping(value="/{id}/detail", method=RequestMethod.GET)
	public String getMeetingRoomDetail(@PathVariable Integer id, Map<String, Object> map) {
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(id);
		List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndDate(meetingRoom.getId(), new Date(), new Date(System.currentTimeMillis() + DAY * 7), 1);
		if(meetings.size() > 0) {
			map.put("meetings", meetings);
		}
		map.put("meetingRoom", meetingRoom);
		return "/room/room_detail_admin";
	}
	@RequestMapping(value="/{photo}/photo", method=RequestMethod.GET)
	public void getMeetingRoomPhoto(@PathVariable String photo, HttpServletResponse response) {
		InputStream inputStream = null;
		OutputStream outputStream = null;
		try {
			outputStream = response.getOutputStream();
			CommonUtil.writePhoto(photo, inputStream, outputStream);
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}finally {
			if(outputStream != null) {
				try {
					outputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
			if(inputStream != null) {
				try {
					inputStream.close();
				} catch (IOException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
	}
	
	@RequestMapping(value="/capacity", method=RequestMethod.GET) 
	@ResponseBody
	public int getRoomCapacity(Integer id) {
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(id);
		return meetingRoom.getCapacity();
	}
	
	@RequestMapping(value="/valid", method=RequestMethod.GET)
	@ResponseBody
	public int validateRoom(Integer id, String startTime) {
		System.out.println(startTime);
		System.out.println(id);
		Calendar calendar = Calendar.getInstance();
		int hour = Integer.parseInt(startTime.substring(startTime.length() - 5, startTime.length() - 3));
		String date = startTime.substring(0, 10);
		if(hour < 12) {
			date = date + " 08";
		}else {
			if(hour > 12 && hour < 17) {
				date = date + " 13";
			}else {
				date = date + " 18";
			}
		}
		SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH");
		Date start = null;
		try {
			start = format.parse(date);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndDate(id, start, new Date(start.getTime() + 1000 * 60 * 60 * 4), -1);
		if(meetings == null || meetings.size() == 0) {
			//可用
			return 1;
		}else {
			Meeting meeting = meetings.get(0);
			if(meeting.getIsPass() == 2) {
				//虽然可以用， 已经有了预约， 没审核
				return 2;
			}else {
				if(meeting.getIsPass() == 0) {
					//有会议但审核失败
					return 1;
				}else {
					//有会议且审核通过
					return 0;
				}
			}
		}
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addRoom(String number, Integer capacity, String location, Integer index, MultipartFile photo) {
//		meetingRoomService.addMeetingRoom(room);
		String fileName = CommonUtil.saveFile(photo, CommonUtil.getConfigString("photoLocation"), 1);
		MeetingRoom meetingRoom = new MeetingRoom(capacity, number, location, fileName);
		meetingRoomService.addMeetingRoom(meetingRoom);
		return "redirect:/room/list" + "?index=" + index;
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.GET)
	public String prepareUpdate(@PathVariable Integer id, Map<String, Object> map) {
		map.put("meetingRoom", meetingRoomService.selectMeetingRoomById(id));
		return "/room/update";
	}
	
	@RequestMapping(value="/{id}/update", method=RequestMethod.PUT)
	public String updateRoom(Integer index, MeetingRoom room) {
		meetingRoomService.updateRoom(room);
		return "redirect:/room/list" + "?index=" + index;
	}
	
	@RequestMapping(value="/{id}/delete", method=RequestMethod.DELETE)
	public String deleteRoom(@PathVariable Integer id) {
		meetingRoomService.delateRoom(id);
		return "redirect:/room/list";
	}
	
	@RequestMapping(value="/day/{day}", method=RequestMethod.GET)
	public String getDayView(@PathVariable String day, @RequestParam(value="index", required=false) Integer index, Map<String, Object>map) {
		if(index == null)
			index = 1;
		Page page = new Page();
		page.setIndex(index);
		Date startTime = null;
		try {
			startTime = CommonUtil.stringToDate(day);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		Date endTime = new Date(startTime.getTime() + DAY);
		List<MeetingRoom> meetingRooms = meetingRoomService.selectAllByPage(page);
		List<DayViewDto> dtos = new ArrayList<>();
		for(int i = 0; i < meetingRooms.size(); i++) {
			MeetingRoom meetingRoom = meetingRooms.get(i);
			DayViewDto dto = new DayViewDto();
			List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndDate(meetingRoom.getId(), startTime, endTime, 1);
			List<MsgDto> msgDtos = getMsgDtos(meetings, startTime);
			dto.setRoomNumber(meetingRoom.getNumber());
			dto.setRoomId(meetingRoom.getId());
			dto.setMsgDtos(msgDtos);
			dtos.add(dto);
		}
		int y = Integer.parseInt(day.substring(0, 4));
		int m  = Integer.parseInt(day.substring(4, 6));
		map.put("dtos", dtos);
		map.put("page", page);
		map.put("day", day);
		return "day";
	}
	
	/**
	 * 周视图
	 * @param index
	 * @param day
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/week/{day}", method=RequestMethod.GET)
	public String getWeekView(@RequestParam(value="index", required=false)Integer index, @PathVariable("day") String day, Map<String, Object> map) {
		if(index == null) {
			index = 1;
		}
		Page page = new Page();
		page.setIndex(index);
		Date date = null;
		try {
			date = CommonUtil.stringToDate(day);
		} catch (ParseException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		//num表示该天是星期几
		int num = CommonUtil.getWeekDay(date);
		List<MeetingRoom> meetingRooms = meetingRoomService.selectAllByPage(page);
		List<WeekViewDto> weekViewDtos = new ArrayList<WeekViewDto>();
		for(int i = 0; i < meetingRooms.size(); i++) {
			MeetingRoom meetingRoom = meetingRooms.get(i);
			WeekViewDto weekViewDto = new WeekViewDto();
			weekViewDto.setDayViewDtos(getDayViewDtos(num, date, meetingRoom));
			weekViewDto.setRoomNumber(meetingRoom.getNumber());
			weekViewDtos.add(weekViewDto);
		}
		int y = Integer.parseInt(day.substring(0, 4));
		int m  = Integer.parseInt(day.substring(4, 6));
		String next = getNextString(y, m);
		String previours = getPrevioursString(y, m);
		map.put("page", page);
		map.put("weekViewDtos", weekViewDtos);
		map.put("day", day);
		return "week";
	}
	
	@RequestMapping(value="/month/{month}", method=RequestMethod.GET)
	public String getMonthView(@PathVariable("month") String month, Map<String, Object> map) {
		month = month.substring(0, 6);
		int year = Integer.parseInt(month.substring(0, 4));
		int month1 = Integer.parseInt(month.substring(4, 6));
		int days = CommonUtil.getMonthDay(year, month1);
		List<MonthViewDto> monthViewDtos = new ArrayList<>();
		for(int i = 1; i <= days; i++) {
			String startStr = getDayString(month, i);
			String endStr = getDayString(month, i);
			Date startTime = null;
			Date endTime = null;
			try {
				startTime = CommonUtil.stringToDate(startStr);
				endTime = new Date(startTime.getTime() + DAY);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
			Meeting meeting = meetingService.selectMeetingByDate(startTime, endTime);
			MonthViewDto monthViewDto = new MonthViewDto();
			monthViewDto.setDay(startStr);
			monthViewDto.setIndex(i);
			if(endTime.getTime() < System.currentTimeMillis()) {
				monthViewDto.setAvailable(0);
			}else {
				monthViewDto.setAvailable(1);
			}
			if(meeting.getIsPass() == 0) {
				monthViewDto.setHasMeeting(0);
			}else {
				monthViewDto.setHasMeeting(1);
			}
			monthViewDtos.add(monthViewDto);
		}
		int y = Integer.parseInt(month.substring(0, 4));
		int m  = Integer.parseInt(month.substring(4, 6));
		String next = getNextString(y, m);
		String previours = getPrevioursString(y, m);
		map.put("dtos", monthViewDtos);
		map.put("msg", "Darkstar");
		map.put("day", month + "01");
		return "month";
	}
	
//	@ModelAttribute
//	public Model getRoomModel(Model model, @RequestParam(value="id", required=false)Integer id){
//		if(id != null) {
//			MeetingRoom room = meetingRoomService.selectMeetingRoomById(id);
//			model.addAttribute("room", room);
//		}
//		return model;
//	}
	
	/**
	 * 绑定会议室的早中晚时间段的会议
	 * @param meetingRoom
	 * @param meetings
	 */
	private void bindMeeting(MeetingRoom meetingRoom, List<Meeting> meetings) {
		ArrayList<Date> arrayList = new ArrayList<>();
		for(int i = 0; i < meetings.size(); i++) {
			Meeting meeting = meetings.get(i);
			Date startTime = meeting.getStartTime();
			int hour = startTime.getHours();
			if(hour < 12 ) {
				meetingRoom.setMorning(meeting);
			}else {
				if(hour < 17 && hour > 12) {
					meetingRoom.setAfternoon(meeting);
				}else {
					meetingRoom.setNight(meeting);
				}
			}
			
		}
	}
	
	/**
	 * 获取字符串日期(yyyyMMdd)
	 * @param month
	 * @param day
	 * @return
	 */
	private String getDayString(String month, int day) {
		return month + (day < 10 ? "0" + day : "" + day);
	}
	
	/**
	 * 根据会议的集合获取msgDtos
	 * msgDtos分给早中晚三个时间段的
	 * @param meetings
	 * @return
	 */
	private List<MsgDto> getMsgDtos(List<Meeting> meetings, Date date) {
		List<MsgDto> dtos = new ArrayList<>();
		for(int i = 0; i < 3; i++) {
			MsgDto dto = new MsgDto();
			int isEmpty = 1;
			int available = 0;
			for(int j = 0; j < meetings.size(); j++) {
				Meeting meeting = meetings.get(j);
				Date startTime = meeting.getStartTime();
				int hour = startTime.getHours();
				int start = i * 5 + 8;
				int end = (i + 1) * 5 + 8;
				if(hour < end && hour >= start) {
					isEmpty = 0;
					String managerName = meeting.getManager().getName();
					String title = meeting.getTitle();
					Date startTime2 = meeting.getStartTime();
					Date endTime = meeting.getEndTime();
					dto.setManagerName(managerName);
					dto.setStartTime(startTime2);
					dto.setEndTime(endTime);
					dto.setTitle(title);
					dto.setMeetingId(meeting.getId());
				}
			}
			dto.setIsEmpty(isEmpty);
			if(isEmpty == 1) {
				int total = (8 + i) + (i + 1) * 4;//三个时间段会议的结束时间点
				Date compareDate = new Date(date.getTime() + HOUR * total);
				if(compareDate.getTime() > System.currentTimeMillis())
					available = 1;
			}
			dto.setAvailable(available);
			dto.setTime(TIME[i]);
			dtos.add(dto);
		}
		return dtos;
	}
	
	/**
	 * 获得一组星期的dayViewDto
	 * @param num
	 * @param date
	 * @param meetingRoom
	 * @return
	 */
	private List<DayViewDto> getDayViewDtos(int num, Date date, MeetingRoom meetingRoom) {
		List<DayViewDto> dayViewDtos = new ArrayList<DayViewDto>();
		for(int j = 1; j < 8; j++) {
			DayViewDto dayViewDto = new DayViewDto();
			Date startTime = new Date(date.getTime() + DAY * (j - num));
			Date endTime = new Date(startTime.getTime() + DAY);
			List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndDate(meetingRoom.getId(), startTime, endTime, 1);
			List<MsgDto> msgDtos = getMsgDtos(meetings, startTime);
			int hasMeeting = 0;
			if(meetings.size() != 0) {
				hasMeeting = 1;
			}
			int available = endTime.getTime() < System.currentTimeMillis() ? 0 : 1;
			dayViewDto.setAvailable(available);
			dayViewDto.setHasMeeting(hasMeeting);
			dayViewDto.setMsgDtos(msgDtos);
			dayViewDto.setDay(CommonUtil.dateToString(startTime));
			dayViewDto.setRoomId(meetingRoom.getId());
			dayViewDtos.add(dayViewDto);
		}
		return dayViewDtos;
	}
	
	/**
	 * 获取下一个月第一天的字符串
	 * @param y
	 * @param m
	 * @return
	 */
	private String getNextString(int y, int m) {
		String next = "";
		if(m == 12) {
			next = (y + 1) + "0101" ;
		}else {
			next =y + ((m + 1 ) < 10 ? "0" + (m + 1) : (m + 1) + "") + "01";
		}
		return next;
	}
	
	/**
	 * 获取上一个月的字符串
	 * @param y
	 * @param m
	 * @return
	 */
	private String getPrevioursString(int y, int m) {
		String previours = "";
		if(m == 1) {
			previours = (y - 1) + "1201";
		}else {
			previours = y + ((m - 1) < 10 ? "0" + (m - 1) : (m - 1) + "") + "01";
		}
		return previours;
	}
}
