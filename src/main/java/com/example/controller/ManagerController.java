package com.example.controller;

import java.io.File;
import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Random;

import javax.crypto.spec.IvParameterSpec;
import javax.servlet.ServletContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.MultipartResolver;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;

import com.example.bean.Department;
import com.example.bean.Equipment;
import com.example.bean.Invitation;
import com.example.bean.Manager;
import com.example.bean.Meeting;
import com.example.bean.MeetingRoom;
import com.example.bean.Page;
import com.example.bean.Record;
import com.example.bean.User;
import com.example.dto.DayInvitationDto;
import com.example.service.DepartmentService;
import com.example.service.EquipmentService;
import com.example.service.InvitatoinService;
import com.example.service.ManagerService;
import com.example.service.MeetingRoomService;
import com.example.service.MeetingService;
import com.example.service.RecordService;
import com.example.service.UserService;
import com.example.util.CommonUtil;
import com.sun.jmx.snmp.daemon.CommunicationException;

@Controller
@RequestMapping("/manager")
public class ManagerController {
	@Autowired
	private ManagerService managerService;
	@Autowired
	private DepartmentService departmentService;
	@Autowired
	private MeetingRoomService meetingRoomService;
	@Autowired
	private MeetingService meetingService;
	@Autowired
	private UserService userService;
	@Autowired
	private EquipmentService equipmentService;
	@Autowired
	private InvitatoinService invitationService;
	@Autowired
	private RecordService recordService;
	@Autowired
	private JavaMailSender sender;
	private final static String LIST_URL = "redirect:/manager/list";

	@RequestMapping(value = "/list", method = RequestMethod.GET)
	public String listManager(Page page, Map<String, Object> map) {
		if (page.getIndex() == 0) {
			page.setIndex(1);
		}
		page.setSize(6);
		List<Manager> managers = managerService.selectAllByPage(page);
		if(managers.size() == 0 && page.getTotal() != 0) {
			page.setIndex(page.getTotal());
			managers = managerService.selectAllByPage(page);
		}
		map.put("managers", managers);
		map.put("page", page);
		return "manager/manager_list_admin";
	}
	@RequestMapping(value="/{id}/detail", method=RequestMethod.GET)
	public String getManagerDetail(@PathVariable Integer id, Map<String, Object> map) {
		Manager manager = managerService.selectManagerById(id);
		map.put("user", manager);
		return "/manager/manager_detail_admin";
	}
	
	@RequestMapping(value="/add", method = RequestMethod.GET)
	public String prepareAdd(Map<String, Object> map) {
		List<Department> departments = departmentService.selectAllByCondiction();
		map.put("departments", departments);
		return "/manager/manager_add_admin";
	}

	@RequestMapping(value = "/add", method = RequestMethod.POST)
	public String addManager(String name, String password, String email, String phone,
			Integer gender, @RequestParam(value="departemntId", required=false) String departmentId, MultipartFile photo) {
		//保存文件并获得文件存的文件名
		String fileName = CommonUtil.saveFile(photo, CommonUtil.getConfigString("photoLocation"),1);
		Department department = new Department();
		if(departmentId != null && departmentId.length() != 0) {
			department.setId(Integer.parseInt(departmentId));	
		}
		Manager manager = new Manager(gender, phone, password, name, fileName, email, department.getId() == 0 ? null : department);
		managerService.addManager(manager);
		return LIST_URL + "?index=" + 9999;
	}

	@RequestMapping(value = "/{id}/update", method = RequestMethod.GET)
	public String prepareUpdate(@PathVariable Integer id,
			Map<String, Object> map) {
		Manager manager = managerService.selectManagerById(id);
		List<Department> departments = departmentService.selectAllByCondiction();
		map.put("manager", manager);
		departments.add(manager.getDepartment());
		map.put("departments", departments);
		return "manager/manager_update_admin";
	}
	@Transactional
	@RequestMapping(value = "/{id}/update", method = RequestMethod.PUT)
	public String updateManager(Manager manager, HttpSession session) {
		managerService.updateManager(manager);
		Manager man = (Manager)session.getAttribute("manager");
		User user = userService.selectIdByPhone(man.getPhone());
		manager.setId(user.getId());
		userService.updateUser(manager);
		return LIST_URL;
	}

	@RequestMapping(value = "/{id}/delete", method = RequestMethod.DELETE)
	public String deleteManager(@PathVariable Integer id) {
		managerService.deleteManager(id);
		return LIST_URL;
	}

