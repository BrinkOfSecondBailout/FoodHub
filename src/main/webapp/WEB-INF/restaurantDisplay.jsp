<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>Restaurant Display</title>
</head>
<body>
	<h1>${restaurant.name}</h1>
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/avatar-icon-2.jpg" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	<c:forEach var="item" items="${items}">
		<div>
			<a href="/items/${item.id}"><p><c:out value="${item.name}"/></p>
			<c:if test = "${ item.file == null }">
				<img src="/img/no-image.png" alt="No Picture Yet" class="item-thumb"/>
			</c:if>
			<c:if test = "${ item.file != null }">
				<img src="data:image/jpg;base64,${item.file}" class="item-thumb"/>
			</c:if>
			</a>
		</div>
	</c:forEach>
	
	<c:if test="${userId != null}">
		<h3>Looks yummy?</h3>
		<button>Start ordering!</button>
		<button>I'll pass...</button>	
	</c:if>
	
</body>
</html>