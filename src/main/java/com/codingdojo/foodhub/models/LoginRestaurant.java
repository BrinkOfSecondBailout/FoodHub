package com.codingdojo.foodhub.models;

import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

public class LoginRestaurant {
	@Email
	@NotEmpty(message="Restaurant email cannot be empty")
	private String email;
	
	@Size(min=5, message="Password must be at least 5 characters")
	private String password;

	public LoginRestaurant() {}

	public String getEmail() {
		return email;
	}

	public void setEmail(String email) {
		this.email = email;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}
	
	

	
	
	
	
}
