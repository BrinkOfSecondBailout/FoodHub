package com.codingdojo.foodhub.controllers;

import java.util.List;

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
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.LoginRestaurant;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.Review;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.CommentService;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.ReviewService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class RestaurantController {
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public UserService uServ;
	@Autowired
	public ItemService iServ;
	@Autowired
	public ReviewService reServ;
	@Autowired
	public CommentService cServ;
	
	
	@GetMapping("/restaurant")
	public String indexRestaurant(Model model) {
		model.addAttribute("newRestaurant", new Restaurant());
		model.addAttribute("newLoginRestaurant", new LoginRestaurant());
		return "restaurantIndex.jsp";
	}
	
	@PostMapping("/registerRestaurant")
	public String registerRestaurant(@Valid @ModelAttribute("newRestaurant") Restaurant restaurant, BindingResult result, Model model, HttpSession session) {
		Restaurant newRestaurant = rServ.register(restaurant, result);
		if(result.hasErrors()) {
			model.addAttribute("newLoginRestaurant", new LoginRestaurant());
			return "restaurantIndex.jsp";
		} else {
			session.setAttribute("restaurantId", newRestaurant.getId());
			return "redirect:/restaurantDashboard";
		}
	}
	
	
	@PostMapping("/loginRestaurant")
	public String loginRestaurant(@Valid @ModelAttribute("newLoginRestaurant") LoginRestaurant newLogin, BindingResult result, Model model, HttpSession session) {
		Restaurant restaurant = rServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newRestaurant", new Restaurant());
			return "restaurantIndex.jsp";
		} else {
			session.setAttribute("restaurantId", restaurant.getId());
			return "redirect:/restaurantDashboard";
		}
	}
	
	@GetMapping("/restaurantDashboard")
	public String restaurantDash(HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Long id = (Long) session.getAttribute("restaurantId");
			Restaurant restaurant = rServ.findRestaurantById(id);
			List <Restaurant> restaurants = rServ.findAllNotById(id);
			List <User> users = uServ.findAllUsers();
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			model.addAttribute("restaurant", restaurant);
			model.addAttribute("restaurants", restaurants);
			model.addAttribute("users", users);
			model.addAttribute("items", items);
			return "restaurantDashboard.jsp";
		}
	}
	
	@GetMapping("/restaurants/edit")
	public String editRestProfile(HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			model.addAttribute("restaurant", restaurant);
			return "editRestaurantProfile.jsp";
		}
	}
	
	
	
	@PutMapping("/restaurants/newprofile")
	public String updateProfilePicture(@Valid @ModelAttribute("restaurant") Restaurant restaurant, 
			BindingResult result, HttpSession session,
			@RequestParam("profile") MultipartFile file) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Long id = (Long) session.getAttribute("restaurantId");
			if(file.isEmpty()) {
				result.rejectValue("profile", "error.profile", "Please upload an image");
			} else {
				rServ.addProfilePicture(id, file);				
			}
			if(result.hasErrors()) {
				return "redirect:/restaurants/edit";
			}
			return "redirect:/restaurants/edit";
		}
	}
	
	
	
	@GetMapping("/restaurants/{id}")
	public String displayRestaurant(@PathVariable("id") Long id, HttpSession session, Model model, @ModelAttribute("comment") Comment comment) {
		if(session.getAttribute("restaurantId") == null && session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = rServ.findRestaurantById(id);
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			List <Review> reviews = reServ.findReviewsByRestaurant(id);
			Integer average = reServ.findAverageRatingByRestaurant(id);
			List <Item> breakfast = iServ.findAllByCategory(id, "Breakfast");
			List <Item> lunch = iServ.findAllByCategory(id, "Lunch");
			List <Item> dinner = iServ.findAllByCategory(id, "Dinner");
			List <Item> dessert = iServ.findAllByCategory(id, "Dessert");
			List <Item> drinks = iServ.findAllByCategory(id, "Drinks");
			List <Item> others = iServ.findAllByCategory(id, "Others");
			// if viewer is a user
			if (session.getAttribute("userId") != null) {
				Long userId = (Long) session.getAttribute("userId");
				User user = uServ.findUserById(userId);
				model.addAttribute("userId", userId);
				model.addAttribute("average", average);
				model.addAttribute("restaurant", restaurant);
				model.addAttribute("items", items);
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
			Restaurant restaurantViewer = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
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
		}
	}
	
}
