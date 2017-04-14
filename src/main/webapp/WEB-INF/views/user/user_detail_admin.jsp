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
			var index = "${page.index }";
			var total = "${page.total }";
			var url = "/meeting/user/list";
			page.init(6, index, total, url);
			$("#forward").click(function(){
				page.forward(total, url);
			});
			common.init("user", "吗");
		})
		
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<c:if test="${sessionScope.role == 3}">
			<%@include file="../menu.jsp" %>
		</c:if>
		<c:if test="${sessionScope.role != 3}">
			<%@include file="../calendar.jsp" %>
			<%@include file="../notice.jsp" %>
		</c:if>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>员工详情</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
					<table class="table table-bordered table-hover">
						<tbody>
							<tr>
								<td>姓名</td>
								<td>${user.name }</td>
							</tr>
							<tr>
								<td>电话</td>
								<td>${user.phone }</td>
							</tr>
							<tr>
								<td>邮箱</td>
								<td>${user.email }</td>
							</tr>
							<tr>
								<td>性别</td>
								<td>${user.gender == 0 ? "女" : "男" }</td>
							</tr>
							<tr>
								<td>部门</td>
								<td>${user.department.name }</td>
							</tr>
						</tbody>
					</table>
				</div>
				
				<div class="col-lg-3" style="float:left">
					<img alt="" src="/meeting/common/${user.photo }/photo" class="img" style="width: 200px; height: 200px">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
