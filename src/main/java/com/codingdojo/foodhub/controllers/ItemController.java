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
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.services.ItemService;
import com.codingdojo.foodhub.services.RestaurantService;
import com.codingdojo.foodhub.services.UserService;

@Controller
public class ItemController {
	@Autowired
	public ItemService iServ;
	@Autowired
	public RestaurantService rServ;
	@Autowired
	public UserService uServ;
	
	@GetMapping("/items/add")
	public String addItem(@ModelAttribute("item") Item item, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			model.addAttribute("restaurant", restaurant);
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
			Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
			model.addAttribute("restaurant", restaurant);
			return "addItemPicture.jsp";
		}
	}
	
	@PutMapping("/items/processpicture/{id}")
	public String processPicture(@Valid @ModelAttribute("item") Item item, 
			BindingResult result,
			HttpSession session,
			@PathVariable("id") Long id,
			@RequestParam("file") MultipartFile file) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			if(file.isEmpty()) {
				result.rejectValue("file", "error.file", "Please upload an image");
			} else {
				iServ.addItemPicture(id, file);
				return "redirect:/items/edit/" + (Long) session.getAttribute("restaurantId");
			}
			if(result.hasErrors()) {
				return "redirect:/items/picture/" + id;
			}
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
			if(session.getAttribute("userId") != null) {
				User user = uServ.findUserById((Long) session.getAttribute("userId"));
				Item item = iServ.findItemById(id);
				model.addAttribute("item", item);
				model.addAttribute("user", user);
				return "itemDisplay.jsp";
			}
			
			Long restaurantId = (Long) session.getAttribute("restaurantId");
			Restaurant restaurant = rServ.findRestaurantById(restaurantId);
			Item item = iServ.findItemById(id);
			model.addAttribute("item", item);
			model.addAttribute("restaurant", restaurant);
			return "itemDisplay.jsp";
		}
	}
	
	@GetMapping("/items/item/edit/{id}")
	public String editItem(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		Item item = iServ.findItemById(id);
		if(!item.getRestaurant().getId().equals(session.getAttribute("restaurantId"))){
			return "redirect:/restaurantDashboard";
		}
		Restaurant restaurant = rServ.findRestaurantById((Long) session.getAttribute("restaurantId"));
		model.addAttribute("restaurant", restaurant);
		model.addAttribute("item", item);
		return "editItem.jsp";
	}
	
	@PutMapping("/items/item/update/{id}")
	public String updateItem(@Valid @ModelAttribute("item") Item item, 
			BindingResult result, @PathVariable("id") Long id, 
			@RequestParam("file") String file,
			HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		Long restaurantId = (Long) session.getAttribute("restaurantId");
		Restaurant restaurant = rServ.findRestaurantById(restaurantId);
		if (result.hasErrors()) {
			model.addAttribute("restaurant", restaurant);
			return "editItem.jsp";
		}
		item.setFile(file);
		iServ.updateItem(item, restaurant);
 		return "redirect:/items/edit/" + restaurantId;
	}
	
	@GetMapping("/items/item/delete/{id}")
	public String deleteItem(@PathVariable("id") Long id, HttpSession session) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		Item item = iServ.findItemById(id);
		Long restaurantId = (Long) session.getAttribute("restaurantId");
		if(!item.getRestaurant().getId().equals(session.getAttribute("restaurantId"))){
			return "redirect:/restaurantDashboard";
		}
		iServ.deleteItem(item);
		return "redirect:/items/edit/" + restaurantId;
	}
	
	@GetMapping("/items/changepicture/{id}")
	public String changeItemPicture(@PathVariable("id") Long id, HttpSession session, Model model) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		}
		Item item = iServ.findItemById(id);
		if(!item.getRestaurant().getId().equals(session.getAttribute("restaurantId"))){
			return "redirect:/restaurantDashboard";
		}
		Long restaurantId = (Long) session.getAttribute("restaurantId");
		Restaurant restaurant = rServ.findRestaurantById(restaurantId);
		model.addAttribute("item", item);
		model.addAttribute("restaurant", restaurant);
		return "changePicture.jsp";
	}
	
	@PutMapping("/items/processnewpicture/{id}")
	public String processNewPicture(@Valid @ModelAttribute("item") Item item, 
			BindingResult result,
			HttpSession session,
			@PathVariable("id") Long id,
			@RequestParam("file") MultipartFile file) {
		if(session.getAttribute("restaurantId") == null) {
			return "redirect:/logout";
		} else {
			if(file.isEmpty()) {
				result.rejectValue("file", "error.file", "Please upload an image");
				return "redirect:/items/changepicture/" + id;
			}
			iServ.addItemPicture(id, file);
			return "redirect:/items/edit/" + (Long) session.getAttribute("restaurantId");
		}
	}
}
