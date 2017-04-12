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
<script type="text/javascript" src="../../resources/js/input_valid.js"></script>
<script type="text/javascript" src="../../resources/js/table.js"></script>
<script type="text/javascript" src="../../resources/js/page2.js"></script>
<script type="text/javascript">
	$(
			function() {
				CalendarHandler.initialize(0, 0, 0);
				var meetingId = "${meeting.id }";
				valid.init(meetingId.length == 0 ? 0 : meetingId);
				var total = "${sessionScope.totalPage }";
// 				var total = 10;
				page.init(6, 1, total, "");
				t.init(1);
				$("#toFirst").click(function() {
					var tag = $("#tag");
					tag.val(1);
				});
				$("#room").change(function() {
					var sIndex = this.selectedIndex;
					var meetingRoomId = this.options[sIndex].value;
					$.get("/meeting/room/capacity", {
						id : meetingRoomId
					}, function(data) {
						$("#capacity").html("�����ҵ�����Ϊ��" + data);
					})
				});
				
				$(".pageItem2").click(function(){
					var href = $(this).find("a").attr("href");
					var index = href.substring(href.lastIndexOf("=") + 1);
					initlizePageItem(index, total);
					t.init(index);
					return false;
				});
				
				$("#next").click(function(){
					var pageContent = $("#pageContent2");
					var lis = pageContent.find("li");
					var index2 = 0;
					for(var i = 1; i < lis.length - 2; i++) {
						var clazz = lis.eq(i).attr("class");
						if(clazz.length > 10) {
							index2 = i;
							break;
						}
					}
					if(index2 != total) {
						initlizePageItem(index2 + 1, total);
						t.init(index2 + 1);
					}
					return false;
				});
				
				$("#previous").click(function(){
					var pageContent = $("#pageContent2");
					var lis = pageContent.find("li");
					var index2 = 0;
					for(var i = 1; i < lis.length - 2; i++) {
						var clazz = lis.eq(i).attr("class");
						if(clazz.length > 10) {
							index2 = i;
							break;
						}
					}
					if(index2 != 1) {
						initlizePageItem(index2 - 1, total);
						t.init(index2 - 1);
					}
					return false;
				});
				$("#forward").click(function(){
					var val = $("#forwardPage").val();
					$("#forwardPage").val("");
					initlizePageItem(val, total);
					t.init(val);
					return false;
				});
				
				function initlizePageItem(index, total) {
					var pageContent = $("#pageContent2");
					var lis = pageContent.find("li");
					for(var i = 1; i < lis.length - 2; i++) {
						lis.eq(i).removeClass("active");
					}
					if(total <= 6) {
						for(var i = 1; i < lis.length - 2; i++) {
							if(i == index){
								lis.eq(i).addClass("active");
							}
						}
					}else {
						if(index > 4 && index <= total - 2) {
							for(var i = 1; i < lis.length - 2; i++) {
								var val = index - 4 + i;
								lis.eq(i).find("a").html("" + val).attr("href", "=" + val);
								if(val == index) {
									lis.eq(i).addClass("active");
								}
							}
						}else{
							if(index <= 4){
								for(var i = 1; i < lis.length - 2; i++) {
									lis.eq(i).find("a").html("" + i).attr("href", "=" + i);
									if(i == index) {
										lis.eq(i).addClass("active");
									}
								}
							}else {
								if(index > total - 2) {
									for(var i = lis.length - 3; i >= 1; i--) {
										lis.eq(i).find("a").html("" + (total - (6 - i))).attr("href", "=" + (total - 6 + i));
										if((total - 6 + i) == index) {
											lis.eq(i).addClass("active");
										}
									}
								}
							}
						}
					}
				};
				
				
			})
</script>
<style type="text/css">
td {
	width: 12.5%;
	height: 50px;
}
	.hold{
		background-color: #e6b8af;
	}
</style>
</head>

