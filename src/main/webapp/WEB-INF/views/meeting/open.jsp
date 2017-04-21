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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common2l.jsp"%>
<script type="text/javascript">
	$(function() {
		common.init("meeting", "");
		var index = "${page.index }";
		var url = "/meeting/meeting/open";
		var total = "${page.total }";
		page.init(6, index, total, url);
		$("#forward").click(function(){
			var index2 = $("#forwardPage").val();
			var form = $("#form");
			var toIndex = $("#toIndex");
			toIndex.val(index2);
			form.submit();
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
			var href1 = $(this).attr("href");
			index2 = href1.substring(href1.lastIndexOf("=") + 1);
			var toIndex = $("#toIndex");
			toIndex.val(index2);
			form.submit();
			return false;
		})
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
			<div class="nav_middle" style="float:left;margin-top:50px;">
				<div class="nav_middle_top">
					<%@include file="../calendar.jsp" %>
				</div>
				<%@include file="../notice.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left;margin-top:50px; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>会议列表</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/open" id="form">
					<input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="会议主题" value="${page.searchContent }">
				     </div>
				     <c:if test="${role == 2 }">
					     <div class="form-group">
					     	<label>会议预约:</label>
					     	<select class="form-control" name="appointment">
					     		<c:if test="${page.appointment == 0 }">
					     			<option value="0">默认</option>
						     		<option value="1">预约通过</option>
						     		<option value="2">预约失败</option>
						     		<option value="3">审核中</option>
					     		</c:if>
					     		<c:if test="${page.appointment == 1 }">
					     			<option value="0">默认</option>
						     		<option value="1" selected="selected">预约通过</option>
						     		<option value="2">预约失败</option>
						     		<option value="3">未审核</option>
					     		</c:if>
					     		<c:if test="${page.appointment == 2 }">
					     			<option value="0">默认</option>
						     		<option value="1">预约通过</option>
						     		<option value="2" selected="selected">预约失败</option>
						     		<option value="3">未审核</option>
					     		</c:if>
					     		<c:if test="${page.appointment == 3 }">
					     			<option value="0">默认</option>
						     		<option value="1">预约通过</option>
						     		<option value="2">预约失败</option>
						     		<option value="3" selected="selected">未审核</option>
					     		</c:if>
					     	</select>
					     </div>
					  </c:if>
				      <div class="form-group">
				     	<label>会议状态:</label>
				     	<select class="form-control" name="state">
				     		<c:if test="${page.state == 0 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 3 }">
					     		<option value="0">默认</option>
					     		<option value="3" selected="selected">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 1 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1" selected="selected">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 2 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2" selected="selected">未召开</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <div class="form-group">
				     	<label>时间选择:</label>
				     	<select class="form-control" name="time">
				     		<c:if test="${page.time == 0 }">
					     		<option value="0">默认</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 1 }">
					     		<option value="0">默认</option>
					     		<option value="1" selected="selected">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 2 }">
					     		<option value="0">默认</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2" selected="selected">开始时间由小到大</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-default">搜索</button>
			    </form>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>主题</th>
								<th>会议室</th>
								<th>开始时间</th>
								<th>结束时间</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${meetings }" var="meeting">
								<tr>
									<td>${meeting.title }</td>
									<td>${meeting.meetingRoom.number }</td>
									<td>
										<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td><a href="/meeting/meeting/${meeting.id }/detail" class="btn btn-info detail">详情</a></td>
									<c:if test="${role == 2 }">
										<td>
											<c:if test="${meeting.isPass == 2 }">
												<a class="btn btn-default disabled">审核中</a>
											</c:if>
											<c:if test="${meeting.isPass == 1 }">
												<a class="btn btn-success discabled" disabled="true">预约通过</a>
											</c:if>
											<c:if test="${meeting.isPass == 0 }">
												<a class="btn btn-warning disabled" disabled="true">预约失败</a>
											</c:if>
										</td>
										<c:if test="${meeting.open == 0 }">
											<td><a href="/meeting/manager/meeting/first1?id=${meeting.id }" class="btn btn-primary">修改</a></td>
											<td><a href="#deleteModal" data-toggle="modal" data-whatever="${meeting.id},主题为： ' ${meeting.title } '  的会议" class="btn btn-danger">删除</a></td>
										</c:if>
										<c:if test="${meeting.open == 1 }">
											<td><a class="btn btn-primary disabled" >修改</a></td>
											<td><a class="btn btn-danger disabled" >删除</a></td>
										</c:if>
									</c:if>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="../page.jsp" %>
				</div>
			</div>
		</div>

	<div class="modal fade" id="deleteModal" role="dialog" tabindex="-1">
		<div class="modal-dialog">
			<div class="modal-content">
				<div calss="modal-header"></div>
				<div class="modal-body">
					<h3 id="msg" class="danger"></h3>
				</div>
				<div class="modal-footer">
					<button type="button" class="btn btn-primary" data-dismiss="modal">取消</button>
					<button type="button" class="btn btn-danger" id="delete">确定</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
