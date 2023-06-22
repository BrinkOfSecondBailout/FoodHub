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

import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;

@Controller
public class ItemController {
	@Autowired
	public ItemService iServ;
	@Autowired
	public RestaurantService rServ;
	
	@GetMapping("/items/add")
	public String addItem(@ModelAttribute("item") Item item, HttpSession session) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			return "newItem.jsp";			
		}
	}
	
	
	
	@PostMapping("/items/new")
	public String newItem(@Valid @ModelAttribute("item") Item item, BindingResult result,
			HttpSession session) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			if (result.hasErrors()) {
				return "newItem.jsp";
			} else {
				Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
				Long id = (Long) iServ.createItem(item, restaurant).getId();
				return "redirect:/items/picture/" + id;
			}
		}
	}
	
	@GetMapping("/items/picture/{id}")
	public String addPicture(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		Item item = iServ.findItemById(id);
		if(!item.getRestaurant().getId().equals(session.getAttribute("restaurantId"))) {
			return "redirect:/restaurantDashboard";
		} else {
			model.addAttribute("item", item);
			return "addItemPicture.jsp";
		}
	}
	
	@PutMapping("/items/processpicture")
	public String processPicture(@Valid @ModelAttribute("item") Item item, 
			BindingResult result,
			HttpSession session,
			@RequestParam("file") MultipartFile file) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			iServ.addItemPicture(file, item);
			return "redirect:/items/edit/" + (Long) session.getAttribute("restaurantId");
		}
	}
	
	
	@GetMapping("/items/edit/{id}")
	public String editMenu(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		if(!id.equals(session.getAttribute("restaurantId"))) {
			return "redirect:/restaurantDashboard";
		} else {
			List <Item> items = iServ.findAllItemsByRestaurantId(id);
			Restaurant restaurant = rServ.findRestaurantById(id);
			model.addAttribute("items", items);
			model.addAttribute("restaurant", restaurant);
			return "editMenu.jsp";
		}
	}
	
	@GetMapping("/items/{id}")
	public String displayItem(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null && session.getAttribute("userId") == null) {
			return "redirect:/logout";
		} else {
			Long restaurantId = (Long) session.getAttribute("restaurantId");
			Item item = iServ.findItemById(id);
			model.addAttribute("item", item);
			model.addAttribute("restaurantId", restaurantId);
			return "itemDisplay.jsp";
		}
	}
}
