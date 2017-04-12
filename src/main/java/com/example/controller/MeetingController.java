package com.example.controller;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.MailSender;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.example.bean.Department;
import com.example.bean.Invitation;
import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.Page;
import com.example.bean.Record;
import com.example.bean.User;
import com.example.dto.ResultDto;
import com.example.service.DepartmentService;
import com.example.service.EquipmentService;
import com.example.service.InvitatoinService;
import com.example.service.MeetingService;
import com.example.service.RecordService;
import com.example.service.UserService;
import com.example.util.CommonUtil;

@Controller
@RequestMapping("/meeting")
public class MeetingController {
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private InvitatoinService invitatoinService;
	@Autowired
	private UserService userService;
	@Autowired
	private EquipmentService equipmentService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private JavaMailSender sender;
	private final static String LIST_URL = "redirect:/meeting/list";
	private final static long HOUR = 1000 * 60 * 60;

	/**
	 * 查看所有会议信息
	 * 
	 * @param index
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listMeeting(Page page, Map<String, Object> map, HttpSession session) {
		String role = session.getAttribute("role").toString();
		if (page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<Meeting> meetings = meetingService.selectAllByPage(page);
		if(meetings.size() == 0) {
			if(page.getTotal() != 0) {
				meetings = meetingService.selectAllByPage(page);
			}
		}
		map.put("meetings", meetings);
		map.put("page", page);
		if(role.equals("3")){
			return "meeting/list_admin";
		}else {
			return "meeting/list";
		}
	}
	/**
	 * 查看会议
	 * @param page
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/mine", method=RequestMethod.GET)
	public String mineMeeting(Page page, HttpSession session, Map<String, Object> map) {
		String role = session.getAttribute("role").toString();
		if(page.getIndex() < 1) {
			page.setIndex(1);
		}
		page.setSize(6);
		if(role.equals("1")) {
			User user = (User)session.getAttribute("user");
			List<Invitation> invitations = invitatoinService.selectInvitaionByUserIdByPage(page, user.getId());
			map.put("invitations", invitations);
		}else {
			if(role.equals("2")) {
				Manager manager = (Manager)session.getAttribute("manager");
				User user = userService.selectUserByPhone(manager.getPhone());
				List<Invitation> invitations = invitatoinService.selectInvitaionByUserIdByPage(page, user.getId());
				map.put("invitations", invitations);
			}
		}
		map.put("page", page);
		return "/meeting/mine";
	}
	/**
	 * 查看记录的会议
	 * @param page
	 * @param session
	 * @param map
	 * @return
	 */
	@RequestMapping(value="/record", method=RequestMethod.GET)
	public String recordMeeting(Page page, HttpSession session, Map<String, Object> map) {
		if(page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		User user = (User)session.getAttribute("user");
		List<Record> records = recordService.selectRecordByUserIdByPage(page, user.getId());
		if(records.size() == 0 && page.getIndex() > 1) {
			page.setIndex(page.getIndex() - 1 > 0 ? page.getIndex() - 1 : 1);
			records = recordService.selectRecordByUserIdByPage(page, user.getId());
		}
		map.put("page", page);
		map.put("records", records);
		return "/meeting/record";
	}
	
	@RequestMapping(value="/open", method=RequestMethod.GET)
	public String getOpenMeeting(Page page, HttpSession session, Map<String, Object> map) {
		if(page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		Manager manager = (Manager)session.getAttribute("manager");
		List<Meeting> meetings = meetingService.selectMeetingByManagerIdByPage(page, manager.getId());
		map.put("meetings", meetings);
		map.put("page", page);
		return "/meeting/open";
	}
	
//	@RequestMapping(value="/judge", method=RequestMethod.GET)
//	public String judgeMeeting(Page page, Map<String, Object> map) {
//		if(page.getIndex() == 0) {
//			page.setIndex(1);
//		}
//		page.setAppointment(3);
//		page.setSize(6);
//		List<Meeting> meetings = meetingService.selectAllByPage(page);
//		if(meetings.size() == 0) {
//			page.setIndex(page.getIndex() - 1 > 0 ? page.getIndex() - 1 : 1);
//			meetings = meetingService.selectAllByPage(page);
//		}
//		map.put("meetings", meetings);
//		map.put("page", page);
//		return "meeting/judge";
//	}

	/**
	 * 会议预约通过
	 * 
	 * @param id
	 * @param index
	 * @return
	 */
	@RequestMapping(value = "/{id}/agree", method = RequestMethod.PUT)
	public String agreeMeeting(@PathVariable Integer id, Page page) {
		meetingService.updateMeetingState(id, 1);
		Meeting meeting = meetingService.selectMeetingById(id);
		Manager manager = meeting.getManager();
		String email = manager.getEmail();
		CommonUtil.sendEmail(email, "您预约主题为：<< " + meeting.getTitle()
				+ " >>的会议已经通过审核。", sender);
		List<Invitation> invitations = invitatoinService
				.selectInvitationByMeetingId(id);
		for (int i = 0; i < invitations.size(); i++) {
			String content = manager.getName() + "邀请您参加主题为： << "
					+ meeting.getTitle() + " >>的会议，开始时间："
					+ CommonUtil.dateToString2(meeting.getStartTime())
					+ " , 结束时间： "
					+ CommonUtil.dateToString2(meeting.getEndTime());
			CommonUtil.sendEmail(invitations.get(i).getUser().getEmail(), content, sender);
		}
		List<Record> records = recordService.selectRecordByMeetingId(id);
		for(int i = 0; i < records.size(); i++) {
			String content = "部门经理: "
					+ meeting.getManager().getName()
					+ "委任您为主题为 ： << " + meeting.getTitle()
					+ " >> 的会议做会议记录的权限。"
					+ "会议的开始时间是 : " + CommonUtil.dateToString2(meeting.getStartTime())
					+ "，  结束时间是：" + CommonUtil.dateToString2(meeting.getEndTime());
			CommonUtil.sendEmail(records.get(i).getUser().getEmail(), content, sender);
		}
		String startTimeStr = CommonUtil.dateToString(meeting.getStartTime());
		int hour = meeting.getStartTime().getHours();
		Date startTime = null;
		Date endTime = null;
		if(hour < 12)	{
			try {
				startTime = new Date(CommonUtil.stringToDate(startTimeStr).getTime() + HOUR * 8);
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}else {
			if(hour < 17 && hour > 12 ) {
				try {
					startTime = new Date(CommonUtil.stringToDate(startTimeStr).getTime() + HOUR * 13);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}else {
				try {
					startTime = new Date(CommonUtil.stringToDate(startTimeStr).getTime() + HOUR * 18);
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
			}
		}
		endTime = new Date(startTime.getTime() + HOUR * 5);
		List<Meeting> meetings = meetingService.selectMeetingByRoomIdAndDate2(meeting.getMeetingRoom().getId(), startTime, endTime);
		for(int i = 0; i < meetings.size(); i++ ) {
			meetingService.updateMeetingState(meetings.get(i).getId(), 0);
			sendFailMessage(meetings.get(i), sender);
		}
		return "redirect:/meeting/list"+page;
	}

	/**
	 * 会议预约失败
	 * 
	 * @param id
	 * @param index
	 * @return
	 */
	@RequestMapping(value = "/{id}/disagree", method = RequestMethod.PUT)
	public String disagreeMeeting(@PathVariable Integer id, Page page) {
		meetingService.updateMeetingState(id, 0);
		Meeting meeting = meetingService.selectMeetingById(id);
		String email = meeting.getManager().getEmail();
		CommonUtil.sendEmail(email, "您预约主题为：<< " + meeting.getTitle()
				+ " >>的会议未能通过审核， 请重新预约！", sender);
		return "redirect:/meeting/list" + page;
	}

	/**
	 * 查看会议详细信息
	 * 
	 * @param id
	 * @param map
	 * @return
	 */
	@RequestMapping(value = "/{id}/detail", method = RequestMethod.GET)
	public String getMeetingDetail(@PathVariable Integer id,
			Map<String, Object> map) {
		Meeting meeting = meetingService.selectMeetingById(id);
		List<Department> departments = departmentService
				.selectAllDepartmentName();
		List<Invitation> invitations = invitatoinService
				.selectInvitationByMeetingId(meeting.getId());
		for (int i = 0; i < departments.size(); i++) {
			Department department = departments.get(i);
			List<User> users = new ArrayList<User>();
			for (int j = 0; j < invitations.size(); j++) {
				Invitation invitation = invitations.get(j);
				if (invitation.getUser().getDepartment().getId() == department
						.getId()) {
					User user = invitation.getUser();
					//用户是否参加会议用gender保存
					user.setGender(invitation.getIsAccess());
					users.add(user);
				}
			}
			department.setUsers(users);
		}
		List<Record> records = recordService.selectRecordByMeetingId(id);
		map.put("records", records);
		map.put("meeting", meeting);
		map.put("departments", departments);
		map.put("day", CommonUtil.dateToString(meeting.getStartTime()));
		map.put("equipments",
				equipmentService.selectEquipmentByMeetingId(meeting.getId()));
		return "meeting/detail";
	}
	
	@RequestMapping(value = "/{id}/delete", method = RequestMethod.DELETE)
	public String deleteMeeting(@PathVariable Integer id) {
		Meeting meeting = meetingService.selectMeetingById(id);
		String content = "部门经理：" + meeting.getManager().getName()
				+ "  已经取消了主题为:<<" + meeting.getTitle() + ">>的会议";
		List<Invitation> invitations = invitatoinService
				.selectInvitationByMeetingId(id);
		for (int i = 0; i < invitations.size(); i++) {
			Invitation invitation = invitations.get(i);
			CommonUtil.sendEmail(invitation.getUser().getEmail(), content,
					sender);
		}
		meetingService.deleteMeeting(id);
		return "redirect:/meeting/list";
	}
	
	@RequestMapping(value="/{id}/validate", method=RequestMethod.GET, produces="application/json;charset=gbk")
	@ResponseBody
	public ResultDto getValidateResult(@PathVariable Integer id, HttpSession session) {
		ResultDto resultDto = new ResultDto();
		resultDto.setTag(false);
		User user = (User) session.getAttribute("user");
		int userId = user.getId();
		Invitation invitation = invitatoinService.selectInvitationByUserIdAndMeetingId(userId, id);
		if(invitation == null) {
			resultDto.setTag(false);
			resultDto.setContent("");
			List<Record> records = recordService.selectRecordByMeetingId(id);
			if(records != null) {
				for(int i = 0; i < records.size(); i++) {
					if(records.get(i).getUser().getId() == userId) {
						resultDto.setTag(true);
					}
				}
			}
		}else {
			resultDto.setTag(true);
		}
		
		return resultDto;
	}
	
	private void sendFailMessage(Meeting meeting, JavaMailSender sender) {
		String email = meeting.getManager().getEmail();
		CommonUtil.sendEmail(email, "您预约主题为：<< " + meeting.getTitle()
				+ " >>的会议未能通过审核， 请重新预约！", sender);
	}
}
