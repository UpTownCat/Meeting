<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%
	String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>

<title>My JSP 'test.jsp' starting page</title>

<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="cache-control" content="no-cache">
<meta http-equiv="expires" content="0">
<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
<meta http-equiv="description" content="This is my page">
<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
<script type="text/javascript" src="resources/js/page.js"></script>
<script type="text/javascript">
	$(function() {
		var index = "${index }";
		var url = "/meeting/test";
		var total = 100;
		page.init(6, index, total, url);
		$("#forward").click(function(){
			page.forward(total, url);
		})
		
		$("#btn").click(function() {
			$.get("/meeting/testJson", {time : new Date()}, function(data) {
				var select = $("#select");
				for(var i = 0; i < data.users.length; i++) {
					select.append("<option>" + data.users[i].name + "</option>")
				}
			});
		})
		
	})
</script>
</head>

<body>
	<ul class="pagination" id="pageContent">
	</ul>
	<button class="btn btn-primary" id="btn">≤‚ ‘</button>
	<select class="form-control" id="select">
	</select>
</body>
</html>
