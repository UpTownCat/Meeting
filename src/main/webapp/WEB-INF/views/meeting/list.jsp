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
		var url = "/meeting/meeting/list";
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
		<div class="main" style="margin-top:50px">
			<div class="nav_middle" style="float:left;">
				<div class="nav_middle_top">
					<%@include file="../calendar.jsp" %>
				</div>
				<%@include file="../notice.jsp" %>
			</div>
			<div class="container col-lg-9" style="float:left; padding: 0 0">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3>�����б�</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/list" id="form">
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
								</tr>
							</c:forEach>
						</tbody>
					</table>
					<%@include file="../page.jsp" %>
				</div>
			</div>
		</div>
	</div>
</body>
</html>
