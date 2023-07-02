<%@ page language="java" contentType="text/html; charset=ISO-8859-1"
    pageEncoding="ISO-8859-1"%>
<%@ page isErrorPage="true" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %> 

<!DOCTYPE html>
<html>
<head>
<link rel="preconnect" href="https://fonts.googleapis.com">
<link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
<link href="https://fonts.googleapis.com/css2?family=Graduate&family=Quicksand&family=Heebo&family=Ysabeau+SC:wght@300&display=swap" rel="stylesheet">
<link rel="stylesheet" type="text/css" href="/css/style.css">
<meta charset="ISO-8859-1">
<title>New Order</title>
</head>
<body>
	<div class="container">
	<h1>Start ordering, <a href="/users/${user.id}">${user.first_name}!</h1></a>
	
	<div class="profile-div">
		<c:if test = "${ user.profile == null }">
			<img class="avatar-thumb" src="/img/avatar-icon.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ user.profile != null }">
			<img class="avatar-thumb" src="data:image/jpg;base64,${user.profile}" alt="Profile-Pic"/>
		</c:if>
	</div>
	
	<div class="bag-div">
		<a href="/bags/show/${user.bag.id}">
			<img src="/img/bag.png" class="bag-icon border-marked" alt="Shopping Bag"/>
		</a>
	</div>
	
	<div class="bag-notification">
		<c:if test="${user.bag.orders.size() == 0}">
			<p>0</p>
		</c:if>
		<c:if test="${user.bag.orders.size() != 0}">
			<p>${user.bag.orders.size()}</p>
		</c:if>
	</div>
	
	
	<div class="nav-buttons">
		<a href="/dashboard"><button class="button-small"><p>Home</p></button></a>
		<a href="/users/edit"><button class="button-small"><p>Edit</p></button></a>
		<a href="/logout"><button class="button-small"><p>Logout</p></button></a>
	</div>

	<div class="logo-and-stars">
		<c:if test = "${ restaurant.profile == null }">
			<img class="avatar-thumb" src="/img/restaurant.png" alt="No Profile Pic"/>
		</c:if>
		<c:if test = "${ restaurant.profile != null }">
			<img class="avatar-thumb-med" src="data:image/jpg;base64,${restaurant.profile}" alt="Profile-Pic"/>
		</c:if>
		<div>
			<div class="restaurant-name">
				<h1>${restaurant.name}</h1>
			</div>
			<div class="average-rating">
				<c:if test="${average == 1}">
					<img src="/img/1star.png" class="main-star-rating" alt="1 Star Average"/>
				</c:if>
				<c:if test="${average == 2}">
					<img src="/img/2stars.png" class="main-star-rating" alt="2 Star Average"/>
				</c:if>
				<c:if test="${average == 3}">
					<img src="/img/3stars.png" class="main-star-rating" alt="3 Star Average"/>
				</c:if>
				<c:if test="${average == 4}">
					<img src="/img/4stars.png" class="main-star-rating" alt="4 Star Average"/>
				</c:if>
				<c:if test="${average == 5}">
					<img src="/img/5stars.png" class="main-star-rating" alt="5 Star Average"/>
				</c:if>
			</div>
		</div>
	</div>
	
	
	
	<h2>Menu</h2>
	
	<h3><a href="#" onclick="toggleComments('breakfast'); return false;">Breakfast</a></h3>
	<div id="breakfast" style="display:none;">
	<c:if test="${breakfast.size() == 0}">
		<p>No breakfast items yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${breakfast}">
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
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('lunch'); return false;">Lunch</a></h3>
	<div id="lunch" style="display:none;">
	<c:if test="${lunch.size() == 0}">
		<p>No lunch items yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${lunch}">
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
		</c:forEach>
	</div>
	
	<h3><a href="#" onclick="toggleComments('dinner'); return false;">Dinner</a></h3>
	<div id="dinner" style="display:none;">
	<c:if test="${dinner.size() == 0}">
		<p>No dinner items yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${dinner}">
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
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('dessert'); return false;">Dessert</a></h3>
	<div id="dessert" style="display:none;">
	<c:if test="${dessert.size() == 0}">
		<p>No dessert items yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${dessert}">
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
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('drinks'); return false;">Drinks</a></h3>
	<div id="drinks" style="display:none;">
	<c:if test="${drinks.size() == 0}">
		<p>No drink items yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${drinks}">
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
		</c:forEach>
	</div>
	
	
	<h3><a href="#" onclick="toggleComments('others'); return false;">Others</a></h3>
	<div id="others" style="display:none;">
	<c:if test="${others.size() == 0}">
		<p>No items of "others" category yet for this restaurant..</p>
	</c:if>
		<c:forEach var="item" items="${others}">
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
		</c:forEach>
	</div>


<script>
	
	const urlParams = new URLSearchParams(window.location.search);
	const expandParam = urlParams.get('expand')
	const categoryParam = urlParams.get('category');
	

	if (expandParam === 'show') {
		const categoryDiv = document.getElementById(categoryParam.toLowerCase());
		categoryDiv.style.display = "block";
	}
   	
	function toggleComments(category) {
	   var commentsDiv = document.getElementById(category);
	   commentsDiv.style.display = (commentsDiv.style.display === "none") ? "block" : "none";
   }
</script>
	</div>
</body>
</html>