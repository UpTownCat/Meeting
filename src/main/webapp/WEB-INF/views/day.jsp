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
<%@include file="common3l.jsp" %>
<style type="text/css">
	td{
		height: 130px;
		width: 25%;
		text-align: center; 
		vertical-align: middle;
	}
	th{
		text-align: center; 
	}
	.hold{
		height: 130px;
		width: 25%;
		background-color: #e6b8af;
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
					<h4>会议室日视图</h4>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<thead>
							<tr>
								<th>会议室</th>
								<th>上午</th>
								<th>下午</th>
								<th>晚上</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${dtos }" var="dto">
								<tr>
									<td >${dto.roomNumber }</td>
									<c:forEach items="${dto.msgDtos }" var="msg">
										<c:if test="${msg.isEmpty == 1 }">
											<td>
												<c:if test="${msg.available == 1 }">
													<c:if test="${role == 2 }">
														<a class="btn btn-success" href="/meeting/manager/meeting/first1?roomId=${dto.roomId }">预约</a>
													</c:if>
													<c:if test="${role != 2 }">
														<a class="btn btn-success" disabled="disabled">预约</a>
													</c:if>
												</c:if>
												<c:if test="${msg.available == 0 }">
													<a class="btn btn-success" disabled="disabled">预约</a>
												</c:if>
											</td>
										</c:if>
										<c:if test="${msg.isEmpty == 0 }">
											<td class='hold'>
												发起人:${msg.managerName }
												<h5>主题:${msg.title }</h5>
												<h5>
													<fmt:formatDate value="${msg.startTime }" pattern="HH:mm"/> --
													<fmt:formatDate value="${msg.endTime }" pattern="HH:mm"/>
												</h5>
												<a href="/meeting/meeting/${msg.meetingId }/detail" class="btn btn-success detail">详情</a>
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