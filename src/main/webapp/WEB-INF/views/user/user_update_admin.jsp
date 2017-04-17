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
<%@include file="../common3l.jsp"%>
<script type="text/javascript" src="../../resources/js/user_input_valid.js"></script>
<script type="text/javascript">
		$(function() {
			common.init("", "");
			var p1 = "${user.phone }";
			var e1 = "${user.email }";
			userInput.init(1, 1, p1, e1);
			CalendarHandler.initialize(0, 0, 0);
			$('#email1').autoMail({
				emails:['qq.com','163.com','126.com','sina.com','sohu.com','yahoo.cn']
			});
			$("#change").click(function() {
				var val = $("#photo").val();
				if(val.length == 0) {
					common.remind("文件不能为空！")
					return false;
				}
				var idx = val.lastIndexOf(".");
				if(idx == -1) {
					common.remind("文件无效");
					return false;
				}
				var suffix = val.substring(idx + 1, val.length);
				if(common.validPhoto(suffix) == 0) {
					common.remind("图像文件只能为jpg, jpng, png类型");
					return false;
				}
			})
			
		})
		
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<c:if test="${sessionScope.role == 3 }">
			<%@include file="../menu.jsp" %>
		</c:if>
		
		<c:if test="${sessionScope.role != 3 }">
			<%@include file="../calendar.jsp" %>
			<%@include file="../notice.jsp" %>
		</c:if>
		
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<c:if test="${sessionScope.role == 3 }">
					<h3>修改员工</h3>
				</c:if>
				<c:if test="${sessionScope.role != 3 }">
					<h3>修改个人信息</h3>
				</c:if>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
						<form:form modelAttribute="user" method="post" class="form">
							<input type="hidden" name="_method" value="PUT">
							<input type="hidden" name="index" value="${param.index == null ? "0" : param.index }">
							<div class="form-group">
								<label class="label-control">姓名</label>
								<form:input path="name" class="form-control input" />
							</div>
							<div class="form-group">
								<label class="label-control">电话</label>
								<form:input path="phone" class="form-control phone" />
							</div>
							<div class="form-group">
								<label class="label-control">邮箱</label>
								<form:input path="email" class="form-control email" id="email1"/>
							</div>
							<div class="form-group">
								<label class="label-control">性别</label>
								<br>
								<c:if test="${user.gender == 0 }">
									<input type="radio" name='gender' value="0" checked="checked"> 男
									<input type="radio" name='gender' value="1"> 女
								</c:if>
								<c:if test="${user.gender == 1 }">
									<input type="radio" name='gender' value="0"> 男
									<input type="radio" name='gender' value="1" checked="checked"> 女
								</c:if>
							</div>
							<c:if test="${sessionScope.role == 3 }">
								<div class="form-group">
									<label class="label-control">部门</label>
									<form:select path="department.id" items="${departments }"
										itemLabel="name" itemValue="id" class="form-control"></form:select>
								</div>
							</c:if>
							<button class="btn btn-primary pull-right" id="submit44">确定</button>
						</form:form>
				</div>
				<div style="float:right">
					<h4>照片</h4>
					<img src="/meeting/common/${user.photo }/photo" class="img" style="width: 200px; height: 200px">
					<form action="/meeting/common/photo2" method="post" enctype="multipart/form-data">
						<input type="hidden" name="table" value="1">
						<input type="hidden" name="id" value="${user.id }">
						<input type="hidden" name="file" value="${user.photo }">
						<input type="file" name="photo" style="margin-top: 30px" id="photo">
						<button type="submit" class="btn btn-primary pull-right" id="change" style="margin-top: 20px">更换照片</button>
					</form>
				</div>
						
			</div>
		</div>
	</div>
</body>
</html>
