<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="navbar navbar-inverse navbar-fixed-top">
		<div class="container">
			<div class="navbar-header">
				<a class="navbar-brand" href="/meeting/index.jsp">会议管理系统</a>
			</div>
			 <ul class="nav navbar-nav navbar-right">
			 	<li><a href="/meeting/meeting/list">会议显示</a></li>
		       	<c:if test="${sessionScope.role == 2 }">
		       		<li><a href="/meeting/manager/meeting/first1">会议预约 </a></li>
		       	</c:if>
		       	<li><a href="/meeting/meeting/mine">我参加的会议</a></li>
	            <c:if test="${sessionScope.role == 1 }">
	            	<li><a href="/meeting/meeting/record">我记录的会议</a></li>
	            </c:if>
<!-- 		        <li class="dropdown"> -->
<!-- 	            <a href="#" class="dropdown-toggle" data-toggle="dropdown" role="button" aria-haspopup="true" aria-expanded="false">会议管理<span class="caret"></span></a> -->
<!-- 	            <ul class="dropdown-menu"> -->
<!-- 	            <li><a href="/meeting/meeting/list">会议显示</a></li> -->
	            
<!-- 	            <li><a href="/meeting/meeting/mine">我参加的会议</a></li> -->
<!-- 	            <li><a href="/meeting/meeting/record">我记录的会议</a></li> -->
<!-- 	            <li role="separator" class="divider"></li> -->
<!-- 	            <li><a href="#">Separated link</a></li> -->
	          </ul>
		</div>
</div>