package com.codingdojo.foodhub.services;

import java.io.IOException;
import java.util.Base64;
import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.validation.BindingResult;
import org.springframework.web.multipart.MultipartFile;

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
		if(!BCrypt.checkpw(newLogin.getPassword(), restaurant.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid password, please try again");
			return null;
		}
		if (result.hasErrors()) {
			return null;
		}
		return restaurant;
	}
	
	public void addProfilePicture(Long id, MultipartFile file) {
		Restaurant r = rRepo.findRestaurantById(id);
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
		if(fileName.contains("..")) {
			System.out.println("Not a valid file");
		}
		try {
			r.setProfile(Base64.getEncoder().encodeToString(file.getBytes()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		rRepo.save(r);
	}
	
	public Restaurant findRestaurantById(Long id) {
		Optional <Restaurant> potentialRest = rRepo.findById(id);
		if(potentialRest.isEmpty()) {
			return null;
		} else {
			return potentialRest.get();
		}
	}
	
	public List <Restaurant> findAllNotById(Long id) {
		return rRepo.findAllNotById(id);
	}
	
	public Restaurant updateRestaurant(Restaurant restaurant) {
		return rRepo.save(restaurant);
	}
	
	public void delete(Long id) {
		rRepo.deleteById(id);
	}
}
