package com.codingdojo.foodhub.repositories;

import java.util.List;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Item;

public interface ItemRepository extends CrudRepository<Item, Long>{
	public List <Item> findAll();
	public Item findItemById(Long id);
	
	@Query(value="SELECT * FROM items WHERE restaurant_id = ?1", nativeQuery = true)
	public List <Item> findAllItemsByRestaurant(Long id);
	
	@Query(value="SELECT * FROM items WHERE restaurant_id = ?1 AND category = ?2", nativeQuery = true)
	public List <Item> findAllItemsByCategory(Long id, String category);
}
