package com.codingdojo.foodhub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.codingdojo.foodhub.services.RestaurantService;

@Controller
public class RestaurantController {
	@Autowired
	public RestaurantService rServ;
	
	
}
