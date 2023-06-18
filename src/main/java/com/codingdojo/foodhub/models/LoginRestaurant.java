package com.codingdojo.foodhub.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LoginRestaurant {
	@Email
	@NotEmpty(message="Restaurant email cannot be empty")
	private String restaurantEmail;
	
	@Size(min=5, message="Password must be at least 5 characters")
	private String password;

	public LoginRestaurant() {}

	public String getRestaurantEmail() {
		return restaurantEmail;
	}

	public void setRestaurantEmail(String restaurantEmail) {
		this.restaurantEmail = restaurantEmail;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	
	
	
}
