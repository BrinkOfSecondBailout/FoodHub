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
import com.codingdojo.foodhub.services.CommentService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;

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
	
	@PostMapping("/comments/add/{id}")
	public String newComment(@Valid @ModelAttribute("comment") Comment comment, 
			BindingResult result, 
			HttpSession session, 
			@PathVariable("id") Long id,
			Model model) {
		if (session.getAttribute("userId") == null && session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = restServ.findRestaurantById(id);
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			List <Review> reviews = rServ.findReviewsByRestaurant(id);
			if(result.hasErrors()) {
				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					model.addAttribute("restaurant", restaurant);
					model.addAttribute("items", items);
					model.addAttribute("userId", userId);
					model.addAttribute("reviews", reviews);
					return "restaurantDisplay.jsp";
				}
				// if viewer is a restaurant
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
				model.addAttribute("reviews", reviews);
				return "redirect:/restaurants/" + id;
			} else {
				
				cServ.createComment(comment, null, null);
				
				// if viewer is a user
				if (session.getAttribute("userId") != null) {
					Long userId = (Long) session.getAttribute("userId");
					model.addAttribute("restaurant", restaurant);
					model.addAttribute("items", items);
					model.addAttribute("userId", userId);
					model.addAttribute("reviews", reviews);
					return "restaurantDisplay.jsp";
				}
				// if viewer is a restaurant
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
				model.addAttribute("reviews", reviews);
				return "redirect:/restaurants/" + id;
			}
		}
	}
	
}
