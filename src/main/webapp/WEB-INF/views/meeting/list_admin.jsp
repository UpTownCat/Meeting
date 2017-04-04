<%@ page language="java" import="java.util.*" pageEncoding="GBK" isELIgnored="false"%>
<%
String path = request.getContextPath();
pageContext.setAttribute("partName", "meeting");
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
		var index = "${page.index }";
		var url = "/meeting/meeting/list";
		var total = "${page.total }";
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
		var url2 = "";
		$("#myModal").on('show.bs.modal', function (event) {
			  var button = $(event.relatedTarget);
			  var value = button.data('whatever'); 
			  var index2 = value.indexOf(",");
			  var index3 = value.indexOf(".");
			  var id2 = value.substring(0, index2);
			  var title2 = value.substring(index2 + 1, index3);
			  url2 = "/meeting/meeting/" + id2 + "/" + value.substring(index3 + 1);
			  $("#msg").html("��ȷ��Ҫ" + title2);
			});
		$("#ok").click(function() {
			var args = {_method : "PUT"};
			$("#msg").html("���ڴ���... ����ˢ��ҳ��");
			$("#myForm").attr("action", url2).submit();
		})
		
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
		<div class="main" style="margin-top:50px">
			<div class="nav_middle" style="float:left;">
				<%@include file="../menu.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>�����б�</h3> 
				</div>
				<div class="panel-body">
				<form class="navbar-form navbar-left" id="form">
				     <input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="��������" value="${page.searchContent }">
				     </div>
				     <div class="form-group">
				     	<label>����ԤԼ:</label>
				     	<select class="form-control" name="appointment">
				     		<c:if test="${page.appointment == 0 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1">ԤԼͨ��</option>
					     		<option value="2">ԤԼʧ��</option>
					     		<option value="3">�����</option>
				     		</c:if>
				     		<c:if test="${page.appointment == 1 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1" selected="selected">ԤԼͨ��</option>
					     		<option value="2">ԤԼʧ��</option>
					     		<option value="3">δ���</option>
				     		</c:if>
				     		<c:if test="${page.appointment == 2 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1">ԤԼͨ��</option>
					     		<option value="2" selected="selected">ԤԼʧ��</option>
					     		<option value="3">δ���</option>
				     		</c:if>
				     		<c:if test="${page.appointment == 3 }">
				     			<option value="0">Ĭ��</option>
					     		<option value="1">ԤԼͨ��</option>
					     		<option value="2">ԤԼʧ��</option>
					     		<option value="3" selected="selected">δ���</option>
				     		</c:if>
				     	</select>
				     </div>
				      <div class="form-group">
				     	<label>����״̬:</label>
				     	<select class="form-control" name="state">
				     		<c:if test="${page.state == 0 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3">����</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 1 }">
					     		<option value="0">Ĭ��</option>
					     			<option value="3">����</option>
					     		<option value="1" selected="selected">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 2 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3">����</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2" selected="selected">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 3 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3" selected="selected">����</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <div class="form-group">
				     	<label>ʱ��ѡ��:</label>
					     <select class="form-control" name="time">
					     		<c:if test="${page.time == 0 }">
						     		<option value="0">Ĭ��</option>
						     		<option value="3">ԤԼʱ���ɴ�С</option>
						     		<option value="4">ԤԼʱ����С����</option>
						     		<option value="1">��ʼʱ���ɴ�С</option>
						     		<option value="2">��ʼʱ����С����</option>
						     	</c:if>	
					     		<c:if test="${page.time == 1 }">
						     		<option value="0">Ĭ��</option>
						     		<option value="3">ԤԼʱ���ɴ�С</option>
						     		<option value="4">ԤԼʱ����С����</option>
						     		<option value="1" selected="selected">��ʼʱ���ɴ�С</option>
						     		<option value="2">��ʼʱ����С����</option>
						     	</c:if>	
					     		<c:if test="${page.time == 2 }">
						     		<option value="0">Ĭ��</option>
						     		<option value="3">ԤԼʱ���ɴ�С</option>
						     		<option value="4">ԤԼʱ����С����</option>
						     		<option value="1">��ʼʱ���ɴ�С</option>
						     		<option value="2" selected="selected">��ʼʱ����С����</option>
						     	</c:if>	
						     	<c:if test="${page.time == 3 }">
						     		<option value="0">Ĭ��</option>
						     		<option value="3" selected="selected">ԤԼʱ���ɴ�С</option>
						     		<option value="4">ԤԼʱ����С����</option>
						     		<option value="1">��ʼʱ���ɴ�С</option>
						     		<option value="2">��ʼʱ����С����</option>
						     	</c:if>	
						     	<c:if test="${page.time == 4 }">
						     		<option value="0">Ĭ��</option>
						     		<option value="3">ԤԼʱ���ɴ�С</option>
						     		<option value="4" selected="selected">ԤԼʱ����С����</option>
						     		<option value="1">��ʼʱ���ɴ�С</option>
						     		<option value="2">��ʼʱ����С����</option>
						     	</c:if>	
					     	</select>
				     </div>
				     <button type="submit" class="btn btn-info">����</button>
			    </form>
			    	<c:if test="${meetings != null }">
						<table class="table table-striped">
							<thead>
								<tr>
									<th>����</th>
									<th>����</th>
									<th>������</th>
									<th>ԤԼʱ��</th>
									<th>��ʼʱ��</th>
									<th>����ʱ��</th>
									<th></th>
									<th>�Ƿ���׼</th>
								</tr>
							</thead>
							<tbody>
								<c:forEach items="${meetings }" var="meeting">
									<tr>
										<td>${meeting.title }</td>
										<td>${meeting.manager.name }</td>
										<td>${meeting.meetingRoom.number }</td>
										<td>
											<fmt:formatDate value="${meeting.appointmentTime}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
										<td>
											<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
										<td>
											<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
										</td>
										<td>
											<a href="/meeting/meeting/${meeting.id }/detail" class="btn btn-info">����</a>
										</td>
										<td>
											<c:if test="${meeting.isPass == 2 }">
												<a class="btn btn-primary" href="#myModal" data-toggle="modal" data-whatever="${meeting.id },ͬ������Ϊ: << ${meeting.title } >> �Ļ�����?(ͬһ��ʱ��κͻ����ҵ��������齫ԤԼʧ��).agree">ͬ��</a>
												<a class="btn btn-primary" href="#myModal" data-toggle="modal" data-whatever="${meeting.id },��ͬ������Ϊ: << ${meeting.title } >>�Ļ�����?.disagree">��ͬ��</a>
											</c:if>
											<c:if test="${meeting.isPass == 1 }">
												<a class="btn btn-primary" disabled="true">��ͬ��</a>
											</c:if>
											<c:if test="${meeting.isPass == 0 }">
												<a class="btn btn-primary" disabled="true">��ͬ��</a>
											</c:if>
										</td>
									</tr>
								</c:forEach>
							</tbody>
						</table>
					</c:if>
					<c:if test="${meetings == null }">
						<h4>����û�л����ٿ�!</h4>
					</c:if>
					<%@include file="../page.jsp" %>
				</div>
			</div>
		</div>
		<form action="" id="myForm" method="post">
			<input type="hidden" name="_method" value="PUT">
			<input type="hidden" name="index" value="${page.index }">
			<input type="hidden" name="searchContent" value="${page.searchContent }">
			<input type="hidden" name="state" value="${page.state }">
			<input type="hidden" name="appointment" value="${page.appointment }">
		</form>
		<div class="modal fade" id="myModal" tabindex="-1" role="dialog">
			<div class="modal-dialog">
				<div class="modal-content">
					<div class="modal-header">
						<button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
	       				<h4 class="modal-title">�������</h4>
					</div>
					<div class="modal-body">
						<p id="msg"></p>
					</div>
					 <div class="modal-footer">
				        <button type="button" class="btn btn-default" data-dismiss="modal">ȡ��</button>
				        <button type="button" class="btn btn-primary" id="ok">ȷ��</button>
				      </div>
				</div>
			</div>
		</div>
	</div>	
</body>
</html>
