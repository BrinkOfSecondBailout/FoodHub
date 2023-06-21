package com.codingdojo.foodhub.repositories;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.User;

public interface UserRepository extends CrudRepository<User, Long>{
	public Optional <User> findByEmail(String email);
	public Optional <User> findById(Long id);
	public User findUserById(Long id);
	public List <User> findAll();
	public void deleteById(Long id);
	
	@Query(value="SELECT * FROM users WHERE id != ?1", nativeQuery = true)
	public List <User> findAllUsersNotById(Long id);
}
