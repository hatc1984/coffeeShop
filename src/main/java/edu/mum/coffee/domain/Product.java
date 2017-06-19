package edu.mum.coffee.domain;

import java.util.Date;

import javax.persistence.Entity;
import javax.persistence.EnumType;
import javax.persistence.Enumerated;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.validation.constraints.Min;
import javax.validation.constraints.NotNull;
import javax.validation.constraints.Past;

import org.hibernate.validator.constraints.NotEmpty;
import org.springframework.format.annotation.DateTimeFormat;

@Entity
public class Product {

	@Id
	@GeneratedValue
	private int id;

	@NotEmpty
	private String productName;

	@NotEmpty
	private String description;

	@NotNull
	@Min(value = 1)
	private double price;

	@Enumerated(EnumType.STRING)
	@NotNull
	private ProductType productType;

	@Min(value = 1)
	private int quantity;

	@Enumerated(EnumType.STRING)
	@NotNull
	private ManuFacturerType manufacturer;

	@NotNull
	@Temporal(TemporalType.DATE)
	@Past
	@DateTimeFormat(pattern = "yyyy-MM-dd")
	private Date created;

	// @Transient
	// private MultipartFile image;

	public Product() {
		super(); // default constructor
	}

	public Product(String productName, String description, double price, ProductType productType) {
		super();
		this.productName = productName;
		this.description = description;
		this.price = price;
		this.productType = productType;
	}

	public ProductType getProductType() {
		return productType;
	}

	public void setProductType(ProductType productType) {
		this.productType = productType;
	}

	public String getProductName() {
		return productName;
	}

	public void setProductName(String productName) {
		this.productName = productName;
	}

	public String getDescription() {
		return description;
	}

	public void setDescription(String description) {
		this.description = description;
	}

	public double getPrice() {
		return price;
	}

	public void setPrice(double price) {
		this.price = price;
	}

	public int getId() {
		return id;
	}

	public void setId(int id) {
		this.id = id;
	}

	public int getQuantity() {
		return quantity;
	}

	public void setQuantity(int quantity) {
		this.quantity = quantity;
	}

	public ManuFacturerType getManufacturer() {
		return manufacturer;
	}

	public void setManufacturer(ManuFacturerType manufacturer) {
		this.manufacturer = manufacturer;
	}

	// public MultipartFile getImage() {
	// return image;
	// }
	//
	// public void setImage(MultipartFile image) {
	// this.image = image;
	// }

	public Date getCreated() {
		return created;
	}

	public void setCreated(Date created) {
		this.created = created;
	}

}
