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
		common.init("", "");
		var index = "${page.index }";
		var url = "/meeting/meeting/mine";
		var total = "${page.total }";
		page.init(6, index, total, url);
		$("#forward").click(function(){
			var index2 = $("#forwardPage").val();
			var form = $("#form");
			var toIndex = $("#toIndex");
			toIndex.val(index2);
			form.submit();
		});
		CalendarHandler.initialize(0, 0, 0);
		$(".pageItem").click(function(){
			var index2 = $(this).html();
			var regex = /\D/;
			if(regex.test(index2)) {
				var href = $(this).attr("href");
				if(href == undefined)
				return false;
			}
			var form = $("#form");
			var href1 = $(this).attr("href");
			index2 = href1.substring(href1.lastIndexOf("=") + 1);
			var toIndex = $("#toIndex");
			toIndex.val(index2);
			form.submit();
			return false;
		});
		
		$(".state").change(function() {
			var sIndex = this.selectedIndex;
			var invitationId = $(this).attr("id");
			var value = this.options[sIndex].value;
			$.post("/meeting/invitation/" + invitationId.substring(1) + "/state?state=" + value, {_method : "PUT"}, function(data){});
		})
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
			<div class="nav_middle" style="float:left; margin-top: 50px">
				<div class="nav_middle_top">
					<%@include file="../calendar.jsp" %>
				</div>
				<%@include file="../notice.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left; padding: 0 0; margin-top: 50px">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>��Ҫ�μӵĻ���</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/mine" id="form">
					<input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="��������" value="${page.searchContent }">
				     </div>
				      <div class="form-group">
				     	<label>����״̬:</label>
				     	<select class="form-control" name="state">
				     		<c:if test="${page.state == 0 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3">���ڻ���</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 3 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3" selected="selected">���ڻ���</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 1 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3">���ڻ���</option>
					     		<option value="1" selected="selected">���ٿ�</option>
					     		<option value="2">δ�ٿ�</option>
					     	</c:if>	
				     		<c:if test="${page.state == 2 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="3">���ڻ���</option>
					     		<option value="1">���ٿ�</option>
					     		<option value="2" selected="selected">δ�ٿ�</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <div class="form-group">
				     	<label>ʱ��ѡ��:</label>
				     	<select class="form-control" name="time">
				     		<c:if test="${page.time == 0 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="1">��ʼʱ���ɴ�С</option>
					     		<option value="2">��ʼʱ����С����</option>
					     	</c:if>	
				     		<c:if test="${page.time == 1 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="1" selected="selected">��ʼʱ���ɴ�С</option>
					     		<option value="2">��ʼʱ����С����</option>
					     	</c:if>	
				     		<c:if test="${page.time == 2 }">
					     		<option value="0">Ĭ��</option>
					     		<option value="1">��ʼʱ���ɴ�С</option>
					     		<option value="2" selected="selected">��ʼʱ����С����</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-default">����</button>
			    </form>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>����</th>
								<th>������</th>
								<th>��ʼʱ��</th>
								<th>����ʱ��</th>
								<th></th>
								<th>�Ƿ�μ�</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${invitations }" var="invitation">
								<tr>
									<td>${invitation.meeting.title }${invitation.id }</td>
									<td>${invitation.meeting.meetingRoom.number }</td>
									<td>
										<fmt:formatDate value="${invitation.meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${invitation.meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td><a href="/meeting/meeting/${invitation.meeting.id }/detail" class="btn btn-info detail">����</a></td>
									<td>
										<c:if test="${invitation.meeting.open == 0 }">
											<select class="form-control state" id="i${invitation.id }">
												<c:if test="${invitation.isAccess == 2 }">
													<option value="2">��ȷ��</option>
													<option value="1">�μ�</option>
													<option value="0">���μ�</option>
												</c:if>
												<c:if test="${invitation.isAccess == 1 }">
													<option value="2">��ȷ��</option>
													<option value="1" selected="selected">�μ�</option>
													<option value="0">���μ�</option>
												</c:if>
												<c:if test="${invitation.isAccess == 0 }">
													<option value="2">��ȷ��</option>
													<option value="1">�μ�</option>
													<option value="0" selected="selected">���μ�</option>
												</c:if>
											</select>
										</c:if>	
										
										<c:if test="${invitation.meeting.open == 1 }">
												<c:if test="${invitation.isAccess == 2 }">
													��ȷ��
												</c:if>
												<c:if test="${invitation.isAccess == 1 }">
													�μ�
												</c:if>
												<c:if test="${invitation.isAccess == 0 }">
													���μ�
												</c:if>
										</c:if>	
									</td>
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="../page.jsp" %>
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
					<button type="button" class="btn btn-primary" data-dismiss="modal">ȡ��</button>
					<button type="button" class="btn btn-danger" id="delete">ȷ��</button>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
