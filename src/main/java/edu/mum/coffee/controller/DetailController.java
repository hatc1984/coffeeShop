package edu.mum.coffee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.ProductService;

@Controller
public class DetailController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping(value = "detailProduct", method = RequestMethod.GET)
	public String detailProduct(@RequestParam("id") String productId, Model model) {
		Product product = productService.getProduct(Integer.parseInt(productId));
		model.addAttribute("product", product);
		return "productDetail";
	}
}
