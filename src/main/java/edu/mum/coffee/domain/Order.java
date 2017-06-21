package edu.mum.coffee.domain;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;

import javax.persistence.CascadeType;
import javax.persistence.Entity;
import javax.persistence.FetchType;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.OneToMany;
import javax.persistence.OneToOne;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

@Entity
@Table(name = "OrderTable")
public class Order {

	@Id
	@GeneratedValue
	private int id;
	@Temporal(TemporalType.DATE)
	private Date orderDate;

	@OneToMany(mappedBy = "order", fetch = FetchType.EAGER, cascade = CascadeType.ALL)
	private List<Orderline> orderLines = new ArrayList<Orderline>();
	@OneToOne
	private Person person;

	public int getId() {
		return id;
	}

	public List<Orderline> getOrderLines() {
		return Collections.unmodifiableList(orderLines);
	}

	public Person getPerson() {
		return person;
	}

	public void setPerson(Person person) {
		this.person = person;
	}

	public Date getOrderDate() {
		return orderDate;
	}

	public void setOrderDate(Date orderDate) {
		this.orderDate = orderDate;
	}

	public int getQuantity() {
		int quantity = 0;
		for (Orderline ol : this.orderLines) {
			quantity += ol.getQuantity();
		}
		return quantity;
	}

	public double getTotalAmount() {
		double totalAmount = 0;

		for (Orderline ol : this.orderLines) {
			totalAmount += ol.getSubtotal();
		}
		return totalAmount;
	}

	public void addOrderLine(Orderline orderLine) {
		orderLine.setOrder(this);
		this.orderLines.add(orderLine);
	}

	public void removeOrderLine(Orderline orderLine) {
		this.orderLines.remove(orderLine);
		orderLine.setOrder(null);
	}

	public void clearOrderLines() {
		for (Orderline orderline : orderLines) {
			orderline.setOrder(null);
		}
		orderLines.clear();
	}
	
	private Orderline checkProductExistInAnyOrderLine(Product product) {
		for(Orderline orderLine : this.getOrderLines()) {
			if (orderLine.getProduct().getId() == product.getId()) {
				return orderLine;
			}
		}
		return null;
	}
	
	public void createOrderLine(List<Product> productsAtCart) {
		for(Product product: productsAtCart) {
			Orderline orderLineContainProduct = checkProductExistInAnyOrderLine(product);
			if (orderLineContainProduct != null) {
				orderLineContainProduct.setQuantity(orderLineContainProduct.getQuantity() + 1);
			} else {
				Orderline orderline = new Orderline();
				orderline.setProduct(product);
				orderline.setOrder(this);
				orderline.setQuantity(1);
				this.addOrderLine(orderline);
			}
		}
	}

}
