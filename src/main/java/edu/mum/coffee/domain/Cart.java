package edu.mum.coffee.domain;

import java.util.ArrayList;
import java.util.List;

public class Cart {
	private List<Product> products = new ArrayList<>();
	private int size;
	private double totalMoney;
	
	public List<Product> getProducts() {
		return products;
	}
	public void setProducts(List<Product> products) {
		this.products = products;
	}
	public int getSize() {
		size = products.size();
		return size;
	}
	public void setSize(int size) {
		this.size = size;
	}
	public double getTotalMoney() {
		totalMoney = products.stream().map(t -> t.getPrice()).reduce(0.0, Double::sum);
		return totalMoney;
	}
	public void setTotalMoney(double totalMoney) {
		this.totalMoney = totalMoney;
	}
	
}