<body>
	<%@include file="../nav.jsp"%>
	<div class="main" style="margin-top: 50px">
		<div class="nav_middle" style="float:left;">
			<div class="nav_middle_top">
				<%@include file="../calendar.jsp"%>
			</div>
			<%@include file="../notice.jsp"%>
		</div>
		<div class="container col-lg-9" style=" padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>2.ѡ�������</h3>
				</div>
				<div class="panel-body">
					<form action="/meeting/manager/meeting/third1" method="post"
						class="form col-lg-7" id="form">
						<input type="hidden" name="tag" value="0" id="tag"> <label
							style="float:right" id="capacity"> ����������Ϊ�� <c:if
								test="${meeting.meetingRoom == null}">
								<c:forEach items="${meetingRooms }" var="meetingRoom" begin="0"
									end="0">
									${meetingRoom.capacity }
								</c:forEach>
							</c:if> <c:if test="${meeting.meetingRoom != null }">
								<c:forEach items="${meetingRooms }" var="meetingRoom">
									<c:if test="${meetingRoom.id == meeting.meetingRoom.id }">
										${meetingRoom.capacity }
									</c:if>
								</c:forEach>
							</c:if>
						</label>
						<div class="form-group">
							<label class="control-label">������</label> <select
								class="form-control" id="room" name="meetingRoom.id">
								<c:forEach items="${meetingRooms }" var="meetingRoom">
									<c:if test="${meetingRoom.id == meeting.meetingRoom.id }">
										<option value="${meetingRoom.id }" selected="selected">${meetingRoom.number }</option>
									</c:if>
									<c:if test="${meetingRoom.id != meeting.meetingRoom.id }">
										<option value="${meetingRoom.id }">${meetingRoom.number }</option>
									</c:if>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<div class="form-group">
								<label class="control-label">��ʼʱ��:</label> 
								<c:if test="${startTimeStr != null}">
									<input
									value="${startTimeStr }" class="datainp form-control"
									name="startTimeStr" id="start"
									onfocus="jeDate({dateCell:'#start',isTime:true,format:'YYYY/MM/DD hh:mm'})"
									readonly="readonly" required="required" />
								</c:if>
								<c:if test="${startTimeStr == null}">
									<input
									value="${sessionScope.adviceStart }" class="datainp form-control"
									name="startTimeStr" id="start"
									onfocus="jeDate({dateCell:'#start',isTime:true,format:'YYYY/MM/DD hh:mm'})"
									readonly="readonly" required="required" />
								</c:if>
							</div>
						</div>
						<div class="form-group">
							<div class="form-group">
								<label class="control-label">����ʱ��:</label> 
								<c:if test="${endTimeStr != null}">
									<input
									name="endTimeStr" value="${endTimeStr }"
									class="datainp form-control" id="end"
									onfocus="jeDate({dateCell:'#end',isTime:true,format:'YYYY/MM/DD hh:mm'})"
									readonly="readonly" required="required" />
								</c:if>
								<c:if test="${endTimeStr == null}">
									<input
									name="endTimeStr" value="${sessionScope.adviceEnd }"
									class="datainp form-control" id="end"
									onfocus="jeDate({dateCell:'#end',isTime:true,format:'YYYY/MM/DD hh:mm'})"
									readonly="readonly" required="required" />
								</c:if>
							</div>
						</div>
						<div class="form-group">
							<label class="control-label">����</label> <input
								class="form-control" name="title" value="${meeting.title }" id="title2">
						</div>
						<div class="pull-right">
							<button class="btn btn-primary" type="submit" id="toFirst">��һ��</button>
							<button class="btn btn-primary" type="submit" id="ok">��һ��</button>
						</div>
					</form>
					<div class="well col-lg-5" style="float: left">
						<h4>�λ�����Ϊ:${sessionScope.invitationCount }&nbsp;&nbsp;&nbsp;</h4>
						<h4>�����¼����Ϊ:${sessionScope.recordCount }&nbsp;&nbsp;&nbsp;</h4>
						<h4>���鿪��ʱ��Ϊ��<br>
							<c:if test="${sessionScope.adviceMeetingRooms == null }">
								δ������û�к��ʵĿ���ʱ��
							</c:if>
							<c:if test="${sessionScope.adviceMeetingRooms != null }">
								${sessionScope.adviceStart }----${sessionScope.adviceEnd }
							</c:if>
						</h4>
						<h4>
							���õĻ�����Ϊ��<br>
							<c:if test="${sessionScope.adviceMeetingRooms == null }">
								δ������û�к��ʵĻ�����
							</c:if>
							<c:if test="${sessionScope.adviceMeetingRooms != null }">
								<c:forEach items="${sessionScope.adviceMeetingRooms }" var="room">
									${room.number }&nbsp;&nbsp;&nbsp;&nbsp;
								</c:forEach>
							</c:if>
						</h4>
					</div>
				</div>
				<div class="panel-footer">
					<h4>�λ���Աδ��������ճ̰������£�</h4>
					<div style="float:right; margin-top: -30px">
						<ul class="pagination" id="pageContent2" style="float:left; margin-top: -5px">
						</ul>
					</div>
					<table class="table table-bordered table-hover" id="table">
						<tr>
							<th>�λ���Ա</th>
							<th>1</th>
							<th>2</th>
							<th>3</th>
							<th>4</th>
							<th>5</th>
							<th>6</th>
							<th>7</th>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
						<tr>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
							<td></td>
						</tr>
					</table>

				</div>
			</div>
		</div>
	</div>



</body>
<script type="text/javascript">
	//jeDate.skin('gray');
	jeDate({
		dateCell : "#indate",//isinitVal:true,
		format : "YYYY-MM",
		isTime : false, //isClear:false,
		minDate : "2015-10-19 00:00:00",
		maxDate : "2016-11-8 00:00:00"
	})
	jeDate({
		dateCell : "#dateinfo",
		format : "YYYY��MM��DD�� hh:mm:ss",
		isinitVal : true,
		isTime : true, //isClear:false,
		minDate : "2014-09-19 00:00:00",
		okfun : function(val) {
			alert(val)
		}
	})
</script>

</html>
