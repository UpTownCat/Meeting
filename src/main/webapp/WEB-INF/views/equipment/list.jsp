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
<%@include file="../common2l.jsp"%>
<script type="text/javascript">
		$(function(){
			common.init("equipment", "��");
		})
	</script>
</head>

<body>
	<div class="container">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>�����豸</h3>
			</div>
			<div class="panel-body">
				<table class="table table-striped">
					<thead>
						<tr>
							<th>���</th>
							<th>����</th>
							<th>����</th>
							<th>�޸�</th>
							<th>ɾ��</th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${equipments }" var="equipment"
							varStatus="status">
							<tr>
								<td>${status.index + 1 }</td>
								<td>${equipment.name }</td>
								<td>${equipment.count }</td>
								<td><a class="btn btn-primary"
									href="/meeting/equipment/${equipment.id }/update?id=${equipment.id}&index=${page.index }">����</a></td>
								<td><a class="btn btn-danger" href="#deleteModal" data-toggle="modal" data-whatever="${equipment.id},${equipment.name }">ɾ��</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					���ӻ����豸<span id="icon" class="glyphicon glyphicon-chevron-down"></span>
				</button>
				<div class="pull-right">
					<label class="label-control">��ǰ�ǵ�${page.index }ҳ, �ܹ�<label
						id="total">${page.total }</label>ҳ
					</label> <a class="btn btn-primary"
						href="/meeting/equipment/list?index=${page.index == 1 ? 1 : page.index - 1 }">��һҳ</a>
					<a class="btn btn-primary"
						href="/meeting/equipment/list?index=${page.index == page.total ? page.total : page.index + 1 }">��һҳ</a>
					<label class="label-control">��ת��</label><input type="text" size="2"
						id="toIndex"><label class="label-control">ҳ</label> <a
						class="btn btn-primary" id="forward" href="">��ת</a>
				</div>
				<div class="collapse" id="collapse">
					<div class="well">
						<form class="form-inline" action="/meeting/equipment/add"
							method="post">
							<input type="hidden" name="index"
								value="${size == 5 ? page.index + 1 : page.index }">
							<div class="form-group">
								<label class="control-label">����</label> <input
									class="form-control" name="name" type="text">
							</div>
							<div class="form-group">
								<label class="control-label">����</label> <input
									class="form-control" name="count" type="text">
							</div>
							<button class="btn btn-primary" type="submit">ȷ��</button>
						</form>
					</div>
				</div>
			</div>
			<div class="modal fade" id="deleteModal" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div calss="modal-header"></div>
						<div class="modal-body">
							<h3 id="msg" class="danger"></h3>
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
