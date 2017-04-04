<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
<%
String path = request.getContextPath();
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

	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>修改部门</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
					<form:form modelAttribute="department" method="post" class="form">
						<input type="hidden" name="_method" value="PUT">
						<input type="hidden" name="index" value="${param.index }">
						<div class="form-group">
							<label class="control-label">名称</label>
							<form:input path="name" class="form-control" />
						</div>
						<div class="form-group">
							<label class="control-label">部门经理</label>
							<form:select path="manager.id" items="${managers }"
								itemLabel="name" itemValue="id" class="form-control"></form:select>
						</div>
						<button class="btn btn-primary">确定</button>
					</form:form>
				</div>
						
			</div>
		</div>
	</div>

</body>
</html>
