package com.codingdojo.foodhub.controllers;

import javax.servlet.http.HttpSession;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class ReviewController {
	@Autowired
	public ReviewService rServ;
	@Autowired
	public RestaurantService restServ;
	@Autowired
	public UserService uServ;
	
	@GetMapping("/reviews/new/{id}")
	public String newReview(@PathVariable("id") Long id, Model model, @ModelAttribute("review") Review review, HttpSession session) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		Restaurant restaurant = restServ.findRestaurantById(id);
		model.addAttribute("restaurant", restaurant);
		return "newReview.jsp";
	}
	
	@PostMapping("/reviews/add/{id}")
	public String addReview(@Valid @ModelAttribute("review") Review review, 
			BindingResult result, 
			HttpSession session,
			Model model,
			@PathVariable("id") Long id) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = restServ.findRestaurantById(id);
			if(result.hasErrors()) {
				model.addAttribute("restaurant", restaurant);
				return "newReview.jsp";
			} else {
				User user = uServ.findUserById((Long) session.getAttribute("userId"));
				rServ.createReview(review, restaurant, user);
				return "redirect:/restaurants/" + id;
			}			
		}
		
	}
}
