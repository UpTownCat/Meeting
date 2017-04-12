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
		var url = "/meeting/meeting/record";
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
		$(".upload").click(function(){
			var relatedId = $(this).attr("id").substring(1);
			var relatedFile = $("#f" + relatedId);
			if(relatedFile.val().length == 0) {
				alert("�ļ�����Ϊ��");
				return false;
			}
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
					<h3>�Ҽ�¼�Ļ���</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/record" id="form">
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
								<th>�ĵ�</th>
							</tr>
						</thead>
						<tbody>
							<c:forEach items="${records }" var="record">
								<tr>
									<td>${record.meeting.title }${invitation.id }</td>
									<td>${record.meeting.meetingRoom.number }</td>
									<td>
										<fmt:formatDate value="${record.meeting.startTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td>
										<fmt:formatDate value="${record.meeting.endTime}" pattern="yyyy-MM-dd HH:mm"/>
									</td>
									<td><a href="/meeting/meeting/${record.meeting.id }/detail" class="btn btn-info detail">����</a></td>
									<td>
										<c:if test="${record.file != null }">
										<label style="margin-top: 8px">
											${record.file }
										</label>	
											<a class="btn btn-default pull-right" href="/meeting/user/download?id=${record.id }" target="_blank">����</a>
										</c:if>
										<c:if test="${record.file == null }">
											<form action="/meeting/user/upload" method="post" enctype="multipart/form-data">
												<input type="hidden" name="id" value="${record.id }">
												<input type="hidden" name="time" value="${page.time }">
												<input type="hidden" name="searchContent" value="${page.searchContent }">
												<input type="hidden" name="state" value="${page.state }">
												<input type="hidden" name="index" value="${page.index }">
												<input name="document" type="file" id="f${record.id }">
												<c:if test="${record.meeting.open == 1 }">
													<button class="btn btn-primary pull-right upload" style="margin-top: -30px" id="b${record.id }" >�ϴ�</button>
												</c:if>
												<c:if test="${record.meeting.open == 0 }">
													<button class="btn btn-primary pull-right upload disabled" style="margin-top: -30px" id="b${record.id }" >�ϴ�</button>
												</c:if>
											</form>
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
	</div>
</body>
</html>
