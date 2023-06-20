package com.codingdojo.foodhub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.codingdojo.foodhub.services.ItemService;

@Controller
public class ItemController {
	@Autowired
	public ItemService iServ;
}
