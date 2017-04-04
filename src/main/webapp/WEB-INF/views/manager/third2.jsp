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
</style>
<script type="text/javascript">
	$(function() {
		var meetingId = "${sessionScope.meeting.id }";
		CalendarHandler.initialize(0, 0, 0);
		$("#toFirst").click(function(){
			$("#tag").val(1);
		})
		$("input[type=number]").focus(function(){
			var id = $(this).attr("name");
			var related = $("#ee" + id);
			related.prop("checked", true);
		});
		$("#finish").click(function(){
			if(meetingId != 0) {//说明是修改操作
				$("#myModal").modal({show : true});
				return false;
			}
		});
		
		$("#ok").click(function() {
			$("#updateForm").submit();
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
					<h3>3.选择会议器材</h3>
				</div>
				<div class="panel-body">
					<form class="form col-lg-7" action="/meeting/manager/meeting/finish1" method="post" id="updateForm">
						<input type="hidden" value="0" name="tag" id='tag'>
						<table class="table">
							<thead>
								<tr>
									<th></th>
									<th>器材</th>
									<th>总量</th>
									<th>使用数量</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${equipments }" var="equipment">
									<tr>
										<c:if test="${equipment.need <= 0 }">
											<td><input type="checkbox" id="ee${eqiupment.id }"></td>
											<td>${equipment.name }</td>
											<td>${equipment.count }</td>
											<td><input type="number" class="form-control" name="${equipment.id }" style="margin-top:-2px" min="0" max="1000"></td>
										</c:if>
										<c:if test="${equipment.need > 0 }">
											<td><input type="checkbox" checked="checked" id="ee${eqiupment.id }"></td>
											<td>${equipment.name }</td>
											<td>${equipment.count }</td>
											<td><input type="number" class="form-control" name="${equipment.id }" value="${equipment.need }" style="margin-top: -2px" min="0" max="1000"></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pull-right">
							<button class="btn btn-primary" id="toFirst">上一步</button>
							<button class="btn btn-primary" type="submit" id="finish">完成</button>
						</div>
					</form>
				</div>
			</div>
		</div>
				<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
					<div class="modal-dialog">
						<div class="modal-content">
							<div class="modal-header">
								<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
			       				<h4 class="modal-title">会议修改</h4>
							</div>
							<div class="modal-body">
								<p>修改会议的主题， 会议室， 会议设备， 或者会议时间其中之一将要重新审核， 并且取消之前与会人员的的邀请， 您确定要修改吗？</p>
							</div>
							 <div class="modal-footer">
						        <button type="button" class="btn btn-default" data-dismiss="modal">取消</button>
						        <button type="button" class="btn btn-primary" id="ok">确定</button>
						      </div>
						</div>
					</div>
				</div>
	</div>

</body>

</html>
