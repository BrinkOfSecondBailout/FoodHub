package com.codingdojo.foodhub.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.repositories.RestaurantRepository;

@Service
public class RestaurantService {
	@Autowired
	private RestaurantRepository rRepo;
	
	
}
