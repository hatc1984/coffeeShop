package edu.mum.coffee.domain;

import java.util.List;

import javax.persistence.Entity;


public class ProductInfo {

	private int id;

	private String productName;

	private String description;

	private double price;

	private ProductType productType;

	private int quantity;

	private ManuFacturerType manufacturer;
	
	private List<Image> image;
	
	private boolean newProduct=false;

	public ProductInfo() {
		super(); // default constructor
	}

	public ProductInfo(int id, String productName, String description, double price, ProductType productType,
			int quantity, ManuFacturerType manufacturer, List<Image> image) {
		this.id = id;
		this.productName = productName;
		this.description = description;
		this.price = price;
		this.productType = productType;
		this.quantity = quantity;
		this.manufacturer = manufacturer;
		this.image =  image;
	}
	
    public ProductInfo(Product product) {
		this.id = product.getId();
		this.productName = product.getProductName();
		this.description = product.getDescription();
		this.price = product.getPrice();
		this.productType = product.getProductType();
		this.quantity = product.getQuantity();
		this.manufacturer = product.getManufacturer();
		this.image =  product.getImage();
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

    public boolean isNewProduct() {
        return newProduct;
    }
 
    public void setNewProduct(boolean newProduct) {
        this.newProduct = newProduct;
    }
	public List<Image> getImage() {
		return image;
	}

	public void setImage(List<Image> image) {
		this.image = image;
	}
}
