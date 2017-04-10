<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%
	String path = request.getContextPath();
	pageContext.setAttribute("partName", "manager");
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
<%@include file="../common3l.jsp"%>
<style type="text/css">
	td{
		width:20%;
	}
</style>
<script type="text/javascript">
	$(function() {
		CalendarHandler.initialize(0, 0, 0);
		var records = "${records }";
		console.log(records);
		$(".choose").click(function(){
			var index = this.selectedIndex;
			var departmentId = this.options[index].value;
			var id = $(this).attr("name");
			var sub = $("#u" + id.substring(1));
			sub.empty();
			if(departmentId > 0) {
				$.get("/meeting/user/" + departmentId + "/department", {}, function(data){
					for(var i = 0; i < data.length; i++) {
						sub.append("<option value='" + data[i].id +  "'>" + data[i].name + "</option>");
					}
				})
			}
		});
		$(".all").click(function() {
			if(this.checked) {
				var subCheckboxs = $("." + $(this).attr("name"));
				subCheckboxs.prop("checked", true);
			}else {
				var subCheckboxs = $("." + $(this).attr("name"));
				subCheckboxs.prop("checked", false);
			}
		})
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp"%>
	<div class="main" style="margin-top: 50px">
		<div class="nav_middle" style="float:left;">
			<div class="nav_middle_top">
				<%@include file="../calendar.jsp"%>
			</div>
			<%@include file="../notice.jsp"%>
		</div>

		<div class="container col-lg-9" style=" padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>1.选择参会人员和会议记录人</h3>
				</div>
				<div class="panel-body">
					<form class="form col-lg-9" action="/meeting/manager/meeting/second1" method="post">
						<div class="row" style="float:left; width: 100%">
					  <ul class="nav nav-tabs" role="tablist">
					  	<c:forEach items="${departments }" var="department" varStatus="status">
					  		<c:if test="${status.index == 0 }">
						    	<li role="presentation" class="active">
						    		<a href="#department${department.id }" role="tab" data-toggle="tab">
						    			${department.name }
						    		</a>
						    	</li>
					  		</c:if>
					  		<c:if test="${status.index != 0 }">
						    	<li role="presentation"><a href="#department${department.id }" role="tab" data-toggle="tab">${department.name }</a></li>
					  		</c:if>
					  	</c:forEach>
					  </ul>
					
					  <!-- Tab panes -->
					  <div class="tab-content">
					  	<c:forEach items="${departments }" var="department" varStatus="status">
					  		<c:if test="${status.index == 0 }">
						  		<div role="tabpanel" class="tab-pane active" id="department${department.id }">
						  			<table class="table table-bordered">
						  				<tbody>
						  					<tr>
						  						<td><input type="checkbox" class="all" name="d${department.id }">全选</td>
						  					</tr>
						  					<c:forEach begin="0" end="${department.size % 5 == 0 ? department.size / 5 : department.size / 5 + 1 }" varStatus="status">
						  						<tr>
						  							<c:if test="${invitations == null }">
						  								<c:forEach items="${department.users }" var="user" begin="${status.index * 5 }" end="${(status.index - 0 + 1) * 5 - 1 }">
											  				<td>
											  					<input type="checkbox" name="userIds" value="${user.id }" class="d${department.id }" >
											  					<c:if test="${user.password == null }">
											  						${user.name }(部门经理)
											  					</c:if>
											  					<c:if test="${user.password != null }">
											  						${user.name }
											  					</c:if>
											  				</td>
											  			</c:forEach>
						  							</c:if>
						  							
						  							<c:if test="${invitations != null }">
						  								<c:forEach items="${department.users }" var="user" begin="${status.index * 5 }" end="${(status.index - 0 + 1) * 5 - 1 }">
						  									<c:set var="tag" scope="request" value="0"></c:set>
						  									<c:forEach items="${invitations }" var="invitation">
						  										<c:if test="${user.id == invitation.user.id }">
						  											<c:set var="tag" scope="request" value="1"></c:set>
						  										</c:if>	
						  									</c:forEach>
						  									<td>
						  										<c:if test="${tag == 1 }">
						  											<input type="checkbox" name="userIds" value="${user.id }" checked="checked" class="d${department.id }">
												  					<c:if test="${user.password == null }">
												  						${user.name }(部门经理)
												  					</c:if>
												  					<c:if test="${user.password != null }">
												  						${user.name }
												  					</c:if>
						  										</c:if>
						  										<c:if test="${tag == 0 }">
						  											<input type="checkbox" name="userIds" value="${user.id }" class="d${department.id }">
												  					<c:if test="${user.password == null }">
												  						${user.name }(部门经理)
												  					</c:if>
												  					<c:if test="${user.password != null }">
												  						${user.name }
												  					</c:if>
						  										</c:if>
						  									</td>
						  								</c:forEach>
						  							</c:if>
						  						</tr>
						  					</c:forEach>
						  				</tbody>
						  			</table>
						  			
						  		</div>
						  	</c:if>
					  		<c:if test="${status.index != 0 }">
						  		<div role="tabpanel" class="tab-pane" id="department${department.id }">
						  			<table class="table table-bordered">
						  				<tbody>
						  					<tr>
						  						<td><input type="checkbox" class="all" name="d${department.id }">全选</td>
						  					</tr>
						  					<c:forEach begin="0" end="${department.size % 5 == 0 ? department.size / 5 : department.size / 5 }" varStatus="status2">
						  						<tr>
						  							<c:if test="${invitations == null }">
						  								<c:forEach items="${department.users }" var="user" begin="${status2.index * 5 }" end="${(status2.index - 0 + 1) * 5 - 1 }">
											  				<td>
											  					<input type="checkbox" name="userIds" value="${user.id }" class="d${department.id }">
											  					<c:if test="${user.password == null }">
											  						${user.name }(部门经理)
											  					</c:if>
											  					<c:if test="${user.password != null }">
											  						${user.name }${user.password + "----1"}
											  					</c:if>
											  				</td>
											  			</c:forEach>
						  							</c:if>
						  							
						  							<c:if test="${invitations != null }">
						  								<c:forEach items="${department.users }" var="user" begin="${status2.index * 5 }" end="${(status2.index - 0 + 1) * 5 - 1 }">
						  									<c:set var="tag" scope="request" value="0"></c:set>
						  									<c:forEach items="${invitations }" var="invitation">
						  										<c:if test="${user.id == invitation.user.id }">
						  											<c:set var="tag" scope="request" value="1"></c:set>
						  										</c:if>	
						  									</c:forEach>
						  									<td>
						  										<c:if test="${tag == 1 }">
						  											<input type="checkbox" name="userIds" value="${user.id }" checked="checked" class="d${department.id }">
												  					<c:if test="${user.password == null }">
												  						${user.name }(部门经理)
												  					</c:if>
												  					<c:if test="${user.password != null }">
												  						${user.name }
												  					</c:if>
						  										</c:if>
						  										<c:if test="${tag == 0 }">
						  											<input type="checkbox" name="userIds" value="${user.id }" class="d${department.id }">
												  					<c:if test="${user.password == null }">
												  						${user.name }(部门经理)
												  					</c:if>
												  					<c:if test="${user.password != null }">
												  						${user.name }
												  					</c:if>
						  										</c:if>
						  									</td>
						  								</c:forEach>
						  							</c:if>
						  						</tr>
						  					</c:forEach>
						  				</tbody>
						  			</table>
						  		</div>
						  	</c:if>
					  	</c:forEach>
					  </div>
					</div>
						<div class="pull-right" style="margin-top: 50px">
							<button class="btn btn-primary" type="submit">下一步</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>

</html>
