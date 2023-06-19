package com.codingdojo.foodhub.services;

import java.util.List;
import java.util.Optional;

import org.mindrot.jbcrypt.BCrypt;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.validation.BindingResult;

import com.codingdojo.foodhub.models.LoginUser;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.repositories.UserRepository;

@Service
public class UserService {
	@Autowired
	private UserRepository uRepo;
	
	public UserService (UserRepository uRepo) {
		this.uRepo = uRepo;
	}
	
	public List <User> findAllUsers() {
		return uRepo.findAll();
	}
	
	public User getByEmail (String email) {
		Optional <User> optUser = uRepo.findByEmail(email);
		if (optUser.isEmpty()) {
			return null;
		} else {
			return optUser.get();
		}
	}
	
	public User register (User newUser, BindingResult result) {
		String emailTyped = newUser.getEmail();
		Optional <User> potentialUser = uRepo.findByEmail(emailTyped);
		if (potentialUser.isPresent()) {
			result.rejectValue("email", "Matches", "This email already exists in our database");
		} 
		if (!newUser.getPassword().equals(newUser.getConfirmPw())) {
			result.rejectValue("password", "Matches", "Please make sure passwords are matching");
		}
		if (result.hasErrors()) {
			return null;
		}
		String hashed = BCrypt.hashpw(newUser.getPassword(), BCrypt.gensalt());
		newUser.setPassword(hashed);
		return uRepo.save(newUser);
	}
	
	public User login (LoginUser newLogin, BindingResult result) {
		String emailTyped = newLogin.getEmail();
		Optional <User> potentialUser = uRepo.findByEmail(emailTyped);
		if (potentialUser.isEmpty()) {
			result.rejectValue("email", "Matches", "No user with that email exists");
			return null;
		}
		User user = potentialUser.get();
		if (!BCrypt.checkpw(newLogin.getPassword(), user.getPassword())) {
			result.rejectValue("password", "Matches", "Invalid password, please try again");
			return null;
		}
		if (result.hasErrors()) {
			return null;
		}
		return user;
	}
	
	public User findUserById (Long id) {
		Optional <User> potentialUser = uRepo.findById(id);
		if (potentialUser.isEmpty()) {
			return null;
		} else {
			return potentialUser.get();
		}
	}
	
	public User updateUser (User user) {
		return uRepo.save(user);
	}
	
	public void delete (Long id) {
		uRepo.deleteById(id);
	}
	
}
