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
		CalendarHandler.initialize(0, 0, 0);
		$("#toFirst").click(function(){
			$("#tag").val(1);
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
					<h4>2.ѡ���������</h4>
				</div>
				<div class="panel-body">
					<form class="form col-lg-7" action="/meeting/manager/meeting/third" method="post">
						<input type="hidden" value="0" name="tag" id='tag'>
						<table class="table">
							<thead>
								<tr>
									<th><input type="checkbox"></th>
									<th>����</th>
									<th>����</th>
									<th>ʹ������</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${equipments }" var="equipment">
									<tr>
										<c:if test="${equipment.need <= 0 }">
											<td><input type="checkbox"></td>
											<td>${equipment.name }</td>
											<td>${equipment.count }</td>
											<td><input type="number" class="form-control" name="${equipment.id }" style="margin-top:-2px"></td>
										</c:if>
										<c:if test="${equipment.need > 0 }">
											<td><input type="checkbox" checked="checked"></td>
											<td>${equipment.name }</td>
											<td>${equipment.count }</td>
											<td><input type="number" class="form-control" name="${equipment.id }" value="${equipment.need }" style="margin-top: -2px"></td>
										</c:if>
									</tr>
								</c:forEach>
							</tbody>
						</table>
						<div class="pull-right">
							<button class="btn btn-primary" id="toFirst">��һ��</button>
							<button class="btn btn-primary" type="submit">��һ��</button>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

</body>

</html>