	@RequestMapping(value = "/meeting/first1", method = RequestMethod.GET)
	public String prepareMeetingFirst1(
			@RequestParam(value="roomId", required=false) Integer roomId,
			@RequestParam(value = "id", required = false) Integer id,
			HttpSession session, Map<String, Object> map) {
		List<Department> departments = departmentService.selectAll();
		map.put("departments", departments);
		map.put("tag", 0);
		map.put("tag2", 0);
		if(roomId != null) {
			session.setAttribute("roomId", roomId);
		}
		if (id != null) {
			// 说明是修改操作
			List<Invitation> invitations = invitationService
					.selectInvitationByMeetingId(id);
			Meeting meeting = meetingService.selectMeetingById(id);
			List<Equipment> oldEquipments = equipmentService
					.selectEquipmentByMeetingId(id);
			List<Equipment> equipments = equipmentService.selectAll();
			for (int i = 0; i < equipments.size(); i++) {
				Equipment equipment = equipments.get(i);
				for (int j = 0; j < oldEquipments.size(); j++) {
					Equipment oldEquipment = oldEquipments.get(j);
					if (oldEquipment.getId() == equipment.getId()) {
						equipment.setNeed(oldEquipment.getNeed());
					}
				}
			}
			meeting.setEquipments(equipments);
			List<Record> records = recordService.selectRecordByMeetingId(id);
			for (int i = 0; i < records.size(); i++) {
				Record record = records.get(i);
				record.setId(record.getUser().getDepartment().getId());
			}
			map.put("invitations", invitations);
			session.setAttribute("records", records);
			session.setAttribute("meeting", meeting);
		}
		return "manager/first4";
	}

	@RequestMapping(value = "/meeting/second1", method = { RequestMethod.POST,
			RequestMethod.GET })
	public String prepareMeetingSecond(
			@RequestParam(value = "userIds", required = false) Integer[] userIds,
			HttpServletRequest request, Map<String, Object> map) {
		HttpSession session = request.getSession();
		// 邀请
		List<Invitation> invitations = new ArrayList<Invitation>();
		if (userIds != null) {
			Date startTime = new Date(System.currentTimeMillis() + CommonUtil.DAY);
			List<User> users = new ArrayList<User>();
			for (int i = 0; i < userIds.length; i++) {
				int userId = userIds[i];
				User user = new User();
				User user2 = new User();
				user.setId(userId);
				Invitation invitation = new Invitation(2, user, null);
				invitations.add(invitation);
				//增加一天
				try {
					//将增加的一天时分秒归零
					startTime = CommonUtil.stringToDate(CommonUtil.dateToString(startTime));
				} catch (ParseException e) {
					// TODO Auto-generated catch block
					e.printStackTrace();
				}
				List<Invitation> invitations2 = invitationService.selectInvitationByUserIdByDate(userId, startTime, new Date(startTime.getTime() + CommonUtil.DAY * 7));
				user2.setInvitations(invitations2);
				users.add(user2);
			}
			//获得建议开会时间， 和会议室， 并保存在session中
			getAdviceTime(users, startTime, session);
			session.setAttribute("invitations", invitations);
			int count = invitations.size();
			session.setAttribute("invitationCount", count);
			session.setAttribute("totalPage", (count % 6 == 0 ? count / 6
					: count / 6 + 1));
		}
		String[] us = { request.getParameter("u1"), request.getParameter("u2"),
				request.getParameter("u3") };
		String[] dds = { request.getParameter("dd1"),
				request.getParameter("dd2"), request.getParameter("dd3") };
		List<Record> records = new ArrayList<Record>();
		int myTag = 0;
		int count = 0;
		for (int i = 0; i < us.length; i++) {
			if (dds[0] == null) {
				// 说是点上一步返回的， 标记设置1
				myTag = 1;
			}
			int userId = -1;
			if (us[i] != null && us[i].length() != 0) {
				userId = Integer.parseInt(us[i]);
				++count;
			}
			User user = new User();
			user.setId(userId);
			Record record = new Record();
			// department.id保存在record.id中
			record.setId(Integer.parseInt(dds[i] == null ? "0" : dds[i]));
			record.setUser(user);
			records.add(record);
		}
		if (myTag == 0) {
			session.setAttribute("recordCount", count);
			session.setAttribute("records", records);
		}
		// 不应放在外边， 因为用get请求进来之后会吧invitations的保存的数据清空了
		// session.setAttribute("invitations", invitations);
		Meeting meeting = (Meeting) session.getAttribute("meeting");
		if (meeting == null) {
			meeting = new Meeting();
			List<MeetingRoom> adviceMeetingRooms = (List<MeetingRoom>)session.getAttribute("adviceMeetingRooms");
			if(adviceMeetingRooms != null && session.getAttribute("roomId") == null) {
				meeting.setMeetingRoom(adviceMeetingRooms.get(0));
			}else {
				Integer roomId = Integer.parseInt(session.getAttribute("roomId").toString());
				MeetingRoom meetingRoom = meetingRoomService.selectMeetingRoomById(roomId);
				meeting.setMeetingRoom(meetingRoom);
			}
		} else {
			SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
			String startTimeStr = "";
			if (meeting.getStartTime() != null) {
				startTimeStr = format.format(meeting.getStartTime());
			}
			String endTimeStr = "";
			if (meeting.getEndTime() != null) {
				endTimeStr = format.format(meeting.getEndTime());
			}
			map.put("startTimeStr", startTimeStr);
			map.put("endTimeStr", endTimeStr);
		}
		map.put("tag", 0);
		map.put("meeting", meeting);
		int invitationCount = Integer.parseInt(session.getAttribute(
				"invitationCount").toString());
		int recordCount = Integer.parseInt(session.getAttribute("recordCount")
				.toString());
		map.put("meetingRooms",
				meetingRoomService.selectAllByCapacity(invitationCount
						+ recordCount + 1));
		return "manager/second2";
	}

