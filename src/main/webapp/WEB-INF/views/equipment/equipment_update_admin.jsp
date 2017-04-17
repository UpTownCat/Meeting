<%@ page language="java" import="java.util.*" pageEncoding="GBK" isELIgnored="false"%>
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
<script type="text/javascript">
		$(function() {
			var t1 = 1;
			var n = "${equipment.name }";
			$(".name").blur(function() {
				var val = this.value;
				if(n == val) {
					t1 = 1;
					return false;
				}
				if(val.length == 0) {
					common.remind("设备名字不能为空！");
					t1 = 0;
					return false;
				}
				val = encodeURI(val);
				$.get("/meeting/common/name", {"tag": 5, "name": val}, function(data) {
					if(data != 0) {
						t1 = 2;
						common.remind("该名称的设备已经存在！");
					}else {
						t1 = 1;
					}
				})
			})
			
			$("#submit44").click(function() {
				if(t1 == 0) {
					common.remind("设备名字不能为空！");
					return false;
				}
				if(t1 == 2) {
					common.remind("该名称的设备已经存在！");
					return false;
				};
				var count = $("#count").val();
				if(count.length == 0) {
					common.remind("信息不完整！");
					return false;
				}
				var reg = /^\+?[1-9][0-9]*$/;
				if(!reg.test(count)) {
					common.remind("输入的不是正整数！");
					return false;
				}
			})
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
				<h3>修改设备</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
					<form:form modelAttribute="equipment" method="post" class="form">
						<input type="hidden" name="_method" value="PUT">
						<input type="hidden" name="index" value="${index }">
						<div class="form-group">
							<label class="label-control">名称</label>
							<form:input path="name" class="form-control name" />
						</div>
						<div class="form-group">
							<label class="label-control">数量</label>
							<form:input path="count" class="form-control" id="count" />
						</div>
						<button class="btn btn-primary" id="submit44">确定</button>
					</form:form>
				</div>
						
			</div>
		</div>
	</div>


</body>
</html>
