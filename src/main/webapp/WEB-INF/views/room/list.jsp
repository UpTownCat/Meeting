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
			common.init("/meeting/room/list", "会议室吗");
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
				<h3>会议室列表</h3>
			</div>
			<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="number" placeholder="会议室编号" value="${page.name }">
				     </div>
				      <div class="form-group">
				     	<label>容量:</label>
				     	<select class="form-control" name="capacity">
				     		<c:if test="${page.capacity == 0 }">
				     			<option value="0">默认</option>
					     		<option value="1">由大到小</option>
					     		<option value="2">由小到大</option>
				     		</c:if>
				     		<c:if test="${page.capacity == 1 }">
				     			<option value="0">默认</option>
					     		<option value="1" selected="selected">由大到小</option>
					     		<option value="2">由小到大</option>
				     		</c:if>
				     		<c:if test="${page.capacity == 2 }">
				     			<option value="0">默认</option>
					     		<option value="1">由大到小</option>
					     		<option value="2" selected="selected">由小到大</option>
				     		</c:if>
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-primary">搜索</button>
			    </form>
				<table class="table table-striped">
					<thead>
						<tr>
							<th>编号</th>
							<th>位置</th>
							<th>容量</th>
<!-- 							<th>预约</th> -->
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
<!-- 									href="/meeting/manager/${room.id }/prepareMeeting">预约</a></td> -->
								<td><a href="/meeting/room/${room.id }/detail" class="btn btn-info">详情</a></td>
								<c:if test="${sessionScope.role == 2 }">
									<td><a class="btn btn-primary" href="/meeting/manager/meeting/first1?roomId=${room.id }">预约</a></td>
								</c:if>
								<c:if test="${sessionScope.role == 3 }">
									<td><a class="btn btn-primary"
										href="/meeting/room/${room.id }/update?id=${room.id}&index=${page.index }">更新</a></td>
									<td><a class="btn btn-danger" href="#deleteModal"
										data-toggle="modal" data-whatever="${room.id},${room.number }">删除</a></td>
								</c:if>		
							</tr>
						</c:forEach>
					</tbody>
				</table>
			</div>
			<div class="panel-footer">
				<c:if test="${sessionScope.role == 3 }">
					<a class="btn btn-primary" href="/meeting/room/add">
						增加会议室<span id="icon" class="glyphicon glyphicon-plus"></span>
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
