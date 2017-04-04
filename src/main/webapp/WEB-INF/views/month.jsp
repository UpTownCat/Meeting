<%@ page language="java" contentType="text/html; charset=gbk"
	pageEncoding="gbk" isELIgnored="false"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
<title>Insert title here</title>
<%@include file="common3l.jsp" %>
<style type="text/css">
	td{
		height: 110px;
		width: 12.5%;
		text-align: center; 
		vertical-align: middle;
	}
	.hold{
		height: 110px;
		width: 12.5%;
		text-align: center; 
		vertical-align: middle;
		background-color: #e6b8af;
	}
</style>
<script type="text/javascript">
	$(function() {
		var day = "${day }";
		var myYear = parseInt(day.substring(0, 4));
		var myMonth = parseInt(day.substring(4, 6));
		CalendarHandler.initialize(myYear, myMonth, -1);
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
		
		<div class="container col-lg-9" style="float:left;padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>会议室月视图</h4>
				</div>
				<div class="panel-body">
					<table class="table table-bordered">
						<tbody>
						<c:forEach begin="0" end="3" step="1" varStatus="status">
							<tr>
								<c:forEach items="${dtos }" var="dto" begin="${status.index * 8 }" end="${(status.index + 1) * 8 - 1}" step="1">
									<c:if test="${dto.hasMeeting == 1 }">
										<td class="hold">
											<a href="/meeting/room/day/${dto.day }" style="text-decoration: none">${dto.index }</a><br>
										</td>
									</c:if>
									<c:if test="${dto.hasMeeting == 0 }">
										<td>
											<a href="/meeting/room/day/${dto.day }" style="text-decoration: none">${dto.index }</a>
										</td>
									</c:if>
								</c:forEach>
							</tr>
						</c:forEach>
						</tbody>
					</table>
				</div>
			</div>
		</div>
	</div>
</body>
</html>