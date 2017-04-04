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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common3l.jsp"%>
<script type="text/javascript" src="../../resources/js/jedate/jedate.js"></script>
</head>

<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>会议室${meetingRoom.number }</h3>
			</div>
			<div class="panel-body">
				<form action="/meeting/manager/${meetingRoom.id }/openMeeting" method="post" class="form col-lg-12">
					<div class="left" style="float: left;">
						<div class="row">
							<div class="col-lg-12">
								<label class="control-label">主题</label> <input
									class="form-control" name="title">
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="form-group">
									<label class="control-label">开始时间:</label> <input
										class="datainp form-control" name="startTime" id="datebut1"
										type="text"
										onfocus="jeDate({dateCell:'#datebut1',isTime:true,format:'YYYY/MM/DD hh:mm'})">
								</div>
							</div>
						</div>
						<div class="row">
							<div class="col-lg-12">
								<div class="form-group">
									<label class="control-label">结束时间:</label> <input
										class="datainp form-control" name="endTime" id="datebut2"
										type="text"
										onfocus="jeDate({dateCell:'#datebut2',isTime:true,format:'YYYY/MM/DD hh:mm'})">
								</div>
							</div>
						</div>
						<c:forEach items="${departments }" var="department">
							<h5>${department.name }</h5>
							<c:forEach items="${department.users }" var="user">
								<label class="checkbox-inline"> 
									<input type="checkbox" name="userIds" value="${user.id }"> ${user.name }
								</label>
							</c:forEach>
						</c:forEach>
						<button class="btn btn-primary" type="sumbit">确定</button>
					</div>
					<div class="righ" style="float:left; margin-left: 100px">	
						<button class="btn btn-primary" data-toggle="collapse" data-target="#collapse1" id="btn" type="button">
							选择器材<span id="icon" class="glyphicon glyphicon-chevron-down"></span>
						</button>
						<div class="collapse" id="collapse1">
							<div class="well">
								<table class="table table-striped">
									<thead>
										<tr>
											<th><input type="checkbox"></th>
											<th>器材</th>
											<th>总量</th>
											<th>使用数量</th>
										</tr>
									</thead>
									<tbody>
										<c:forEach items="${equipments }" var="equipment">
											<tr>
												<td><input type="checkbox" name="equipmentIds" value="${equipment.id }"></td>
												<td>${equipment.name }</td>
												<td>${equipment.count }</td>
												<td><input type="text" class="form-control" name="${equipment.id }"></td>
											</tr>
										</c:forEach>
									</tbody>
								</table>
							</div>
						</div>
					</div>	
					
				</form>
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
			format:"YYYY年MM月DD日 hh:mm:ss",
			isinitVal:true,
			isTime:true, //isClear:false,
			minDate:"2014-09-19 00:00:00",
			okfun:function(val){alert(val)}
		})
	
	</script>

</html>
