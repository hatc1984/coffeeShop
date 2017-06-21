package edu.mum.coffee.controller;

import java.security.Principal;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.Cart;
import edu.mum.coffee.domain.Order;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.OrderService;
import edu.mum.coffee.service.PersonService;

@Controller
@RequestMapping("/order")
public class OrderController {

	@Autowired
	private OrderService orderService;
	@Autowired
	private PersonService personService;

	@RequestMapping(method = RequestMethod.GET)
	public String showOrder(@RequestParam(value = "action", required = false) String action,
			@RequestParam(value = "productId", required = false) String productId, HttpServletRequest request) {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if ("delete".equals(action)) {
			Iterator<Product> iterator = cart.getProducts().iterator();
			while (iterator.hasNext()) {
				Product product = iterator.next();
				if (product.getId() == Integer.parseInt(productId)) {
					iterator.remove();
				}
			}
		}
		request.getSession().setAttribute("cart", cart);
		return "shoppingCart";
	}

	@RequestMapping(value = "checkout", method = RequestMethod.GET)
	public String checkout(HttpServletRequest request, Principal principal) {
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		Order order = new Order();
		order.createOrderLine(cart.getProducts());
		order.setPerson(personService.findByEmail(principal.getName()).get(0));
		order.setOrderDate(new Date());
		Order orderSaved = orderService.save(order);
		if (orderSaved != null) {
			request.getSession().setAttribute("cart", null);
		}
		return "thankyou";
	}

	@RequestMapping(value = "list", method = RequestMethod.GET)
	public String getAllOrder(Model model) {
		List<Order> orders = orderService.findAll();
		model.addAttribute("orders", orders);
		return "orderManagement";
	}

	@RequestMapping(value = "detail", method = RequestMethod.GET)
	public String getOrderDetail(@RequestParam("orderId") String orderId, Model model) {
		Order order = orderService.findById(Integer.parseInt(orderId));
		model.addAttribute("orderLines", order.getOrderLines());
		return "orderDetail";
	}

}
