<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "equipment");
%>

<!DOCTYPE html>
<html>
<head>

<title>My JSP 'update.jsp' starting page</title>

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
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>修改会议室设备</h3>
			</div>
			<div class="panel-body">
				<form:form modelAttribute="equipment" method="post"
					class="form-inline">
					<input type="hidden" name="_method" value="PUT">
					<input type="hidden" name="index" value="${index }">
					<div class="form-group">
						<label class="label-control">名称</label>
						<form:input path="name" class="form-control" />
					</div>
					<div class="form-group">
						<label class="label-control">数量</label>
						<form:input path="count" class="form-control" />
					</div>
					<button class="btn btn-primary">确定</button>
				</form:form>
			</div>
		</div>
	</div>
</body>
</html>
