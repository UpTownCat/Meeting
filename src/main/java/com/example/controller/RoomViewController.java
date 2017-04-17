package com.example.controller;

import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.example.bean.Invitation;
import com.example.bean.Meeting;
import com.example.bean.MeetingRoom;
import com.example.bean.Page;
import com.example.bean.Record;
import com.example.dto.DayViewDto;
import com.example.dto.MonthViewDto;
import com.example.dto.MsgDto;
import com.example.dto.WeekViewDto;
import com.example.service.InvitatoinService;
import com.example.service.MeetingRoomService;
import com.example.service.MeetingService;
import com.example.service.RecordService;
import com.example.util.CommonUtil;

@Controller
@RequestMapping(value="/room")
public class RoomViewController {
	@Autowired
	private MeetingRoomService meetingRoomService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private InvitatoinService invitatoinService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private JavaMailSender sender;
	private final static long DAY = 1000 * 60 * 60 * 24;
	private final static long HOUR = 1000 * 60 * 60;
	private final static String[] TIME = {"����", "����", "����"};
	
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
	
	@RequestMapping(value="/capacity", method=RequestMethod.GET) 
	@ResponseBody
	public int getRoomCapacity(Integer id) {
		MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(id);
		return meetingRoom.getCapacity();
	}
	
	@RequestMapping(value="/valid", method=RequestMethod.GET)
	@ResponseBody
	public int validateRoom(Integer id, String startTime, int meetingId) {
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
			//����
			return 1;
		}else {
			Meeting meeting = meetings.get(0);
			if(meeting.getIsPass() == 2) {
				//��Ȼ�����ã� �Ѿ�����ԤԼ�� û���
				return 2;
			}else {
				if(meeting.getIsPass() == 0) {
					//�л��鵫���ʧ��
					return 1;
				}else {
					//�л��������ͨ��
					if(meetingId != 0 && meetingId == meeting.getId()) {
						return 1;
					}
					return 0;
				}
			}
		}
	}
	
	@RequestMapping(value="/add", method=RequestMethod.GET)
	public String prepareAdd() {
		return "/room/room_add_admin";
	}
	
	@RequestMapping(value="/add", method=RequestMethod.POST)
	public String addRoom(String number, Integer capacity, String location, MultipartFile photo) {
		String fileName = CommonUtil.saveFile(photo, CommonUtil.getConfigString("photoLocation"), 1);
		MeetingRoom meetingRoom = new MeetingRoom(capacity, number, location, fileName);
		meetingRoomService.addMeetingRoom(meetingRoom);
		return "redirect:/room/list";
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
	@Transactional
	public String deleteRoom(@PathVariable Integer id) {
		meetingRoomService.delateRoom(id);
		List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndStartTime(id, new Date());
		if(!meetings.isEmpty()) {
			for(int i = 0; i < meetings.size(); i++) {
				Meeting meeting = meetings.get(i);
				meetingService.updateMeetingState(meeting.getId(), 0);
				CommonUtil.sendEmail(meeting.getManager().getEmail(), "���ڻ����ұ�ɾ����������Ϊ << "  + meeting.getTitle() + " >>�Ļ���ԤԼʧ�ܣ�", sender);
				if(meeting.getIsPass() == 1) {
					List<Invitation> invitations = invitatoinService.selectInvitationByMeetingId(meeting.getId());
					List<Record> records = recordService.selectRecordByMeetingId(meeting.getId());
					if(invitations != null) {
						for(int j = 0; j < invitations.size(); j++) {
							Invitation invitation = invitations.get(j);
							CommonUtil.sendEmail(invitation.getUser().getEmail(), "����Ϊ<< " + meeting.getTitle() + " >>�Ļ����Ѿ�ȡ����", sender);
						}
					}
					if(records != null) {
						for(int j = 0; j < records.size(); j++) {
							Record record = records.get(j);
							CommonUtil.sendEmail(record.getUser().getEmail(), "����Ϊ<< " + meeting.getTitle() + " >>�Ļ����Ѿ�ȡ�����������������¼", sender);
							
						}
					}
				}
			}
		}
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
		map.put("dtos", dtos);
		map.put("page", page);
		map.put("day", day);
		return "day";
	}
	
	/**
	 * ����ͼ
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
		//num��ʾ���������ڼ�
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
	 * ��ȡ�ַ�������(yyyyMMdd)
	 * @param month
	 * @param day
	 * @return
	 */
	private String getDayString(String month, int day) {
		return month + (day < 10 ? "0" + day : "" + day);
	}
	
	/**
	 * ���ݻ���ļ��ϻ�ȡmsgDtos
	 * msgDtos�ָ�����������ʱ��ε�
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
				int total = (8 + i) + (i + 1) * 4;//����ʱ��λ���Ľ���ʱ���
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
	 * ���һ�����ڵ�dayViewDto
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
	 * ��ȡ��һ���µ�һ����ַ���
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
	 * ��ȡ��һ���µ��ַ���
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
