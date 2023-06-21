package com.codingdojo.foodhub.services;

import java.io.IOException;
import java.math.BigDecimal;
import java.util.Base64;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;
import org.springframework.web.multipart.MultipartFile;

import com.codingdojo.foodhub.models.Item;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.repositories.ItemRepository;

@Service
public class ItemService {
	@Autowired
	private ItemRepository iRepo;
	
	public ItemService(ItemRepository iRepo) {
		this.iRepo = iRepo;
	}
	
	public void saveItemToDB(MultipartFile file, String name, BigDecimal price, String description, String category, Restaurant restaurant) {
		Item item = new Item();
		String fileName = StringUtils.cleanPath(file.getOriginalFilename());
		if(fileName.contains("..")) {
			System.out.println("Not a valid file");
		}
		try {
			item.setFile(Base64.getEncoder().encodeToString(file.getBytes()));
		} catch (IOException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		item.setName(name);
		item.setPrice(price);
		item.setDescription(description);
		item.setCategory(category);
		item.setRestaurant(restaurant);
		iRepo.save(item);
	}
	
}
