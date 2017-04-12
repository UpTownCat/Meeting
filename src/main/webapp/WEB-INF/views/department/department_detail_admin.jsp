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
<script type="text/javascript" src="../../resources/js/page2.js"></script>
<script type="text/javascript" src="../../resources/js/table2.js"></script>
<script type="text/javascript">
	$(function(){
		CalendarHandler.initialize(0, 0, 0);
		var total = "${total }";
		console.log(total);
		page.init(6, 1, total, "");
		t.init(1, 1);
		$(".pageItem2").click(function(){
			var href = $(this).find("a").attr("href");
			var index = href.substring(href.lastIndexOf("=") + 1);
			initlizePageItem(index, total);
			t.init(index);
			return false;
		});
		
		$("#next").click(function(){
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			var index2 = 0;
			for(var i = 1; i < lis.length - 2; i++) {
				var clazz = lis.eq(i).attr("class");
				if(clazz.length > 10) {
					index2 = i;
					break;
				}
			}
			if(index2 != total) {
				initlizePageItem(index2 + 1, total);
				t.init(index2 + 1);
			}
			return false;
		});
		
		$("#previous").click(function(){
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			var index2 = 0;
			for(var i = 1; i < lis.length - 2; i++) {
				var clazz = lis.eq(i).attr("class");
				if(clazz.length > 10) {
					index2 = i;
					break;
				}
			}
			if(index2 != 1) {
				initlizePageItem(index2 - 1, total);
				t.init(index2 - 1);
			}
			return false;
		});
		$("#forward").click(function(){
			var val = $("#forwardPage").val();
			$("#forwardPage").val("");
			initlizePageItem(val, total);
			t.init(val);
			return false;
		});
		
		function initlizePageItem(index, total) {
			var pageContent = $("#pageContent2");
			var lis = pageContent.find("li");
			for(var i = 1; i < lis.length - 2; i++) {
				lis.eq(i).removeClass("active");
			}
			if(total <= 6) {
				for(var i = 1; i < lis.length - 2; i++) {
					if(i == index){
						lis.eq(i).addClass("active");
					}
				}
			}else {
				if(index > 4 && index <= total - 2) {
					for(var i = 1; i < lis.length - 2; i++) {
						var val = index - 4 + i;
						lis.eq(i).find("a").html("" + val).attr("href", "=" + val);
						if(val == index) {
							lis.eq(i).addClass("active");
						}
					}
				}else{
					if(index <= 4){
						for(var i = 1; i < lis.length - 2; i++) {
							lis.eq(i).find("a").html("" + i).attr("href", "=" + i);
							if(i == index) {
								lis.eq(i).addClass("active");
							}
						}
					}else {
						if(index > total - 2) {
							for(var i = lis.length - 3; i >= 1; i--) {
								lis.eq(i).find("a").html("" + (total - (6 - i))).attr("href", "=" + (total - 6 + i));
								if((total - 6 + i) == index) {
									lis.eq(i).addClass("active");
								}
							}
						}
					}
				}
			}
		};
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<c:if test="${sessionScope.role == 3 }">
		<div class="left" style="float: left; margin-top: 50px">
			<%@include file="../menu.jsp" %>
		</div>
	</c:if>
	<c:if test="${sessionScope.role == 2 }">
		<div class="left" style="float: left; margin-top: 50px">
			<%@include file="../calendar.jsp" %>
			<%@include file="../notice.jsp"%>
		</div>
	</c:if>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>部门详情</h3>
			</div>
			<div class="panel-body">
				<div class="col-lg-9">
					<table class="table table-bordered table-striped">
						<tbody>
							<tr>
								<td>部门名字</td>
								<td>${department.name }</td>
							</tr>
							<tr>
								<td>部门经理</td>
								<td>${department.manager.name }</td>
							</tr>
							<tr>
								<td>部门经理电话</td>
								<td>${department.manager.phone }</td>
							</tr>
							<tr>
								<td>部门经理邮箱</td>
								<td>${department.manager.email }</td>
							</tr>
						</tbody>
					</table>
					<div class="well">
						<h4>员工信息</h4>
						<div style="float:right; margin-top: -30px">
							<ul class="pagination" id="pageContent2" style="float:left; margin-top: -5px">
							</ul>
						</div>
						<table class="table table-bordered table-striped" id="table">
							<tr>
								<th>姓名</th>
								<th>电话</th>
								<th>邮箱</th>
								<th>性别</th>
								<th></th>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
							<tr>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
								<td></td>
							</tr>
						</table>
					</div>
				</div>
				
				<div class="col-lg-3" style="float:right">
					<h4>部门经理照片</h4>
					<img alt="" src="/meeting/common/${department.manager.photo }/photo" class="img" style="width: 200px; height: 200px">
				</div>
			</div>
		</div>
	</div>
</body>
</html>
