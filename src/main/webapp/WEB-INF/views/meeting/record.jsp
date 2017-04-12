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
				alert("文件不能为空");
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
					<h3>我记录的会议</h3> 
				</div>
				<div class="panel-body well">
				<form class="navbar-form navbar-left" action="/meeting/meeting/record" id="form">
					<input type="hidden" name="index" value="1" id="toIndex">
				     <div class="form-group">
					     <input type="text" class="form-control" name="searchContent" placeholder="会议主题" value="${page.searchContent }">
				     </div>
				      <div class="form-group">
				     	<label>会议状态:</label>
				     	<select class="form-control" name="state">
				     		<c:if test="${page.state == 0 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 3 }">
					     		<option value="0">默认</option>
					     		<option value="3" selected="selected">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 1 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1" selected="selected">已召开</option>
					     		<option value="2">未召开</option>
					     	</c:if>	
				     		<c:if test="${page.state == 2 }">
					     		<option value="0">默认</option>
					     		<option value="3">近期会议</option>
					     		<option value="1">已召开</option>
					     		<option value="2" selected="selected">未召开</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <div class="form-group">
				     	<label>时间选择:</label>
				     	<select class="form-control" name="time">
				     		<c:if test="${page.time == 0 }">
					     		<option value="0">默认</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 1 }">
					     		<option value="0">默认</option>
					     		<option value="1" selected="selected">开始时间由大到小</option>
					     		<option value="2">开始时间由小到大</option>
					     	</c:if>	
				     		<c:if test="${page.time == 2 }">
					     		<option value="0">默认</option>
					     		<option value="1">开始时间由大到小</option>
					     		<option value="2" selected="selected">开始时间由小到大</option>
					     	</c:if>	
				     	</select>
				     </div>
				     <button type="submit" class="btn btn-default">搜索</button>
			    </form>
					<table class="table table-striped">
						<thead>
							<tr>
								<th>主题</th>
								<th>会议室</th>
								<th>开始时间</th>
								<th>结束时间</th>
								<th></th>
								<th>文档</th>
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
									<td><a href="/meeting/meeting/${record.meeting.id }/detail" class="btn btn-info detail">详情</a></td>
									<td>
										<c:if test="${record.file != null }">
										<label style="margin-top: 8px">
											${record.file }
										</label>	
											<a class="btn btn-default pull-right" href="/meeting/user/download?id=${record.id }" target="_blank">下载</a>
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
													<button class="btn btn-primary pull-right upload" style="margin-top: -30px" id="b${record.id }" >上传</button>
												</c:if>
												<c:if test="${record.meeting.open == 0 }">
													<button class="btn btn-primary pull-right upload disabled" style="margin-top: -30px" id="b${record.id }" >上传</button>
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
