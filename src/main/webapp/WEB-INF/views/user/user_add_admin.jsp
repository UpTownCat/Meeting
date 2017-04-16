<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<%@include file="../common2l.jsp"%>
<script type="text/javascript">
	$(function() {
		common.init("", "");
		$('#email1').autoMail(
				{
					emails : [ 'qq.com', '163.com', '126.com', 'sina.com',
							'sohu.com', 'yahoo.cn' ]
				});
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>增加员工</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
						<form method="post" class="form" enctype="multipart/form-data">
							<input type="hidden" name="index" value="${param.index }">
							<div class="form-group">
								<label class="label-control">姓名</label>
								<input name="name" class="form-control" />
							</div>
							<div class="form-group">
								<label class="label-control">电话</label>
								<input name="phone" class="form-control" />
							</div>
							<div class="form-group">
								<label class="label-control">邮箱</label>
								<input name="email" class="form-control" id="email1"/>
							</div>
							<div class="form-group">
								<label class="label-control">密码</label>
								<input type="password" class="form-control" id="password"/>
								<input type="hidden" name="password" id="real_password">
							</div>
							<div class="form-group">
								<label class="label-control">部门</label>
								<select name="departmentId" class="form-control">
									<c:forEach items="${departments }" var="department">
										<option value="${department.id }">${department.name }</option>
									</c:forEach>
								</select>
							</div>
							<div class="form-group">
								<label class="label-control">照片</label>
								<input type="file" name="photo" id="fileInput">
							</div>
							<button class="btn btn-primary pull-right" id="submit">确定</button>
						</form>
				</div>
				<%@include file="../preview_img.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>
