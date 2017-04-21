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
		common.init("meeting", "");
		var index = "${page.index }";
		var url = "/meeting/meeting/open";
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
		})
	})
</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
			<div class="nav_middle" style="float:left;margin-top:50px;">
				<div class="nav_middle_top">
					<%@include file="../calendar.jsp" %>
				</div>
				<%@include file="../notice.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left;margin-top:50px; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>�����б�</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/open" id="form">
					<input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="��������" value="${page.searchContent }">
				     </div>
				     <c:if test="${role == 2 }">
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
					  </c:if>
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
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${meetings }" var="meeting">
								<tr>
									<td>${meeting.title }</td>
									<td>${meeting.meetingRoom.number }</td>
									<td>
										<fmt:formatDate value="${meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td><a href="/meeting/meeting/${meeting.id }/detail" class="btn btn-info detail">����</a></td>
									<c:if test="${role == 2 }">
										<td>
											<c:if test="${meeting.isPass == 2 }">
												<a class="btn btn-default disabled">�����</a>
											</c:if>
											<c:if test="${meeting.isPass == 1 }">
												<a class="btn btn-success discabled" disabled="true">ԤԼͨ��</a>
											</c:if>
											<c:if test="${meeting.isPass == 0 }">
												<a class="btn btn-warning disabled" disabled="true">ԤԼʧ��</a>
											</c:if>
										</td>
										<c:if test="${meeting.open == 0 }">
											<td><a href="/meeting/manager/meeting/first1?id=${meeting.id }" class="btn btn-primary">�޸�</a></td>
											<td><a href="#deleteModal" data-toggle="modal" data-whatever="${meeting.id},����Ϊ�� ' ${meeting.title } '  �Ļ���" class="btn btn-danger">ɾ��</a></td>
										</c:if>
										<c:if test="${meeting.open == 1 }">
											<td><a class="btn btn-primary disabled" >�޸�</a></td>
											<td><a class="btn btn-danger disabled" >ɾ��</a></td>
										</c:if>
									</c:if>
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
