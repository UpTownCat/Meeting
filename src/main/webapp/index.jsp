<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
  <head>
    
    <title>My JSP 'index.jsp' starting page</title>
    
	<meta http-equiv="pragma" content="no-cache">
	<meta http-equiv="cache-control" content="no-cache">
	<meta http-equiv="expires" content="0">    
	<meta http-equiv="keywords" content="keyword1,keyword2,keyword3">
	<meta http-equiv="description" content="This is my page">
	<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
	<link rel="stylesheet" type="text/css" href="resources/css/bootstrap.min.css">
	<script type="text/javascript" src="resources/js/jquery-1.9.1.min.js"></script>
	<script type="text/javascript" src="resources/js/bootstrap.min.js"></script>
	<script type="text/javascript" src="resources/js/page.js"></script>
	<script type="text/javascript">
		$(function() {
			var tag = 1;
			var index = "${index }";
			page.init(6, 1, 3, "/meeting/test");
			var arr = ["早上:", "下午:", "晚上:"];
			$("#test").click(function(){
				var table = $("#table");
				var trs = table.find("tr");
				$.ajax({url:"/meeting/invitation/recent", data : {page : 1},  aysnc:false, success:function(data){
					console.log(data.length);
					for(var i = 0; i < data.length; i++) {
						var tds = trs.eq(i + 1).find("td");
						var userInvitationDto = data[i];
						console.log(userInvitationDto.name);
						var dayInvitationDtos = userInvitationDto.dayInvitationDtos;
						tds.eq(0).html(userInvitationDto.name);
						for(var j = 0; j < dayInvitationDtos.length; j++) {
							var dayInvitationDto = dayInvitationDtos[j];
							if(dayInvitationDto.hasMeeting == 0) {
								continue;
							}
							var td = tds.eq(j + 1);
							var str = "";
							var dtos = dayInvitationDto.dtos;
							for(var l = 0; l < dtos.length; l++) {
								var dto = dtos[l];
								if(dto.id != 0) {
									str += arr[l];
									str += dto.title;
									str += "</br>"
								}
							}
							console.log(str);
							td.html(str);
					}
					}
				}})
			})
			
		})
	</script>
	<style type="text/css">
		td{
			width : 12.5%;
			height: 50px;
		}
	</style>
  </head>
  
  <body>
	<ul class="pagination" id="pageContent">
 	</ul>
 	
 	<div class="container">
 		<form class="form" action="/meeting/common/login" method="post">
 			<div class="form-group">
 				<label class="control-lable">手机号</label>
 				<input type="text" name="phone" class="form-control">
 			</div>
 			<div class="form-group">
 				<label class="control-lable">密码</label>
 				<input type="text" name="password" class="form-control">
 			</div>
 			<div class="form-group">
				<div class="radio">
					<label> <input type="radio" name="tag"
						id="optionsRadios1" value="1" checked> 员工
					</label>
				</div>
				<div class="radio">
					<label> <input type="radio" name="tag"
						id="optionsRadios2" value="2"> 部门经理
					</label>
				</div>
				<div class="radio">
					<label> <input type="radio" name="tag"
						id="optionsRadios3" value="3"> 管理员
					</label>
				</div>
			</div>
			<button type="submit" class="btn btn-primary" id="btn">登陆</button>
 		</form>
 			<button type="button" class="btn btn-danger" id="test">Test</button>
 	</div>
	<table class="table table-bordered table-hover text-center" id="table">
		<tr>
			<th>参会人员</th>
			<th>1</th>
			<th>2</th>
			<th>3</th>
			<th>4</th>
			<th>5</th>
			<th>6</th>
			<th>7</th>
		</tr>
		<tr>
			<td></td>
			<td></td>
			<td></td>
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
			<td></td>
			<td></td>
			<td></td>
		</tr>
	</table>

</body>
</html>
