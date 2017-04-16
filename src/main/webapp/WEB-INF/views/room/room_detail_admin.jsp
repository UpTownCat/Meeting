<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "/meeting/user");
%>

<!DOCTYPE html>
<html>
<head>

<title>${partName }</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common3l.jsp"%>
<script type="text/javascript">
		$(function() {
			CalendarHandler.initialize(0, 0, 0);
			var photo = "${meetingRoom.photo }";
			var url = "/meeting/common/" + encodeURI(photo) + "/photo";
			console.log(url);
			$("#img").attr("src", url);
		})
		
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<%@include file="../menu2.jsp" %>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>会议室详情</h3>
				<c:if test="${sessionScope.role == 2 }">
						<a class="btn btn-primary pull-right" style='margin-top: -40px' href="/meeting/manager/meeting/first1?roomId=${meetingRoom.id }">预约</a>
				</c:if>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
					<table class="table table-bordered table-hover">
						<tbody>
							<tr>
								<td>编号</td>
								<td>${meetingRoom.number }</td>
							</tr>
							<tr>
								<td>地点</td>
								<td>${meetingRoom.location }</td>
							</tr>
							<tr>
								<td>容量</td>
								<td>${meetingRoom.capacity }</td>
							</tr>
						</tbody>
					</table>
				</div>
				<div class="col-lg-3" style="float:left">
					<img alt="" src="" id="img" class="img" style="width: 300px; height: 300px">
				</div>
				<table class="table table-striped">
						<thead>
							<tr>
								<th>主题</th>
								<th>经理</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th></th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${meetings }" var="meeting">
								<tr>
									<td>${meeting.title }</td>
									<td>${meeting.manager.name }</td>
									<td>
										<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td><a href="/meeting/meeting/${meeting.id }/detail" class="btn btn-info">详情</a></td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
			</div>
		</div>
	</div>
</body>
</html>
