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
import com.codingdojo.foodhub.models.LoginUser;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.UserService;


@Controller
public class UserController {
	@Autowired
	public UserService uServ;
	@Autowired
	public RestaurantService rServ;
	
	@GetMapping("/")
	public String index(Model model) {
		model.addAttribute("newUser", new User());
		model.addAttribute("newLogin", new LoginUser());
		return "index.jsp";
	}
	
	
	@PostMapping("/register")
	public String register(@Valid @ModelAttribute("newUser") User user, BindingResult result, Model model, HttpSession session) {
		User newUser = uServ.register(user, result);
		if(result.hasErrors()) {
			model.addAttribute("newLogin", new LoginUser());
			return "index.jsp";
		} else {
			session.setAttribute("userId", newUser.getId());
			return "redirect:/dashboard";			
		}
	}
	
	@PostMapping("/login")
	public String login(@Valid @ModelAttribute("newLogin") LoginUser newLogin, BindingResult result, Model model, HttpSession session) {
		User user = uServ.login(newLogin, result);
		if(result.hasErrors()) {
			model.addAttribute("newUser", new User());
			return "index.jsp";
		} else {
			session.setAttribute("userId", user.getId());
			return "redirect:/dashboard";
		}
	}
	
	@GetMapping("/dashboard")
	public String userDash(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			User user = uServ.findUserById((Long) session.getAttribute("userId"));
			List <Restaurant> restaurants = rServ.findAllRestaurants();
			model.addAttribute("user", user);
			model.addAttribute("restaurants", restaurants);
			return "userDashboard.jsp";
		}
	}
	
	@GetMapping("/users/edit")
	public String editProfile(HttpSession session, Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			User user = uServ.findUserById((Long) session.getAttribute("userId"));
			model.addAttribute("user", user);
			return "editUserProfile.jsp";
		}
	}
	
	@GetMapping("/logout")
	public String logout(HttpSession session) {
		session.removeAttribute("userId");
		return "redirect:/";
	}
}
