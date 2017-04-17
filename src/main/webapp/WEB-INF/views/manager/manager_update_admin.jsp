<%@ page language="java" import="java.util.*" pageEncoding="GBK"
	isELIgnored="false"%>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form"%>
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
<!--
	<link rel="stylesheet" type="text/css" href="styles.css">
	-->
<%@include file="../common3l.jsp"%>
<script type="text/javascript" src="../../resources/js/user_input_valid.js"></script>
<script type="text/javascript">
		$(function() {
			CalendarHandler.initialize(0, 0, 0);
			var p1 = "${manager.phone }";
			var e1 = "${manager.email }";
			userInput.init(1, 1, p1, e1);
			$('#email1').autoMail({
				emails:['qq.com','163.com','126.com','sina.com','sohu.com','yahoo.cn']
			});
			$("#change").click(function() {
				var val = $("#photo").val();
				if(val.length == 0) {
					common.remind("�ļ�����Ϊ�գ�")
					return false;
				}
				var idx = val.lastIndexOf(".");
				if(idx == -1) {
					common.remind("�ļ���Ч");
					return false;
				}
				var suffix = val.substring(idx + 1, val.length);
				if(common.validPhoto(suffix) == 0) {
					common.remind("ͼ���ļ�ֻ��Ϊjpg, jpng, png����");
					return false;
				}
			})
		})
		
	</script>
</head>

<body>
	<%@include file="../nav.jsp" %>
	<div class="left" style="float: left; margin-top: 50px">
		<c:if test="${sessionScope.role == 3 }">
			<%@include file="../menu.jsp" %>
		</c:if>
		<c:if test="${sessionScope.role != 3 }">
			<%@include file="../calendar.jsp" %>
			<%@include file="../notice.jsp" %>
		</c:if>
	</div>
	<div class="container col-lg-9" style="margin-top: 50px; padding: 0 0">
		<div class="panel panel-default">
			<div class="panel-heading">
				<c:if test="${sessionScope.role == 3 }">
					<h3>�޸Ĳ��ž���</h3>
				</c:if>
				<c:if test="${sessionScope.role != 3 }">
					<h3>�޸ĸ�����Ϣ</h3>
				</c:if>
			</div>
			<div class="panel-body">
				<div class="col-lg-7">
						<form:form modelAttribute="manager" method="post" class="form">
							<input type="hidden" name="_method" value="PUT">
							<input type="hidden" name="index" value="1">
							<input type="hidden" name="id" value="${manager.id }"> 
							<div class="form-group">
								<label class="label-control">����</label>
								<form:input path="name" class="form-control input" />
							</div>
							<div class="form-group">
								<label class="label-control">�绰</label>
								<form:input path="phone" class="form-control phone" />
							</div>
							<div class="form-group">
								<label class="label-control">����</label>
								<form:input path="email" class="form-control email" id="email1"/>
							</div>
							<div class="form-group">
								<label class="label-control">�Ա�</label>
								<br>
								<c:if test="${manager.gender == 0 }">
									<input type="radio" name='gender' value="0" checked="checked"> ��
									<input type="radio" name='gender' value="1"> Ů
								</c:if>
								<c:if test="${manager.gender == 1 }">
									<input type="radio" name='gender' value="0"> ��
									<input type="radio" name='gender' value="1" checked="checked"> Ů
								</c:if>
							</div>
							<c:if test="${sessionScope.role == 3 }">
								<c:if test="${manager.department != null }">
									<div class="form-group">
										<label class="label-control">����</label>
										<form:select path="department.id" items="${departments }"
											itemLabel="name" itemValue="id" class="form-control"></form:select>
									</div>
								</c:if>
								<c:if test="${manager.department == null }">
									<div class="form-group">
										<label class="label-control">����</label>
										<select name="department.id" class="form-control">
											<option value="0">��ѡ��</option>
											<c:forEach items="${departments }" var="department">
												<option value="${department.id }">${department.name }</option>
											</c:forEach>
										</select>
									</div>
								</c:if>
							</c:if>
							<button class="btn btn-primary pull-right" id="submit44">ȷ��</button>
						</form:form>
				</div>
				<div style="float:right">
					<h4>��Ƭ</h4>
					<img src="/meeting/common/${manager.photo }/photo" class="img" style="width: 200px; height: 200px">
					<form action="/meeting/common/photo2" method="post" enctype="multipart/form-data">
						<input type="hidden" name="table" value="2">
						<input type="hidden" name="index" value="${param.index }">
						<input type="hidden" name="id" value="${manager.id }">
						<input type="hidden" name="file" value="${manager.photo }">
						<input type="file" name="photo" style="margin-top: 30px" id="photo">
						<button type="submit" class="btn btn-primary pull-right" id="change" style="margin-top: 20px">������Ƭ</button>
					</form>
				</div>
						
			</div>
		</div>
	</div>
</body>
</html>
