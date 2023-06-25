package com.codingdojo.foodhub.repositories;

import java.util.List;

import org.springframework.data.repository.CrudRepository;

import com.codingdojo.foodhub.models.Like;

public interface LikeRepository extends CrudRepository<Like, Long>{
	public List <Like> findAllByCommentId(Long id);
}
