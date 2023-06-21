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
<title>Item Display</title>
</head>
<body>
	<h1>${item.name}</h1>
	<h4>${item.category}</h4>
	<img src="data:image/jpg;base64,${item.file}" class="item-thumb-display"/>
	<p>${item.description}</p>
	<p>$${item.price}</p>
</body>
</html>