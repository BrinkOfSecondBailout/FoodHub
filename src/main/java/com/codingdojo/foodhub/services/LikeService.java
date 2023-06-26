package com.codingdojo.foodhub.services;

import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.codingdojo.foodhub.models.Comment;
import com.codingdojo.foodhub.models.Like;
import com.codingdojo.foodhub.models.Restaurant;
import com.codingdojo.foodhub.models.User;
import com.codingdojo.foodhub.repositories.LikeRepository;

@Service
public class LikeService {
	@Autowired
	private LikeRepository lRepo;
	
	public LikeService(LikeRepository lRepo) {
		this.lRepo = lRepo;
	}
	
	public Like createLike(Like like, Comment comment, User user, Restaurant restaurant) {
		like.setComment(comment);
		like.setUser(user);
		like.setRestaurant(restaurant);
		return lRepo.save(like);
	}
	
	public List <Like> findAllLikesByComments(Long id) {
		return lRepo.findAllByCommentId(id);
	}
	
	public Like findLikeById(Long id) {
		Optional <Like> potentialLike = lRepo.findById(id);
		if(potentialLike.isEmpty()) {
			return null;
		} else {
			return potentialLike.get();
		}
	}
	
	public void delete(Long id) {
		lRepo.deleteById(id);
	}
}
