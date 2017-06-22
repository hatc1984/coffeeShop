package edu.mum.coffee.service;

import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.mum.coffee.domain.CartInfo;
import edu.mum.coffee.domain.CartLineInfo;
import edu.mum.coffee.domain.Order;
import edu.mum.coffee.domain.Orderline;
import edu.mum.coffee.domain.Person;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.repository.OrderRepository;

@Service
@Transactional
public class OrderService {
	@Autowired
	private OrderRepository orderRepository;
	
	@Autowired
	private ProductService productService;
	
	public Order save(Order order){
		return orderRepository.save(order);
	}
	
	public Order save(User ship_customer, CartInfo cartInfo){
		Order order = new Order();
		order.setOrderDate(new Date());
		order.setPerson(cartInfo.getCustomerInfo());
		List<CartLineInfo> cartlines = cartInfo.getCartLines();
		for( CartLineInfo cl:cartlines){
			Orderline orderLine = new Orderline();
			orderLine.setQuantity(cl.getQuantity());
			Product editedProduct = productService.getProduct(cl.getProductInfo().getId());
			editedProduct.setQuantity(editedProduct.getQuantity()-cl.getQuantity());
			productService.save(editedProduct);
			orderLine.setProduct(productService.getProduct(cl.getProductInfo().getId()));
			orderLine.setOrder(order);
			order.addOrderLine(orderLine);
		}
		String shipInfo = (new StringBuilder()).append(ship_customer.getFirstName())
				.append(" ")
				.append(ship_customer.getFirstName())
				.append(" ")
				.append(ship_customer.getLastName())
				.append(", ")
				.append(ship_customer.getEmail())
				.append(", ")
				.append(ship_customer.getPhone())
				.append(", ")
				.append(ship_customer.getAddress().toString())
				.toString();
		order.setShippingInfo(shipInfo);
		return orderRepository.save(order);
	}
	public void delete(Order order){
		orderRepository.delete(order);
	}
	
	public List<Order> findByProduct(Product product) {
		return orderRepository.findDistinctOrderByOrderLines_Product(product);
	}
	
	public List<Order> findByPerson(Person person) {
		return orderRepository.findOrderByPerson(person);
	}

	public List<Order> findByDate(Date minDate, Date maxDate) {
		return orderRepository.findOrderByOrderDateBetween(minDate, maxDate);
	}

	public Order findById(int id){
		return orderRepository.findOne(id);
	}

	public List<Order> findAll(){
		return orderRepository.findAll();
	}

}
