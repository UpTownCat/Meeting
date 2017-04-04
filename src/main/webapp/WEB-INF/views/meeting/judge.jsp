<%@ page language="java" import="java.util.*" pageEncoding="GBK" isELIgnored="false"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "meeting");
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
<%@include file="../common2l.jsp" %>
<script type="text/javascript">
	$(function() {
		var index = "${page.index }";
		console.log(index);
		var url = "/meeting/meeting/judge";
		var total = "${page.total }";
		page.init(6, index, total, url);
		$("#forward").click(function(){
			page.forward(total, url);
		});
		CalendarHandler.initialize(0, 0, 0);
		$(".pageItem").click(function(){
			var index2 = $(this).html();
			var regex = /\D/;
			if(regex.test(index2)) {
				var href = $(this).attr("href");
				if(href == undefined)
				return false;
			}
			var form = $("#form");
			index2 = $(this).attr("href").substring(29);
			var toIndex = $("#toIndex");
			toIndex.val(index2);
			form.submit();
			return false;
		});
		var url2 = "";
		$("#myModal").on('show.bs.modal', function (event) {
			  var button = $(event.relatedTarget);
			  var value = button.data('whatever'); 
			  console.log("111");
			  var index2 = value.indexOf(",");
			  var index3 = value.indexOf(".");
			  var id2 = value.substring(0, index2);
			  var title2 = value.substring(index2 + 1, index3);
			  url2 = "/meeting/meeting/" + id2 + "/" + value.substring(index3 + 1);
			  $("#msg").html("您确定要" + title2);
			});
		$("#ok").click(function() {
			var args = {_method : "PUT"};
			$("#msg").html("正在处理... 请勿刷新页面");
			$("#myForm").attr("action", url2).submit();
		});
		
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
		<div class="main" style="margin-top:50px">
			<div class="nav_middle" style="float:left;">
				<%@include file="../menu.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>会议审核</h3> 
				</div>
				<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="会议主题" value="${page.searchContent }">
				     </div>
				     <div class="form-group">
				     	<label>时间选择:</label>
				     	<select class="form-control" name="time">
				     		<c:if test="${page.time == 0 }">
					     		<option value="0">默认</option>
					     		<option value="3">预约时间由大到小</option>
					     		<option value="4">预约时间由小到大</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 1 }">
					     		<option value="0">默认</option>
					     		<option value="3">预约时间由大到小</option>
					     		<option value="4">预约时间由小到大</option>
					     		<option value="1" selected="selected">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 2 }">
					     		<option value="0">默认</option>
					     		<option value="3">预约时间由大到小</option>
					     		<option value="4">预约时间由小到大</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2" selected="selected">开始时间由小到大</option>
					     	</c:if>	
					     	<c:if test="${page.time == 3 }">
					     		<option value="0">默认</option>
					     		<option value="3" selected="selected">预约时间由大到小</option>
					     		<option value="4">预约时间由小到大</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
					     	<c:if test="${page.time == 4 }">
					     		<option value="0">默认</option>
					     		<option value="3">预约时间由大到小</option>
					     		<option value="4" selected="selected">预约时间由小到大</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-info">搜索</button>
			    </form>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>主题</th>
								<th>经理</th>
								<th>会议室</th>
								<th>预约时间</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th>是否批准</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${meetings }" var="meeting">
								<tr>
									<td>${meeting.title }</td>
									<td>${meeting.manager.name }</td>
									<td>${meeting.meetingRoom.number }</td>
									<td>
										<fmt:formatDate value="${meeting.appointmentTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<c:if test="${meeting.isPass == 2 }">
											<a class="btn btn-primary" href="#myModal" data-toggle="modal" data-whatever="${meeting.id },同意主题为: << ${meeting.title } >> 的会议吗?(同一个时间段和会议室的其他会议将预约失败).agree">同意</a>
											<a class="btn btn-primary" href="#myModal" data-toggle="modal" data-whatever="${meeting.id },不同意主题为: << ${meeting.title } >>的会议吗?.disagree">不同意</a>
										</c:if>
										<c:if test="${meeting.isPass == 1 }">
											<a class="btn btn-primary" disabled="true">已同意</a>
										</c:if>
										<c:if test="${meeting.isPass == 0 }">
											<a class="btn btn-primary" disabled="true">不同意</a>
										</c:if>
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="../page.jsp" %>
				</div>
			</div>
		</div>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	       				<h4 class="modal-title">会议审核</h4>
					</div>
					<div class="modal-body">
						<p id="msg"></p>
					</div>
					 <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
				        <button type="button" class="btn btn-primary" id="ok">确定</button>
				      </div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>
