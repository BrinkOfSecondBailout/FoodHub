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
	<div class="menu">
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
	</div>
	
	<c:if test="${userId != null}">
		<h3>Looks yummy?</h3>
		<button>Start ordering!</button>
		<h3>Share your experience!</h3>
		<a href="/reviews/new/${restaurant.id}"><button>Add a review</button></a>
	</c:if>
	
	<div>
		<h2>Reviews</h2>
		<c:forEach var="review" items="${reviews}">
			<div class="one-review">
				<div class="user_of_review">
					<a href="/users/${review.user.id}"><p>${review.user.first_name} ${review.user.last_name}</p>
					<c:if test="${review.user.profile == null}">
						<img class="avatar-thumb-sm" src="/img/avatar-icon.png" alt="No Profile Pic"/>
					</c:if>
					<c:if test="${review.user.profile != null}">
						<img class="avatar-thumb-sm" src="data:image/jpg;base64,${review.user.profile}" alt="Profile-Pic"/>
					</c:if>
					</a>
				</div>
				<div class="review">
					<div class="review-date">
						<u><fmt:formatDate pattern="MMMM dd, yyyy" value="${review.created_at}"/></u>					
					</div>
					
					<div class="review-stars">
						<c:if test="${review.stars == 1}">
							<img src="/img/onestar.png" class="star-rating"/>
						</c:if>
						<c:if test="${review.stars == 2}">
							<img src="/img/twostar.png" class="star-rating"/>
						</c:if>
						<c:if test="${review.stars == 3}">
							<img src="/img/threestar.png" class="star-rating"/>
						</c:if>
						<c:if test="${review.stars == 4}">
							<img src="/img/fourstar.png" class="star-rating"/>
						</c:if>
						<c:if test="${review.stars == 5}">
							<img src="/img/fivestar.png" class="star-rating"/>
						</c:if>
					</div>
					
					<p>${review.review_text}</p><br>
					
					<c:if test="${review.comments.size() != 0 }">
						<a href=""><p>${review.comments.size()} comment(s)</p></a><br>					
					</c:if>
					
					<form:form action="/comments/add/${restaurant.id}" method="post" modelAttribute="comment">
						<form:input type="textarea" path="comment_text" class="comment-text-area"/><br>
						<form:errors path="comment_text"/><br>
						<input type="hidden" name="review_id" value=${review.id} />
						<input type="submit" value="Reply"/>
					</form:form>
				</div>
			</div>
		</c:forEach>
	</div>
	
<script>
   // Check if the 'refresh' query parameter is present
   const urlParams = new URLSearchParams(window.location.search);
   const refreshParam = urlParams.get('refresh');

   // If 'refresh' is true, force page reload
   if (refreshParam === 'true') {
	  urlParams.delete('refresh');
	  const newUrl = window.location.pathname + '?' + urlParams.toString();
      window.history.replaceState({}, '', newUrl);
      location.reload();
   }
</script>
</body>
</html>