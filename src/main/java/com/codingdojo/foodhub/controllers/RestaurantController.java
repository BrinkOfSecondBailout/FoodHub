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
import org.springframework.web.bind.annotation.PostMapping;

import com.codingdojo.foodhub.models.LoginRestaurant;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class RestaurantController {
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public UserService uServ;
	
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
			return "redirect:/logoutRestaurant";
		} else {
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			List <User> users = uServ.findAllUsers();
			model.addAttribute("restaurant", restaurant);
			model.addAttribute("users", users);
			return "restaurantDashboard.jsp";
		}
	}
	
	@GetMapping("/logoutRestaurant")
	public String logout(HttpSession session) {
		session.removeAttribute("restaurantId");
		return "redirect:/restaurant";
	}
}
