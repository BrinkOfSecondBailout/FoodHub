package com.codingdojo.foodhub.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.Bag;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.repositories.BagRepository;

@Service
public class BagService {
	@Autowired
	private BagRepository bRepo;
	
	public BagService(BagRepository bRepo) {
		this.bRepo = bRepo;
	}
	
	public Bag createBag(User user) {
		Bag newBag = new Bag();
		user.setBag(newBag);
		newBag.setUser(user);
		return bRepo.save(newBag);
	}
}
