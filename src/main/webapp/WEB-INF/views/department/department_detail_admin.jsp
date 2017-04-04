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
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>��������</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-9">
					<table class="table table-bordered table-striped">
						<tbody>
							<tr>
								<td>��������</td>
								<td>${department.name }</td>
							</tr>
							<tr>
								<td>���ž���</td>
								<td>${department.manager.name }</td>
							</tr>
							<tr>
								<td>���ž���绰</td>
								<td>${department.manager.phone }</td>
							</tr>
							<tr>
								<td>���ž�������</td>
								<td>${department.manager.email }</td>
							</tr>
						</tbody>
					</table>
					<div class="well">
						<h4>Ա����Ϣ</h4>
						<table class="table table-bordered table-striped">
							<tr>
								<th>����</th>
								<th>�绰</th>
								<th>����</th>
								<th>�Ա�</th>
								<th></th>
							</tr>
							<tr>
								<td>fsdfs</td>
								<td>fsdf</td>
								<td>fsdf</td>
								<td>fds</td>
								<td>fds</td>
							</tr>
							<tr>
								<td>fsdfs</td>
								<td>fsdf</td>
								<td>fsdf</td>
								<td>fds</td>
								<td>fds</td>
							</tr>
							<tr>
								<td>fsdfs</td>
								<td>fsdf</td>
								<td>fsdf</td>
								<td>fds</td>
								<td>fds</td>
							</tr>
							<tr>
								<td>fsdfs</td>
								<td>fsdf</td>
								<td>fsdf</td>
								<td>fds</td>
								<td>fds</td>
							</tr>
							<tr>
								<td>fsdfs</td>
								<td>fsdf</td>
								<td>fsdf</td>
								<td>fds</td>
								<td>fds</td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="col-lg-3" style="float:right">
					<h4>���ž�����Ƭ</h4>
					<img alt="" src="/meeting/common/${department.manager.photo }/photo" class="img" style="width: 200px; height: 200px">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
