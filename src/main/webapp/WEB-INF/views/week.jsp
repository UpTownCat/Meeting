<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk" isELIgnored="false"%>
	
<%
String path = request.getContextPath();
request.setAttribute("partName", path + "/room/week/");
request.setAttribute("meetingPath", path + "/meeting/");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="common3l.jsp" %>
<style type="text/css">
	td{
		height: 130px;
		width: 12.5%;
		text-align: center; 
		vertical-align: middle;
	}
	th{
		text-align: center; 
	}
	.hold{
		height: 130px;
		width: 12.5%;
		background-color: #f60;
		text-align: center; 
		vertical-align: middle;
	}
</style>
<script type="text/javascript">
	$(function() {
		var day = "${day }";
		var myYear = parseInt(day.substring(0, 4));
		var myMonth = parseInt(day.substring(4, 6));
		var myDay = parseInt(day.substring(6, 8));
		common.init("${partName }" + day.toString(), "");
		CalendarHandler.initialize(myYear, myMonth, myDay);
		var total = "${page.total }";
		var index = "${page.index }";
		var url = "${partName }${day }";
		page.init(6, index, total, url);
		$("#forward").click(function(){
			page.forward(total, url);
		});
	})
</script>
</head>
<body>
	<%@include file="nav.jsp" %>
	<div class="main" style="margin-top: 50px">
		<div class="nav_middle" style="float:left;">
			<div class="nav_middle_top">
				<%@include file="calendar.jsp" %>
			</div>
			<%@include file="notice.jsp" %>
		</div>
		
		<div class="container col-lg-9" style="float:left; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>会议室周视图</h4>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>会议室</th>
								<th>一</th>
								<th>二</th>
								<th>三</th>
								<th>四</th>
								<th>五</th>
								<th>六</th>
								<th>日</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${weekViewDtos }" var="weekDto">
								<tr>
									<td >${weekDto.roomNumber }</td>
									<c:forEach items="${weekDto.dayViewDtos }" var="dayDto">
										<c:if test="${dayDto.hasMeeting == 0 }">
											<td>
												<c:forEach items="${dayDto.msgDtos }" var="msgDto">
													<c:if test="${msgDto.available == 0 }">
														<label>
															${msgDto.time }:<a class="btn btn-success" disabled="disabled">预约</a>
														</label>
													</c:if>
													<c:if test="${msgDto.available == 1 }">
														<label>
															<c:if test="${role == 2 }">
																	${msgDto.time }:<a class="btn btn-success" href="/meeting/manager/meeting/first?roomId=${dayDto.roomId }">预约</a>
																</c:if>
																<c:if test="${role == 1 }">
																	${msgDto.time }:<a class="btn btn-success" disabled="disabled">预约</a>
															</c:if>
														</label>
													</c:if>
												</c:forEach>
											</td>
										</c:if>
										<c:if test="${dayDto.hasMeeting == 1 }">
											<td >
												<c:forEach items="${dayDto.msgDtos }" var="msgDto">
													<c:if test="${msgDto.title != null }">
														<label>${msgDto.time }:</label><a class="detail" href="${meetingPath }${msgDto.meetingId }/detail">${msgDto.managerName }--${msgDto.title }</a><br>
													</c:if>
													<c:if test="${msgDto.title == null }">
														<c:if test="${msgDto.available == 0 }">
															<label>
																${msgDto.time }:<a class="btn btn-success" disabled="disabled">预约</a>
															</label>
														</c:if>
														<c:if test="${msgDto.available == 1 }">
															<label>
																<c:if test="${role == 2 }">
																	${msgDto.time }:<a class="btn btn-success" href="/meeting/manager/meeting/first?roomId=${dayDto.roomId }">预约</a>
																</c:if>
																<c:if test="${role == 1 }">
																	${msgDto.time }:<a class="btn btn-success" disabled="disabled">预约</a>
																</c:if>
															</label>
														</c:if>
													</c:if>
												</c:forEach>
											</td>
										</c:if>
									</c:forEach>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="page.jsp" %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>