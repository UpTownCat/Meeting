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
			$('#email1').autoMail({
				emails:['qq.com','163.com','126.com','sina.com','sohu.com','yahoo.cn']
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
				<h3>���ӻ�����</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
					<form class="form" action="/meeting/room/add" method="post" enctype="multipart/form-data">
						<div class="form-group">
							<label class="control-label">���</label> <input
								class="form-control" name="number" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">�ص�</label> <input
								class="form-control" name="location" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">����</label> <input
								class="form-control" name="capacity" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">��Ƭ</label> <input name="photo" type="file" id="fileInput">
						</div>
						<button class="btn btn-primary" type="submit">ȷ��</button>
					</form>
				</div>
				<%@include file="../preview_img.jsp" %>
			</div>
		</div>
	</div>
</body>
</html>
