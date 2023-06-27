<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html>
<head>
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>New Order</title>
</head>
<body>
	<h1>${restaurant.name}</h1>
	
	<c:if test = "${ restaurant.profile == null }">
		<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
	</c:if>
	<c:if test = "${ restaurant.profile != null }">
		<img class="avatar-thumb" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
	</c:if>
	
	<div>
		<c:if test="${user != null}">
			<a href="/dashboard"><button>Dashboard</button></a>
		</c:if>
		<c:if test="${restaurantViewer != null}">
			<a href="/restaurantDashboard"><button>Dashboard</button></a>
		</c:if>
	</div>
	
	<div>
		<c:if test="${average == 1}">
			<img src="/img/onestar.png" class="main-star-rating" alt="1 Star Average"/>
		</c:if>
		<c:if test="${average == 2}">
			<img src="/img/twostar.png" class="main-star-rating" alt="2 Star Average"/>
		</c:if>
		<c:if test="${average == 3}">
			<img src="/img/threestar.png" class="main-star-rating" alt="3 Star Average"/>
		</c:if>
		<c:if test="${average == 4}">
			<img src="/img/fourstar.png" class="main-star-rating" alt="4 Star Average"/>
		</c:if>
		<c:if test="${average == 5}">
			<img src="/img/fivestar.png" class="main-star-rating" alt="5 Star Average"/>
		</c:if>
	</div>
	
	<h2>Menu</h2>
	
	<h3><a href="#" onclick="toggleComments('breakfast'); return false;">Breakfast</a></h3>
	<div id="breakfast" style="display:none;">
		<p>Test</p>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('lunch'); return false;">Lunch</a></h3>
	<div id="lunch" style="display:none;">
		<p>Test</p>
	</div>
	
	<h3><a href="#" onclick="toggleComments('dinner'); return false;">Dinner</a></h3>
	<div id="dinner" style="display:none;">
		<c:forEach var="item" items="${items}">
			<c:if test="${item.category == 'Dinner'}">
				<div class="one-food-item">
					<c:if test="${item.file == null}">
						<img src="" alt="No Item Picture"/>
					</c:if>
					<c:if test="${item.file != null}">
						<img src="data:image/jpg;base64,${item.file}" class="item-thumb-sm" alt="Item Picture"/>
					</c:if>
					
					<div class="item-name">
						<p><a href="/items/${item.id}">${item.name}</a></p>
					</div>
					
					<div class="item-description">
						<p>${item.description}</p>
					</div>
					
					<div class="item-price">
						<p>$${item.price}</p>
					</div>
					
					<div class="quantity-and-add">
                		<form action="/bags/create/${restaurant.id}" method="post">
                    		<input type="hidden" name="itemId" value="${item.id}">
                    		<input class="quantity-input" type="number" name="quantity" value="1" min="1">
                  	  		<button class="add-button">Add to bag</button>
                		</form>
            		</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('dessert'); return false;">Dessert</a></h3>
	<div id="dessert" style="display:none;">
		<c:forEach var="item" items="${items}">
			<c:if test="${item.category == 'Dessert'}">
				<div class="one-food-item">
					<c:if test="${item.file == null}">
						<img src="" alt="No Item Picture"/>
					</c:if>
					<c:if test="${item.file != null}">
						<img src="data:image/jpg;base64,${item.file}" class="item-thumb-sm" alt="Item Picture"/>
					</c:if>
					
					<div class="item-name">
						<p><a href="/items/${item.id}">${item.name}</a></p>
					</div>
					
					<div class="item-description">
						<p>${item.description}</p>
					</div>
					
					<div class="item-price">
						<p>$${item.price}</p>
					</div>
					
					<div class="quantity-and-add">
                		<form action="/bags/create/${restaurant.id}" method="post">
                    		<input type="hidden" name="itemId" value="${item.id}">
                    		<input class="quantity-input" type="number" name="quantity" value="1" min="1">
                  	  		<button class="add-button">Add to bag</button>
                		</form>
            		</div>
				</div>
			</c:if>
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('drinks'); return false;">Drinks</a></h3>
	<div id="drinks" style="display:none;">
		<p>Test</p>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('others'); return false;">Others</a></h3>
	<div id="others" style="display:none;">
		<p>Test</p>
	</div>


<script>
   function toggleComments(category) {
	   var commentsDiv = document.getElementById(category);
	   commentsDiv.style.display = (commentsDiv.style.display === "none") ? "block" : "none";
   }
</script>
</body>
</html>