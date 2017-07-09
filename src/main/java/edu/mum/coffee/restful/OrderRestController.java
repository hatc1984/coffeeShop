package edu.mum.coffee.restful;

import java.security.Principal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import edu.mum.coffee.domain.Cart;
import edu.mum.coffee.domain.Order;
import edu.mum.coffee.domain.Orderline;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.OrderService;
import edu.mum.coffee.service.PersonService;

@RestController
@RequestMapping("/rest/orderRestFul")
public class OrderRestController {
	@Autowired
	private OrderService orderService;
	@Autowired
	private PersonService personService;
	
	@GetMapping(value = "/list")
	public List<Order> getAllOrder(Model model) {
		List<Order> orders = orderService.findAll();
		return orders;
	}
	
	@GetMapping(value = "/detail/{orderId}")
	public List<Orderline> getOrderDetail(@PathVariable("orderId") String orderId) {
		Order order = orderService.findById(Integer.parseInt(orderId));
		return order.getOrderLines();
	}
	
	@GetMapping(value = "/removeFromOrder/{productId}")
	public Cart showOrder(@PathVariable("productId") String productId, HttpServletRequest request) {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		Iterator<Product> iterator = cart.getProducts().iterator();
		while (iterator.hasNext()) {
			Product product = iterator.next();
			if (product.getId() == Integer.parseInt(productId)) {
				iterator.remove();
			}
		}
		request.getSession().setAttribute("cart", cart);
		return cart;
	}
	
	@GetMapping(value = "/checkout")
	public Cart checkout(HttpServletRequest request, Principal principal) {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		Order order = new Order();
		order.createOrderLine(cart.getProducts());
		order.setPerson(personService.findByEmail(principal.getName()).get(0));
		order.setOrderDate(new Date());
		Order orderSaved = orderService.save(order);
		if (orderSaved != null) {
			request.getSession().setAttribute("cart", null);
		}
		return cart;
	}
}
