<%@ page language="java" import="java.util.*" pageEncoding="GBK"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<div class="left" style="float: left; margin-top: 50px">
		<c:if test="${sessionScope.role == 3}">
			<%@include file="menu.jsp" %>
		</c:if>
		<c:if test="${sessionScope.role != 3}">
			<%@include file="calendar.jsp" %>
			<%@include file="notice.jsp" %>
		</c:if>
	</div>