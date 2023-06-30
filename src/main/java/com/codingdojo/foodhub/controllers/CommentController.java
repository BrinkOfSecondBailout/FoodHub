package com.codingdojo.foodhub.controllers;

import java.util.List;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.CommentService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class CommentController {
	@Autowired
	public CommentService cServ;
	@Autowired
	public ReviewService rServ;
	@Autowired
	public RestaurantService restServ;
	@Autowired
	public ItemService iServ;
	@Autowired
	public UserService uServ;
	
	@PostMapping("/comments/add/{id}/{reviewid}")
	public String newComment(@Valid @ModelAttribute("comment") Comment comment, 
			BindingResult result, 
			HttpSession session,
			@PathVariable("id") Long id,
			@PathVariable("reviewid") Long reviewId,
			Model model) {
		if (session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = restServ.findRestaurantById(id);
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			List <Review> reviews = rServ.findReviewsByRestaurant(id);
			Integer average = rServ.findAverageRatingByRestaurant(id);
			List <Item> breakfast = iServ.findAllByCategory(id, "Breakfast");
			List <Item> lunch = iServ.findAllByCategory(id, "Lunch");
			List <Item> dinner = iServ.findAllByCategory(id, "Dinner");
			List <Item> dessert = iServ.findAllByCategory(id, "Dessert");
			List <Item> drinks = iServ.findAllByCategory(id, "Drinks");
			List <Item> others = iServ.findAllByCategory(id, "Others");
			if(result.hasErrors()) {
				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					User user = uServ.findUserById(userId);
					model.addAttribute("average", average);
					model.addAttribute("restaurant", restaurant);
					model.addAttribute("items", items);
					model.addAttribute("userId", userId);
					model.addAttribute("reviews", reviews);
					model.addAttribute("user", user);
					model.addAttribute("breakfast", breakfast);
					model.addAttribute("lunch", lunch);
					model.addAttribute("dinner", dinner);
					model.addAttribute("dessert", dessert);
					model.addAttribute("drinks", drinks);
					model.addAttribute("others", others);
					return "restaurantDisplay.jsp";
				}
				// if viewer is a restaurant
				Restaurant restaurantViewer = restServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
				model.addAttribute("average", average);
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
				model.addAttribute("reviews", reviews);
				model.addAttribute("restaurantViewer", restaurantViewer);
				model.addAttribute("breakfast", breakfast);
				model.addAttribute("lunch", lunch);
				model.addAttribute("dinner", dinner);
				model.addAttribute("dessert", dessert);
				model.addAttribute("drinks", drinks);
				model.addAttribute("others", others);
				return "restaurantDisplay.jsp";
			} else {

				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					Review review = rServ.findReviewById(reviewId);
					User user = uServ.findUserById(userId);
					cServ.createCommentForUser(comment, review, user, null);
					return "redirect:/restaurants/" + id + "?refresh=true";
				}
				// if viewer is a restaurant
				Long restaurantId = (Long) session.getAttribute("restaurantId");
				Restaurant restaurantViewer = restServ.findRestaurantById(restaurantId);
				Review review = rServ.findReviewById(reviewId);
				cServ.createCommentForRestaurant(comment, review, restaurantViewer, null);
				return "redirect:/restaurants/" + id + "?refresh=true";
			}
		}
	}
	
}