	// @RequestMapping(value="/meeting/second1", method=RequestMethod.GET)
	// public String prepareMeetingSecond3(HttpSession session, Map<String,
	// Object>map) {
	// Meeting meeting = (Meeting)session.getAttribute("meeting");
	// map.put("meeting", meeting);
	// SimpleDateFormat format = new SimpleDateFormat("yyyy/MM/dd HH:mm");
	// String startTimeStr = format.format(meeting.getStartTime());
	// String endTimeStr = format.format(meeting.getEndTime());
	// map.put("startTimeStr", startTimeStr);
	// map.put("endTimeStr", endTimeStr);
	// map.put("meetingRooms", meetingRoomService.selectAll());
	// return "manager/second2";
	// }

	@RequestMapping(value = "/meeting/third1", method = RequestMethod.POST)
	public String prepareThird(
			Integer tag,
			Meeting meeting,
			@RequestParam(value = "startTimeStr", required = false) String startTimeStr,
			@RequestParam(value = "endTimeStr", required = false) String endTimeStr,
			HttpSession session, Map<String, Object> map) {
		// 返回上一步
		List<Equipment> equipments = null;
		// Meeting meeting = new Meeting();
		// MeetingRoom meetingRoom = new MeetingRoom();
		// meetingRoom.setId(meetingRoomId);
		// meeting.setMeetingRoom(meetingRoom);
		// System.out.println(startTimeStr + "------" + endTimeStr);
		if (startTimeStr != null && startTimeStr.length() != 0) {
			try {
				meeting.setStartTime(CommonUtil.stringToDate2(startTimeStr));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		if (endTimeStr != null && endTimeStr.length() != 0) {
			try {
				meeting.setEndTime(CommonUtil.stringToDate2(endTimeStr));
			} catch (ParseException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
			}
		}
		Meeting oldMeeting = (Meeting) session.getAttribute("meeting");
		if (oldMeeting == null || oldMeeting.getEquipments() == null) {
			equipments = equipmentService.selectAll();
			oldMeeting = meeting;
			session.setAttribute("meeting", oldMeeting);
		} else {
			equipments = oldMeeting.getEquipments();
		}
		oldMeeting.setMeetingRoom(meeting.getMeetingRoom());
		oldMeeting.setStartTime(meeting.getStartTime());
		oldMeeting.setEndTime(meeting.getEndTime());
		oldMeeting.setTitle(meeting.getTitle());
		if (tag == 1) {
			return "redirect:/manager/meeting/first1";
		}
		map.put("equipments", equipments);
		return "manager/third2";
	}

	// @RequestMapping(value="/meeting/third1", method=RequestMethod.GET)
	// public String prepareThird1(HttpSession session, Map<String, Object> map)
	// {
	// Meeting meeting = (Meeting)session.getAttribute("meeting");
	// map.put("equipments", meeting.getEquipments());
	// return "manager/third2";
	// }

	@RequestMapping(value = "/meeting/finish1", method = RequestMethod.POST)
	public String prepareFinish(Integer tag, HttpServletRequest request) {
		HttpSession session = request.getSession();
		Meeting meeting = (Meeting) session.getAttribute("meeting");
		if (meeting.getEquipments() == null) {
			meeting.setEquipments(equipmentService.selectAll());
		}
		// 更新设备数量
		List<Equipment> equipments = meeting.getEquipments();
		for (int i = 0; i < equipments.size(); i++) {
			Equipment equipment = equipments.get(i);
			int id = equipment.getId();
			String need = request.getParameter(id + "");
			if (need != null && need != "") {
				equipment.setNeed(Integer.parseInt(need));
			}
		}
		// 上一步
		if (tag == 1) {
			return "redirect:/manager/meeting/second1";
		} else {
			List<Invitation> invitations = (List<Invitation>) session
					.getAttribute("invitations");
			List<Record> records = (List<Record>) session
					.getAttribute("records");
			for (int i = 0; i < invitations.size(); i++) {
				invitations.get(i).setMeeting(meeting);
			}
			for (int i = 0; i < records.size(); i++) {
				records.get(i).setMeeting(meeting);
			}
			Manager manager = (Manager)session.getAttribute("manager");
			meeting.setInvitations(invitations);
			meeting.setRecords(records);
			meeting.setManager(manager);
			if (meeting.getId() == 0) {
				finishMeeting(meeting);
			} else {
				updateMeeting(meeting);
			}
			session.removeAttribute("invitations");
			session.removeAttribute("meeting");
			session.removeAttribute("records");
			session.removeAttribute("invitationCount");
			session.removeAttribute("recordCount");
			session.removeAttribute("totalPage");
			session.removeAttribute("adviceStart");
			session.removeAttribute("adviceEnd");
			session.removeAttribute("adviceMeetingRooms");
			session.removeAttribute("roomId");
		}

		return "redirect:/meeting/open";
	}

	/*---------------------------------会议预约-----------------------------------*/

	/*------------------------------修改会议--------------------------------------------*/

	@RequestMapping(value = "/{meetingId}/first")
	public String updateStep1(@PathVariable Integer meetingId,
			HttpSession session, Map<String, Object> map) {
		List<Invitation> invitations = invitationService
				.selectInvitationByMeetingId(meetingId);
		map.put("invitations", invitations);
		map.put("departments", departmentService.selectAll());
		return "manager/first4";
	}

	/*---------------------------------------------------------------------------------*/

	@RequestMapping(value = "/{id}/openMeeting", method = RequestMethod.POST)
	@Transactional
	public String openMeeting(@PathVariable("id") Integer roomId,
			@RequestParam("equipmentIds") Integer[] equipmentIds,
			@RequestParam("userIds") Integer[] userIds, Meeting meeting,
			HttpServletRequest request) {
		Manager manager = new Manager();
		manager.setId(2);
		meeting.setManager(manager);
		MeetingRoom room = new MeetingRoom();
		room.setId(roomId);
		meeting.setMeetingRoom(room);
		meetingService.addMeeting(meeting);
		int meetingId = meeting.getId();
		List<Equipment> equipments = new ArrayList<>();
		List<Invitation> invitations = new ArrayList<>();
		for (int i = 0; i < equipmentIds.length; i++) {
			int count = Integer.parseInt(request.getParameter(equipmentIds[i]
					+ ""));
			Equipment equipment = new Equipment();
			equipment.setCount(count);
			equipment.setId(equipmentIds[i]);
			equipments.add(equipment);
			// System.out.print(equipmentIds[i] + "-----" +
			// request.getParameter(equipmentIds[i] + ""));
		}
		for (int i = 0; i < userIds.length; i++) {
			Invitation invitation = new Invitation();
			User user = new User();
			user.setId(userIds[i]);
			invitation.setUser(user);
			invitation.setMeeting(meeting);
			invitations.add(invitation);
			// System.out.print(userIds[i] + "---");

		}
		// System.out.println();
		invitationService.addInvitations(invitations);
		equipmentService.useEquipments(equipments, meeting.getId());
		return LIST_URL;
	}

	/**
	 * 获取2进制流中的数据邦定到manager
	 * 
	 * @param request
	 * @return
	 */
//	private Manager getManager(MultipartHttpServletRequest request) {
//		String name = request.getParameter("name");
//		String phone = request.getParameter("phone");
//		String password = request.getParameter("password");
//		int departmentId = Integer.parseInt(request
//				.getParameter("departmentId"));
//		Manager manager = new Manager(1, phone, password, name, "", null);
//		Department department = new Department();
//		department.setId(departmentId);
//		;
//		manager.setDepartment(department);
//		return manager;
//	}

	@Transactional
	private void finishMeeting(Meeting meeting) {
		meetingService.addMeeting(meeting);
		equipmentService
				.useEquipments(meeting.getEquipments(), meeting.getId());
		List<Record> records = meeting.getRecords();
		for (int i = 0; i < records.size(); i++) {
			if (records.get(i).getUser().getId() > 0) {
				recordService.addRecord(records.get(i));
			}
		}
		invitationService.addInvitations(meeting.getInvitations());
	}

	@Transactional
	private void updateMeeting(Meeting meeting) {
		Meeting oldMeeting = meetingService.selectMeetingById(meeting.getId());
		// 进行判断
		int tag = 0;
		if (!meeting.getTitle().equals(oldMeeting.getTitle())) {
			tag = 1;
		}
		if (meeting.getMeetingRoom().getId() != oldMeeting.getMeetingRoom()
				.getId()) {
			tag = 1;
		}
		List<Equipment> oldEquipments = equipmentService
				.selectEquipmentByMeetingId(meeting.getId());
		List<Equipment> equipments = meeting.getEquipments();
		for (int i = 0; i < equipments.size(); i++) {
			for (int j = 0; j < oldEquipments.size(); j++) {
				if (equipments.get(i).getId() == oldEquipments.get(j).getId()
						&& equipments.get(i).getNeed() != oldEquipments.get(j)
								.getNeed()) {
					tag = 1;
					break;
				}
			}
		}
		if (tag == 1) {
			List<Invitation> oldInvitations = invitationService
					.selectInvitationByMeetingId(meeting.getId());
			meetingService.updateMeeting(meeting);
			String content = "部门经理: " + oldMeeting.getManager().getName()
					+ " 已经取消了主题为 ： << " + oldMeeting.getTitle() + " >> 的会议";
			for (int i = 0; i < oldInvitations.size(); i++) {
				CommonUtil.sendEmail(
						oldInvitations.get(i).getUser().getEmail(), content,
						sender);
			}
		} else {
			List<Invitation> oldInvitations = invitationService
					.selectInvitationByMeetingId(meeting.getId());
			List<Invitation> invitations = meeting.getInvitations();
			// 对没有勾选的用户取消邀请
			for (int i = 0; i < oldInvitations.size(); i++) {
				int tag2 = 0;
				for (int j = 0; j < invitations.size(); j++) {
					if (oldInvitations.get(i).getUser().getId() == invitations
							.get(j).getUser().getId()) {
						tag2 = 1;
						break;
					}
				}
				if (tag2 == 0) {
					invitationService.deleteInvitation(oldInvitations.get(i)
							.getId());
					String content = "部门经理: "
							+ oldMeeting.getManager().getName()
							+ " 对您取消了主题为 ： << " + oldMeeting.getTitle()
							+ " >> 的会议的邀请！";
					CommonUtil.sendEmail(oldInvitations.get(i).getUser()
							.getEmail(), content, sender);
				}
			}
			// 对新增的发送邀请
			List<Invitation> newInvitations = new ArrayList<Invitation>();
			for (int i = 0; i < invitations.size(); i++) {
				int tag2 = 0;
				for (int j = 0; j < oldInvitations.size(); j++) {
					if (invitations.get(i).getUser().getId() == oldInvitations
							.get(j).getUser().getId()) {
						tag2 = 1;
						break;
					}
				}
				if (tag2 == 0) {
					newInvitations.add(invitations.get(i));
					int userId = invitations.get(i).getUser().getId();
					User user = userService.selectUserById(userId);
					String content = "部门经理: "
							+ oldMeeting.getManager().getName()
							+ " 邀请您参加主题为 ： << " + oldMeeting.getTitle()
							+ " >> 的会议。";
					CommonUtil.sendEmail(user.getEmail(), content, sender);
				}
			}
			if (newInvitations.size() > 0) {
				invitationService.addInvitations(newInvitations);
			}
			List<Record> oldRecords = recordService
					.selectRecordByMeetingId(meeting.getId());
			List<Record> records = meeting.getRecords();
			for (int i = 0; i < oldRecords.size(); i++) {
				int tag2 = 0;
				for (int j = 0; j < records.size(); j++) {
					if (oldRecords.get(i).getUser().getId() == records.get(j)
							.getUser().getId()) {
						tag2 = 1;
						break;
					}
				}
				if (tag2 == 0) {
					String content = "部门经理: "
							+ oldMeeting.getManager().getName()
							+ "取消了您为主题为 ： << " + oldMeeting.getTitle()
							+ " >> 的会议做会议记录的权限。";
					CommonUtil.sendEmail(
							oldRecords.get(i).getUser().getEmail(), content,
							sender);
					recordService.deleteRecordById(oldRecords.get(i).getId());
				}
			}

			for (int i = 0; i < records.size(); i++) {
				int tag2 = 0;
				Record record = records.get(i);
				for (int j = 0; j < oldRecords.size(); j++) {
					if (record.getUser().getId() == oldRecords.get(j).getUser()
							.getId()) {
						tag2 = 1;
						break;
					}
				}
				if (tag2 == 0 && record.getId() > 0) {
					recordService.addRecord(record);
					String content = "部门经理: "
							+ oldMeeting.getManager().getName()
							+ "委任您为主题为 ： << " + oldMeeting.getTitle()
							+ " >> 的会议做会议记录的权限。" + "会议的开始时间是 : "
							+ CommonUtil.dateToString2(meeting.getStartTime())
							+ "，  结束时间是："
							+ CommonUtil.dateToString2(meeting.getEndTime());
					User user = userService.selectUserById(record.getUser()
							.getId());
					CommonUtil.sendEmail(user.getEmail(), content, sender);
				}
			}
		}
	}
	
	private void getAdviceTime(List<User> users, Date start, HttpSession session) {
		int userSize = users.size();
		int[][] arr = new int[3][7 * userSize];
		for(int i = 0; i < userSize; i++) {
			int begin = i * 7;
			User user = users.get(i);
			List<Invitation> invitations = user.getInvitations();
			for(int j = 0; j < invitations.size(); j++) {
				Meeting meeting = invitations.get(j).getMeeting();
				long subDay = meeting.getStartTime().getTime() - start.getTime();
				int day = (int)(subDay / CommonUtil.DAY);
				long subHour = subDay % CommonUtil.DAY;
				int hour = (int)(subHour / CommonUtil.HOUR);
				int column = begin + day;
				int row = 0;
				if(hour >= 13 && hour < 17) {
					row = 1;
				}else {
					if(hour >= 18){
						row = 2;
					}
				}
				arr[row][column] = 1;
			}
		}
		
		for(int i = 0; i < arr.length; i++) {
			for(int j = 0; j < arr[i].length; j++) {
				System.out.print(arr[i][j] + "  ");
			}
			System.out.println();
		}
		for(int i = 0; i < 3; i++) {
			for(int j = 0; j < 7; j++) {
				int tag = 0; 
				for(int l = j; l < arr[i].length; l += 7) {
					if(arr[i][l] == 1) {
						tag = 1;
						break;
					}
				}
				if(tag == 0) {
					Date startTime = new Date(start.getTime() + CommonUtil.DAY * j + CommonUtil.HOUR * (8 + i * 5));
					Date endTime = new Date(startTime.getTime() + CommonUtil.HOUR * 4);
					List<MeetingRoom> meetingRooms = meetingRoomService.selectAllByCapacityAndDate(userSize, startTime, endTime);
					if(meetingRooms.size() != 0) {
						if(session.getAttribute("roomId") == null) {
							session.setAttribute("adviceMeetingRooms", meetingRooms);
							session.setAttribute("adviceStart", CommonUtil.dateToString3(startTime));
							session.setAttribute("adviceEnd", CommonUtil.dateToString3(endTime));
							return ;
						}else {
							Integer roomId = Integer.parseInt(session.getAttribute("roomId").toString());
							for(int k = 0;k < meetingRooms.size(); k++) {
								if(roomId == meetingRooms.get(k).getId()) {
									session.setAttribute("adviceMeetingRooms", meetingRooms);
									session.setAttribute("adviceStart", CommonUtil.dateToString3(startTime));
									session.setAttribute("adviceEnd", CommonUtil.dateToString3(endTime));
									return ;
								}
							}
						}
					}
				}
			}
		}
//		for(int i = 0; i < 7; i++) {
//			for(int j = 0; j < 3; j++) {
//				
//				for(int l = 0; l < userSize; l++) {
//					
//				}
//			}
//		}
//		return "";
		
	}
}
