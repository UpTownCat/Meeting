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
			common.init("department", "  ��?(�ò��ŵ�Ա��Ҳ��һ����ɾ���� �����أ�)");
			var index = "${page.index }";
			var total = "${page.total }";
			var url = "/meeting/department/list";
			page.init(6, index, total, url);
			$("#forward").click(function(){
				$("#toIndex").val($("#forwardPage").val());
				$("#form").submit();
				return false;
			});
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
			var t1 = 1;
			$("#name").blur(function() {
				var val = this.value;
				if(val.length == 0) {
					common.remind("�������ֲ���Ϊ�գ�");
					t1 = 0;
					return false;
				}
				val = encodeURI(val);
				$.get("/meeting/common/name", {"tag": 4, "name": val}, function(data) {
					if(data != 0) {
						t1 = 2;
						common.remind("�����ƵĲ����Ѿ����ڣ�");
					}else {
						t1 = 1;
					}
				})
			})
			
			$("#submit44").click(function() {
				if(t1 == 0) {
					common.remind("�������ֲ���Ϊ�գ�");
					return false;
				}
				if(t1 == 2) {
					common.remind("�����ƵĲ����Ѿ����ڣ�");
					return false;
				};
			})
		})
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div style="float:left; margin-top:50px">
		<%@include file="../menu.jsp" %>
	</div>
	<div class="container col-lg-9" style="float:left; margin-top:50px; padding : 0 0;">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>�����б�</h3>
			</div>
			<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="name" placeholder="����" value="${page.name }">
				     </div>
				     <button type="submit" class="btn btn-info">����</button>
			    </form>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>����</th>
							<th>���ž���</th>
							<th></th>
							<th></th>
							<th></th>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${departments }" var="department"
							varStatus="status">
							<tr>
								<td>${department.name }</td>
								<td>${department.manager == null ? "�ò�����ʱû�в��ž���" : department.manager.name}</td>
								<td>
									<a href="/meeting/department/${department.id }/detail" class="btn btn-info">����</a>
								</td>
								<td><a class="btn btn-primary"
									href="/meeting/department/${department.id }/update?index=${page.index }">����</a></td>
								<td><a class="btn btn-danger" href="#deleteModal"
									data-toggle="modal"
									data-whatever="${department.id},${department.name }">ɾ��</a></td>
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
				<div class="panel-footer">
				<button class="btn btn-primary" data-toggle="collapse"
					data-target="#collapse" id="btn">
					���Ӳ���<span id="icon" class="glyphicon glyphicon-plus"></span>
				</button>
				<%@include file="../page.jsp"%>
				<div class="collapse" id="collapse">
					<div class="well">
						<form class="form-inline" action="/meeting/department/add"
							method="post">
							<input type="hidden" name="index"
								value="${size == 5 ? page.index + 1 : page.index }">
							<div class="form-group">
								<label class="control-label">����</label> <input
									class="form-control" name="name" type="text" id="name">
							</div>
							<button class="btn btn-primary" type="submit" id="submit44">ȷ��</button>
						</form>
					</div>
				</div>
			</div>
			<div class="modal fade" id="deleteModal" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div calss="modal-header"></div>
						<div class="modal-body">
							<p id="msg"></p>
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
