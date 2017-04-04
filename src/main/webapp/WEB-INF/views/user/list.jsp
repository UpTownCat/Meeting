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

<%@include file="../common2l.jsp"%>
<script type="text/javascript">
		$(function() {
			var index = "${page.index }";
			var total = "${page.total }";
			var url = "/meeting/user/list";
			page.init(6, index, total, url);
			$("#forward").click(function(){
				$("#toIndex").val($("#forwardPage").val());
				$("#form").submit();
				return false;
			});
			common.init("user", "吗");
			$(".pageItem").click(function(){
				var index2 = $(this).html();
				var href1 = $(this).attr("href");
				var form = $("#form");
				index2 = href1.substring(href1.lastIndexOf("=") + 1);
				var toIndex = $("#toIndex");
				toIndex.val(index2);
				form.submit();
				return false;
			});
		})
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>员工列表</h3>
			</div>
			<div class="panel-body">
					<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="name" placeholder="员工姓名" value="${page.name }">
				     </div>
				      <div class="form-group">
				     	<label>部门:</label>
				     	<select class="form-control" name="departmentId">
				     		<option value="0">默认</option>
				     		<c:forEach items="${departments }" var="department">
				     			<c:if test="${page.departmentId == department.id }">
				     				<option value="${department.id }" selected="selected">${department.name }</option>
				     			</c:if>
				     			<c:if test="${page.departmentId != department.id }">
				     				<option value="${department.id }">${department.name }</option>
				     			</c:if>
				     		</c:forEach>
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-info">搜索</button>
			    </form>
				<table class="table table-striped">
					<thead>
						<tr>
							<th><input type="checkbox">全选</th>
							<th>姓名</th>
							<th>电话</th>
							<th>邮箱</th>
							<th>部门</th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${users }" var="user" varStatus="status">
							<tr>
								<td><input type="checkbox">选择</td>
								<td>${user.name }</td>
								<td>${user.phone }</td>
								<td>${user.email }</td>
								<td>${user.department.name}</td>
								<td><a href="${partName }/${user.id }/detail" class="btn btn-info">详情</a></td>
								<td><a class="btn btn-primary"
									href="${partName }/${user.id }/update?index=${page.index }">更新</a></td>
								<td><a class="btn btn-danger" href="#deleteModal"
									data-toggle="modal" data-whatever="${user.id},${user.name }">删除</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<a class="btn btn-primary" href="/meeting/user/add">
			增加部员工<span id="icon" class="glyphicon glyphicon-plus"></span>
				</a>
				<div class="pull-right">
					<%@include file="../page.jsp" %>
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
