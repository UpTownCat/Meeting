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
			CalendarHandler.initialize(0, 0, 0);
			common.init("/meeting/room/list", "��������");
			var index = "${page.index }";
			var total = "${page.total }";
			var url = "/meeting/user/list";
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
		})
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<%@include file="../menu2.jsp" %>
	<div class="container col-lg-9" style="float:left; margin-top: 50px; padding : 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3>�������б�</h3>
			</div>
			<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="number" placeholder="�����ұ��" value="${page.name }">
				     </div>
				      <div class="form-group">
				     	<label>����:</label>
				     	<select class="form-control" name="capacity">
				     		<c:if test="${page.capacity == 0 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1">�ɴ�С</option>
					     		<option value="2">��С����</option>
				     		</c:if>
				     		<c:if test="${page.capacity == 1 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1" selected="selected">�ɴ�С</option>
					     		<option value="2">��С����</option>
				     		</c:if>
				     		<c:if test="${page.capacity == 2 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1">�ɴ�С</option>
					     		<option value="2" selected="selected">��С����</option>
				     		</c:if>
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-primary">����</button>
			    </form>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>���</th>
							<th>λ��</th>
							<th>����</th>
<!-- 							<th>ԤԼ</th> -->
							<th></th>
							<c:if test="${sessionScope.role == 2 }">
								<th></th>
							</c:if>
							<c:if test="${sessionScope.role == 3 }">
								<th></th>
								<th></th>
							</c:if>
						</tr>
					</thead>
					<tbody>
						<c:forEach items="${rooms }" var="room" varStatus="status">
							<tr>
								<td>${room.number }</td>
								<td>${room.location }</td>
								<td>${room.capacity }</td>
<!-- 								<td><a class="btn btn-primary" -->
<!-- 									href="/meeting/manager/${room.id }/prepareMeeting">ԤԼ</a></td> -->
								<td><a href="/meeting/room/${room.id }/detail" class="btn btn-info">����</a></td>
								<c:if test="${sessionScope.role == 2 }">
									<td><a class="btn btn-primary" href="/meeting/manager/meeting/first1?roomId=${room.id }">ԤԼ</a></td>
								</c:if>
								<c:if test="${sessionScope.role == 3 }">
									<td><a class="btn btn-primary"
										href="/meeting/room/${room.id }/update?id=${room.id}&index=${page.index }">����</a></td>
									<td><a class="btn btn-danger" href="#deleteModal"
										data-toggle="modal" data-whatever="${room.id},${room.number }">ɾ��</a></td>
								</c:if>		
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<c:if test="${sessionScope.role == 3 }">
					<a class="btn btn-primary" href="/meeting/room/add">
						���ӻ�����<span id="icon" class="glyphicon glyphicon-plus"></span>
					</a>
				</c:if>
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
