package com.codingdojo.foodhub.controllers;

import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;

import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.BagService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class BagController {
	@Autowired
	public BagService bServ;
	@Autowired
	public UserService uServ;
	
	@GetMapping("/bags/show/{id}")
	public String showBag(@PathVariable("id") Long id,
			HttpSession session,
			Model model) {
		if(session.getAttribute("userId") == null) {
			return "redirect:/logout";
		}
		User user = uServ.findUserById((Long) session.getAttribute("userId"));
		model.addAttribute("user", user);
		return "bagDisplay.jsp";
	}
}
