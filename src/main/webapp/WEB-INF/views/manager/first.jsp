<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "manager");
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
<script type="text/javascript" src="../../resources/js/jedate/jedate.js"></script>
<%@include file="../common3l.jsp"%>
<script type="text/javascript">
$(function() {

	CalendarHandler.initialize(0, 0, 0);
	
})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="main" style="margin-top: 50px">
		<div class="nav_middle" style="float:left;">
			<div class="nav_middle_top">
				<%@include file="../calendar.jsp" %>
			</div>
			<%@include file="../notice.jsp" %>
		</div>
		
		<div class="container col-lg-9" style=" padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h4>1.ѡ�������</h4>
				</div>
				<div class="panel-body">
					<form:form action="/meeting/manager/meeting/second" method="post" class="form col-lg-8" modelAttribute="meeting">
							<div class="form-group">
								<label class="control-label">������</label>
								<form:select path="meetingRoom.id" items="${meetingRooms }" itemLabel="number" itemValue="id" class="form-control"></form:select>
							</div>
								<div class="form-group">
									<div class="form-group">
										<label class="control-label">��ʼʱ��:</label> 
										<input name="startTime" value="${startTimeStr }" class="datainp form-control" name="startTime" id="datebut1" onfocus="jeDate({dateCell:'#datebut1',isTime:true,format:'YYYY/MM/DD hh:mm'})" readonly="readonly" required="required"/>
									</div>
								</div>
								<div class="form-group">
									<div class="form-group">
										<label class="control-label">����ʱ��:</label> 
										<input name="endTime" value="${endTimeStr }" class="datainp form-control" id="datebut2" onfocus="jeDate({dateCell:'#datebut2',isTime:true,format:'YYYY/MM/DD hh:mm'})" readonly="readonly" required="required"/>
									</div>
								</div>
								<div class="form-group">
									<label class="control-label">����</label> 
									<input class="form-control" value="${meeting.title }" name="title">
								</div>
								<button class="btn btn-primary pull-right" type="submit">��һ��</button>
					</form:form>
				</div>
			</div>
		</div>
	</div>
	
	
	
	
	
	
	
	
	
	
	
	
	
	
</body>
<script type="text/javascript">
	    //jeDate.skin('gray');
		jeDate({
			dateCell:"#indate",//isinitVal:true,
			format:"YYYY-MM",
			isTime:false, //isClear:false,
			minDate:"2015-10-19 00:00:00",
			maxDate:"2016-11-8 00:00:00"
		})
	    jeDate({
			dateCell:"#dateinfo",
			format:"YYYY��MM��DD�� hh:mm:ss",
			isinitVal:true,
			isTime:true, //isClear:false,
			minDate:"2014-09-19 00:00:00",
			okfun:function(val){alert(val)}
		})
	
	</script>

</html>
