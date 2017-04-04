<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%
String path = request.getContextPath();
%>

<!DOCTYPE html>
<html>
<head>

<title>My JSP 'list.jsp' starting page</title>

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
		$(function(){
			common.init("department", "吗");
		})
	</script>
</head>

<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>部门</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>序号</th>
							<th>名称</th>
							<th>部门经理</th>
							<th>修改</th>
							<th>删除</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${departments }" var="department"
							varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${department.name }</td>
								<td>${department.manager == null ? "该部门暂时没有部门经理" : department.manager.name}</td>
								<td><a class="btn btn-primary"
									href="/meeting/department/${department.id }/update?index=${page.index }">更新</a></td>
								<td><a class="btn btn-danger" href="#deleteModal"
									data-toggle="modal"
									data-whatever="${department.id},${department.name }">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					增加部门<span id="icon" class="glyphicon glyphicon-chevron-down"></span>
				</button>
				<div class="collapse" id="collapse">
					<div class="well">
						<form class="form-inline" action="/meeting/department/add"
							method="post">
							<input type="hidden" name="index"
								value="${size == 5 ? page.index + 1 : page.index }">
							<div class="form-group">
								<label class="control-label">名称</label> <input
									class="form-control" name="name" type="text">
							</div>
							<button class="btn btn-primary" type="submit">确定</button>
						</form>
					</div>
				</div>
			</div>
			<div class="modal fade" id="deleteModal" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div calss="modal-header"></div>
						<div class="modal-body">
							<h3 id="msg"></h3>
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-danger" id="delete">确定</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
