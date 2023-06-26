package com.codingdojo.foodhub.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import com.codingdojo.foodhub.services.BagService;

@Controller
public class BagController {
	@Autowired
	public BagService bServ;
	
	
}
