package com.codingdojo.foodhub.models;

import java.util.Date;
import java.util.List;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;
import javax.persistence.OneToMany;
import javax.persistence.PrePersist;
import javax.persistence.Table;
import javax.persistence.Transient;
import javax.validation.constraints.Email;
import javax.validation.constraints.NotEmpty;
import javax.validation.constraints.Size;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="restaurants")
public class Restaurant {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@NotEmpty(message="Restaurant name cannot be empty")
	private String name;
	
	@Email
	@NotEmpty(message="Restaurant email cannot be empty")
	private String email;
	
	@Size(min=5, message="Password must contain at least 5 characters")
	private String password;
	
	@Transient
	private String confirmPw;
	
	@Lob
	@Column(columnDefinition="MEDIUMTEXT")
	private String profile;
	
	@OneToMany(mappedBy="restaurant", fetch = FetchType.LAZY)
	private List <Review> reviews;
	
	@OneToMany(mappedBy="restaurant", fetch=FetchType.LAZY)
	private List <Item> items;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created_at;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated_at;
    
    
    
	public Restaurant() {}

	
	
	public List<Review> getReviews() {
		return reviews;
	}



	public void setReviews(List<Review> reviews) {
		this.reviews = reviews;
	}



	public String getProfile() {
		return profile;
	}



	public void setProfile(String profile) {
		this.profile = profile;
	}



	public List<Item> getItems() {
		return items;
	}



	public void setItems(List<Item> items) {
		this.items = items;
	}



	public Long getId() {
		return id;
	}



	public void setId(Long id) {
		this.id = id;
	}



	public String getName() {
		return name;
	}



	public void setName(String name) {
		this.name = name;
	}



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



	public String getConfirmPw() {
		return confirmPw;
	}



	public void setConfirmPw(String confirmPw) {
		this.confirmPw = confirmPw;
	}


	




	public Date getCreated_at() {
		return created_at;
	}



	public void setCreated_at(Date created_at) {
		this.created_at = created_at;
	}



	public Date getUpdated_at() {
		return updated_at;
	}



	public void setUpdated_at(Date updated_at) {
		this.updated_at = updated_at;
	}



	@PrePersist
    protected void onCreate(){
        this.created_at = new Date();
    }
    
    
}
