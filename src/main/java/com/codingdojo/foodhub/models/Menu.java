package com.codingdojo.foodhub.models;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.PrePersist;
import javax.persistence.Table;

import org.springframework.format.annotation.DateTimeFormat;

@Entity
@Table(name="menus")
public class Menu {
	@Id
	@GeneratedValue(strategy=GenerationType.IDENTITY)
	private Long id;
	
	@Column(updatable=false)
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date created_at;
    @DateTimeFormat(pattern="yyyy-MM-dd")
    private Date updated_at;
    
    public Menu() {};
    
    @PrePersist
    protected void onCreate(){
        this.created_at = new Date();
    }
    
    
}
