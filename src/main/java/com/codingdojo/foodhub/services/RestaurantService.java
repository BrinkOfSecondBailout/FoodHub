package com.codingdojo.foodhub.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.foodhub.models.LoginRestaurant;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.repositories.RestaurantRepository;

@Service
public class RestaurantService {
	@Autowired
	private RestaurantRepository rRepo;
	
	public RestaurantService(RestaurantRepository rRepo) {
		this.rRepo = rRepo;
	}
	
	public List <Restaurant> findAllRestaurants() {
		return rRepo.findAll();
	}
	
	public Restaurant getByEmail(String email) {
		Optional <Restaurant> optRest = rRepo.findByEmail(email);
		if (optRest.isEmpty()) {
			return null;
		} else {
			return optRest.get();
		}
	}
	
	public Restaurant register(Restaurant newRestaurant, BindingResult result) {
		String emailTyped = newRestaurant.getEmail();
		Optional <Restaurant> potentialRest = rRepo.findByEmail(emailTyped);
		if (potentialRest.isPresent()) {
			result.rejectValue("email", "Matches", "This email already exists in our database");
		} 
		if (!newRestaurant.getPassword().equals(newRestaurant.getConfirmPw())){
			result.rejectValue("email", "Matches", "Please make sure passwords are matching");
		}
		if (result.hasErrors()) {
			return null;
		}
		String hashed = BCrypt.hashpw(newRestaurant.getPassword(), BCrypt.gensalt());
		newRestaurant.setPassword(hashed);
		return rRepo.save(newRestaurant);
	}
	
	public Restaurant login(LoginRestaurant newLogin, BindingResult result) {
		String emailTyped = newLogin.getEmail();
		Optional <Restaurant> potentialRest = rRepo.findByEmail(emailTyped);
		if (potentialRest.isEmpty()) {
			result.rejectValue("email", "Matches", "No restaurant with that email exists");
			return null;
		}
		Restaurant restaurant = potentialRest.get();
		if(BCrypt.checkpw(newLogin.getPassword(), restaurant.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid password, please try again");
			return null;
		}
		if (result.hasErrors()) {
			return null;
		}
		return restaurant;
	}
}
