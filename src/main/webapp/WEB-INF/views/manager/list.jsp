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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common2l.jsp"%>
<script type="text/javascript">
		$(function() {
			common.init("manager", "吗");
		})
	</script>
</head>

<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>员工</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>序号</th>
							<th>姓名</th>
							<th>电话</th>
							<th>照片</th>
							<th>部门</th>
							<th>修改</th>
							<th>删除</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${managers }" var="user" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${user.name }</td>
								<td>${user.phone }</td>
								<td><c:if test='${user.photo == null }'>
										该员工未上传照片
									</c:if> <c:if test='${user.photo !=  null}'>
										<a href="../resources/images/${user.photo }" target="_blank"
											class="btn btn-primary">查看</a>
									</c:if></td>
								<td>${user.department.name}</td>
								<td><a class="btn btn-primary"
									href="/meeting/${partName }/${user.id }/update?index=${page.index }">更新</a></td>
								<td><a class="btn btn-danger" href="#deleteModal"
									data-toggle="modal" data-whatever="${user.id},${user.name }">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					增加部门经理<span id="icon" class="glyphicon glyphicon-chevron-down"></span>
				</button>
				<div class="pull-right">
					<label class="label-control">当前是第${page.index }页, 总共<label
						id="total">${page.total }</label>页
					</label> <a class="btn btn-primary"
						href="/meeting/${partName }/list?index=${page.index == 1 ? 1 : page.index - 1 }">上一页</a>
					<a class="btn btn-primary"
						href="/meeting/${partName }/list?index=${page.index == page.total ? page.total : page.index + 1 }">下一页</a>
					<label class="label-control">跳转到</label><input type="text" size="2"
						id="toIndex"><label class="label-control">页</label> <a
						class="btn btn-primary" id="forward" href="">跳转</a>
				</div>
			</div>
			<div class="collapse" id="collapse">
				<div class="well">
					<form class="form-inline" action="/meeting/${partName }/add"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="index"
							value="${size == 5 ? page.index + 1 : page.index }">
						<div class="form-group">
							<label class="control-label">名字</label> <input
								class="form-control" name="name" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">电话</label> <input
								class="form-control" name="phone" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">密码</label> <input
								class="form-control" name="password" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">部门</label> <select
								class="form-control" name="departmentId">
								<c:forEach items="${departments }" var="dep">
									<option value="${dep.id }">${dep.name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">照片</label>
						</div>
						<div class="form-group">
							<input name="photo" type="file" size="5">
						</div>
						<button class="btn btn-primary" type="submit">确定</button>
					</form>
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
