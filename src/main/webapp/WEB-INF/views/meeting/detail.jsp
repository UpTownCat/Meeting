<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk" isELIgnored="false"%>
<%
	String path = request.getContextPath();
	request.setAttribute("partName", path + "/room/day/");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="../common3l.jsp"%>
<script type="text/javascript">
	$(function() {
		var day = "${day }";
		var myYear = parseInt(day.substring(0, 4));
		var myMonth = parseInt(day.substring(4, 6));
		var myDay = parseInt(day.substring(6, 8));
		common.init("${partName }" + day.toString(), "");
		CalendarHandler.initialize(myYear, myMonth, myDay);
	})
</script>
<style type="text/css">
td {
	width: 20%;
}
</style>
</head>
<body>
	<%@include file="../nav.jsp"%>
		<div class="nav_middle" style="float:left; margin-top: 50px">
			<div class="nav_middle_top">
				<%@include file="../calendar.jsp"%>
			</div>
			<%@include file="../notice.jsp"%>
		</div>

		<div class="container col-lg-9" style="float:left;padding: 0 0; margin-top: 50px">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>会议详情</h3>
				</div>
				<div class="panel-body">
					<div class="col-lg-8">
						<table class="table table-bordered">
							<tbody>
								<tr>
									<td>主题</td>
									<td>${meeting.title }</td>
								</tr>
								<tr>
									<td>召开人</td>
									<td>${meeting.manager.name }</td>
								</tr>
								<tr>
									<td>开始时间</td>
									<td><fmt:formatDate value="${meeting.startTime }"
											pattern="yyyy-MM-dd HH:mm" /></td>
								</tr>
								<tr>
									<td>结束时间</td>
									<td><fmt:formatDate value="${meeting.endTime }"
											pattern="yyyy-MM-dd HH:mm" /></td>
								</tr>
								<tr>
									<td>会议室</td>
									<td>${meeting.meetingRoom.number }</td>
								</tr>
								<tr>
									<td>地点</td>
									<td>${meeting.meetingRoom.location }</td>
								</tr>
								<tr>
									<td>会议记录人</td>
									<td><c:forEach items="${records }" var="record"
											varStatus="status">
											${status.index + 1 }.${record.user.name }&nbsp;&nbsp;
										</c:forEach></td>
								</tr>
								<tr>
									<td>会议文档</td>
									<td>
										<c:forEach items="${records }" var="record">
											<a href="/meeting/user/download?id=${record.id }" target="_blank">${record.file }</a>
											<br>
										</c:forEach>
									</td>
								</tr>
							</tbody>
						</table>
					</div>
					<div class="col-lg-4">
						<table class="table table-bordered">
							<thead>
								<tr>
									<th>设备名称</th>
									<th>设备数量</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${equipments }" var="equipment">
									<tr>
										<td>${equipment.name }</td>
										<td>${equipment.need }</td>
									</tr>
								</c:forEach>

							</tbody>
						</table>
					</div>
					<div>
						<div class="row" style="float:left; width: 100%">
							<ul class="nav nav-tabs" role="tablist">
								<c:forEach items="${departments }" var="department"
									varStatus="status">
									<c:if test="${status.index == 0 }">
										<li role="presentation" class="active"><a
											href="#department${department.id }" role="tab"
											data-toggle="tab">${department.name }</a></li>
									</c:if>
									<c:if test="${status.index != 0 }">
										<li role="presentation"><a
											href="#department${department.id }" role="tab"
											data-toggle="tab">${department.name }</a></li>
									</c:if>
								</c:forEach>
							</ul>

							<!-- Tab panes -->
							<div class="tab-content">
								<c:forEach items="${departments }" var="department" varStatus="status">
									<c:if test="${status.index == 0 }">
										<div role="tabpanel" class="tab-pane active"
											id="department${department.id }">
											<table class="table table-bordered">
												<tbody>
													<c:forEach begin="0" end="${department.size % 5 == 0 ? department.size / 5 : department.size / 5 + 1 }" varStatus="status1">
														<tr>
															<c:forEach items="${department.users }" var="user"
																begin="${status1.index * 5 }"
																end="${(status1.index - 0 + 1) * 5 - 1 }">
																<td>
																	<label>
																		${user.name }
																		<c:if test="${user.gender == 2 }">
																			(不确定)
																		</c:if>	
																		<c:if test="${user.gender == 1 }">
																			(参加)
																		</c:if>	
																		<c:if test="${user.gender == 0 }">
																			(不参加)
																		</c:if>	
																	</label>
																</td>
															</c:forEach>
														</tr>
													</c:forEach>
												</tbody>
											</table>

										</div>
									</c:if>
									<c:if test="${status.index != 0 }">
										<div role="tabpanel" class="tab-pane"
											id="department${department.id }">
											<table class="table table-bordered">
												<tbody>
													<c:forEach begin="0" end="${department.size % 5 == 0 ? department.size / 5 : department.size / 5 }" varStatus="status2">
														<tr>
															<c:forEach items="${department.users }" var="user"
																begin="${status2.index * 5 }"
																end="${(status2.index - 0 + 1) * 5 - 1 }">
																<td>
																	<label>
																		${user.name }
																		<c:if test="${user.gender == 2 }">
																			(不确定)
																		</c:if>	
																		<c:if test="${user.gender == 1 }">
																			(参加)
																		</c:if>	
																		<c:if test="${user.gender == 0 }">
																			(不参加)
																		</c:if>	
																	</label>
																</td>
															</c:forEach>
														</tr>
													</c:forEach>
												</tbody>
											</table>
										</div>
									</c:if>
								</c:forEach>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
</body>
</html>