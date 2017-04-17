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
<script type="text/javascript" src="../../resources/js/name_input_valid.js"></script>
<script type="text/javascript">
		$(function() {
			var v = "${meetingRoom.number }";
			name_valid.init(v);
			$("#change").click(function() {
				var val = $("#photo").val();
				if(val.length == 0) {
					common.remind("�ļ�����Ϊ�գ�")
					return false;
				}
				var idx = val.lastIndexOf(".");
				if(idx == -1) {
					common.remind("�ļ���Ч");
					return false;
				}
				var suffix = val.substring(idx + 1, val.length);
				if(common.validPhoto(suffix) == 0) {
					common.remind("ͼ���ļ�ֻ��Ϊjpg, jpng, png����");
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
				<h3>�޸Ļ�����</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
						<form:form modelAttribute="meetingRoom" method="post" class="form">
							<input type="hidden" name="_method" value="PUT">
							<input type="hidden" name="index" value="${param.index }">
							<div class="form-group">
								<label class="label-control">���</label>
								<form:input path="number" class="form-control name" />
							</div>
							<div class="form-group">
								<label class="label-control">�ص�</label>
								<form:input path="location" class="form-control input" />
							</div>
							<div class="form-group">
								<label class="label-control">����</label>
								<form:input path="capacity" class="form-control input"/>
							</div>
							<button class="btn btn-primary pull-right" id="submit44">ȷ��</button>
						</form:form>
				</div>
				<div style="float:right">
					<h4>��Ƭ</h4>
					<img src="/meeting/common/${meetingRoom.photo }/photo" class="img" style="width: 200px; height: 200px">
					<form action="/meeting/common/photo2" method="post" enctype="multipart/form-data">
						<input type="hidden" name="table" value="3">
						<input type="hidden" name="index" value="${param.index }">
						<input type="hidden" name="id" value="${meetingRoom.id }">
						<input type="hidden" name="file" value="${meetingRoom.photo }">
						<input type="file" name="photo" style="margin-top: 30px" id="photo">
						<button type="submit" class="btn btn-primary pull-right" id="change" style="margin-top: 20px">������Ƭ</button>
					</form>
				</div>
						
			</div>
		</div>
	</div>
</body>
</html>
