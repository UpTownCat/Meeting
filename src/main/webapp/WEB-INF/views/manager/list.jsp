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
			common.init("manager", "��");
		})
	</script>
</head>

<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>Ա��</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>���</th>
							<th>����</th>
							<th>�绰</th>
							<th>��Ƭ</th>
							<th>����</th>
							<th>�޸�</th>
							<th>ɾ��</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${managers }" var="user" varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${user.name }</td>
								<td>${user.phone }</td>
								<td><c:if test='${user.photo == null }'>
										��Ա��δ�ϴ���Ƭ
									</c:if> <c:if test='${user.photo !=  null}'>
										<a href="../resources/images/${user.photo }" target="_blank"
											class="btn btn-primary">�鿴</a>
									</c:if></td>
								<td>${user.department.name}</td>
								<td><a class="btn btn-primary"
									href="/meeting/${partName }/${user.id }/update?index=${page.index }">����</a></td>
								<td><a class="btn btn-danger" href="#deleteModal"
									data-toggle="modal" data-whatever="${user.id},${user.name }">ɾ��</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					���Ӳ��ž���<span id="icon" class="glyphicon glyphicon-chevron-down"></span>
				</button>
				<div class="pull-right">
					<label class="label-control">��ǰ�ǵ�${page.index }ҳ, �ܹ�<label
						id="total">${page.total }</label>ҳ
					</label> <a class="btn btn-primary"
						href="/meeting/${partName }/list?index=${page.index == 1 ? 1 : page.index - 1 }">��һҳ</a>
					<a class="btn btn-primary"
						href="/meeting/${partName }/list?index=${page.index == page.total ? page.total : page.index + 1 }">��һҳ</a>
					<label class="label-control">��ת��</label><input type="text" size="2"
						id="toIndex"><label class="label-control">ҳ</label> <a
						class="btn btn-primary" id="forward" href="">��ת</a>
				</div>
			</div>
			<div class="collapse" id="collapse">
				<div class="well">
					<form class="form-inline" action="/meeting/${partName }/add"
						method="post" enctype="multipart/form-data">
						<input type="hidden" name="index"
							value="${size == 5 ? page.index + 1 : page.index }">
						<div class="form-group">
							<label class="control-label">����</label> <input
								class="form-control" name="name" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">�绰</label> <input
								class="form-control" name="phone" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">����</label> <input
								class="form-control" name="password" type="text">
						</div>
						<div class="form-group">
							<label class="control-label">����</label> <select
								class="form-control" name="departmentId">
								<c:forEach items="${departments }" var="dep">
									<option value="${dep.id }">${dep.name }</option>
								</c:forEach>
							</select>
						</div>
						<div class="form-group">
							<label class="control-label">��Ƭ</label>
						</div>
						<div class="form-group">
							<input name="photo" type="file" size="5">
						</div>
						<button class="btn btn-primary" type="submit">ȷ��</button>
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
								data-dismiss="modal">ȡ��</button>
							<button type="button" class="btn btn-danger" id="delete">ȷ��</button>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
