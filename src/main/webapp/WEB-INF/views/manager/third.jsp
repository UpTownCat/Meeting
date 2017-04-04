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
		$("#toSecond").click(function(){
			$("#tag").val(1);
		});
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
					<h4>3.选择参会人员</h4>
				</div>
				<div class="panel-body">
					<form class="form col-lg-9" action="/meeting/manager/meeting/finish" method="post">
						<input type="hidden" name="tag" value="0" id="tag">
						<div class="panel-group" id="panel-group">
							<c:forEach items="${departments }" var="department">
								<div class="panel panel-info" data-parent="#panel-group">
									<div class="panel-heading">
										<h4><a data-toggle="collapse" data-target="#department${department.id }">${department.name }</a></h4>
									</div>
								</div>
							</c:forEach>
						</div>
						<c:forEach items="${departments }" var="department">
							<div class="collapse" id="department${department.id }">
								<table class="table table-striped table-bordered">
									<c:forEach begin="0" end="${department.size % 5 == 0 ? department.size / 5 : department.size / 5 + 1 }" varStatus="step">
										<tr>
											<c:forEach items="${department.users }" var="user" begin="${step.index * 5 }" end="${(step.index - 0 + 1) * 5 - 1 }">
												<label class="checkbox-inline"> 
													<c:if test="${invitations == null }">
														<td>
															<input type="checkbox" name="userIds" value="${user.id }"> ${user.name }
														</td>
													</c:if>
													<c:if test="${invitations != null }">
														<c:set var="tag" scope="request" value="0"></c:set>
														<c:forEach items="${invitations }" var="invitation" varStatus="status">
															<c:if test="${user.id == invitation.user.id }">
																<c:set var="tag" scope="request" value="1"></c:set>
															</c:if>
														</c:forEach>
														<c:if test="${tag == 1 }">
															<td>
																<input type="checkbox" name="userIds" value="${user.id }" checked="checked"> ${user.name }
															</td>	
														</c:if>
														<c:if test="${tag == 0 }">
															<td>
																<input type="checkbox" name="userIds" value="${user.id }"> ${user.name }
															</td>
														</c:if>
													</c:if>
													
												</label>
											</c:forEach>
										</tr>	
									</c:forEach>
								</table>	
							</div>
						</c:forEach>
						<div class="pull-right" style="margin-top: 50px">
							<button class="btn btn-primary" id="toSecond">上一步</button>
							<button class="btn btn-primary" type="submit">完成</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>

</html>
