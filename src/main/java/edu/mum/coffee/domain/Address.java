package edu.mum.coffee.domain;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

import org.hibernate.validator.constraints.NotEmpty;

@Entity
public class Address {

	@Id
	@GeneratedValue
	private int id;
	@NotEmpty(message = "City not empty")
	private String city;
	@NotEmpty(message = "State not empty")
	private String state;
	@NotEmpty(message = "Country not empty")
	private String country;
	@NotEmpty(message = "Zipcode not empty")
	private String zipcode;
	
	public Address(){}
	
	public Address(String city, String state, String country, String zipcode) {
		this.city = city;
		this.state = state;
		this.country = country;
		this.zipcode = zipcode;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getState() {
		return state;
	}

	public void setState(String state) {
		this.state = state;
	}

	public String getCountry() {
		return country;
	}

	public void setCountry(String country) {
		this.country = country;
	}

	public String getZipcode() {
		return zipcode;
	}

	public void setZipcode(String zipcode) {
		this.zipcode = zipcode;
	}
	
	public String toString() {
		StringBuilder combine = new StringBuilder();
		return combine.append(city)
				.append(" ,")
				.append(state)
				.append(" ,")
				.append(country)
				.append(" ,")
				.append(zipcode)
				.toString(); 
	}

}
