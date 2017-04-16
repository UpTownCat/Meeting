<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<c:if test="${sessionScope.role != 3 }">
				<div class="navbar-header">
					<a class="navbar-brand" href="/meeting/index.jsp">会议管理系统</a>
				</div>
					 <ul class="nav navbar-nav navbar-right">
			 	<li><a href="/meeting/meeting/list?state=3">会议显示</a></li>
			 	<li><a href="/meeting/room/list">会议室显示</a></li>
		       	<c:if test="${sessionScope.role == 2 }">
		       		<li><a href="/meeting/department/${sessionScope.manager.department.id }/detail">我的部门</a>
		       		<li><a href="/meeting/meeting/open">我召开的会议</a></li>
		       		<li><a href="/meeting/manager/meeting/first1">会议预约 </a></li>
		       	</c:if>
 		        <li class="dropdown">
 	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">个人中心<span class="caret"></span></a> 
	            <ul class="dropdown-menu">
	            <li>
	            	<c:if test="${sessionScope.role == 1}">
	            		<a href="/meeting/user/${sessionScope.user.id }/detail">个人信息</a>
	            	</c:if>
	            	<c:if test="${sessionScope.role == 2}">
	            		<a href="/meeting/manager/${sessionScope.manager.id }/detail">个人信息</a>
	            	</c:if>
	            </li> 
	            <li><a href="#reset" data-toggle="modal">修改密码</a></li> 
	            <li><a href="/meeting/meeting/mine?state=2">需要参加会议</a></li> 
 	            <li><a href="/meeting/meeting/mine">已参加会议</a></li> 
 	            <c:if test="${sessionScope.role == 1 }">
 	            	<li><a href="/meeting/meeting/record?state=1">提交会议文档</a></li> 
 	            </c:if>
	          </ul>
			</c:if>
			
			<c:if test="${sessionScope.role == 3 }">
				<div class="navbar-header">
					<a class="navbar-brand" href="/meeting/index.jsp">会议管理系统后台管理</a>
				</div>
			</c:if>
			
			<div class="modal fade" id="reset" role="dialog" tabindex="-1">
				<div class="modal-dialog">
					<div class="modal-content">
						<div class="modal-header">
							<h4 id="msg2">修改密码</h4>
						</div>
						<div class="modal-body">
							<label>原密码:</label>
							<input type="password" id="oldPassword" class="form-control">
							<label>新密码:</label>
							<input type="password" class="form-control" id="password1">
							<label>重新输入:</label>
							<input type="password" class="form-control" id="password2">
						</div>
						<div class="modal-footer">
							<button type="button" class="btn btn-primary"
								data-dismiss="modal">取消</button>
							<button type="button" class="btn btn-danger" id="commonReset" data-dismiss="modal">确定</button>
						</div>
					</div>
				</div>
			</div>
		</div>
</div>
