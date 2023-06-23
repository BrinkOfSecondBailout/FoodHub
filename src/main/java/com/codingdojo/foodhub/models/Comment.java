package com.codingdojo.foodhub.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.JoinColumn;
import javax.persistence.ManyToOne;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="comments")
public class Comment {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	
	
	
	@ManyToOne(fetch = FetchType.LAZY)
    @JoinColumn(name="review_id")
	private Review review;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created_at;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated_at;
    
    @PrePersist
    protected void onCreate(){
        this.created_at = new Date();
    }
	
}
