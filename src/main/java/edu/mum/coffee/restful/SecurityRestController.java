package edu.mum.coffee.restful;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductType;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.service.UserService;

@RestController
public class SecurityRestController {
	
	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@GetMapping(value = "rest/home")
	public List<List<Product>> homePage() {
		List<Product> products = productService.getAllProduct();
		List<Product> productsBF = new ArrayList<>();
		List<Product> productsLunch = new ArrayList<>();
		List<Product> productsDinner = new ArrayList<>();
		for (Product product : products) {
			if (product.getProductType() == ProductType.BREAKFAST) {
				productsBF.add(product);
			} else if (product.getProductType() == ProductType.LUNCH) {
				productsLunch.add(product);
			} else {
				productsDinner.add(product);
			}
		}
		return new ArrayList<>(Arrays.asList(productsBF,productsLunch,productsDinner));
	}
	
	@PostMapping(value = "/rest/login")
	public User login(@RequestBody User users) {
		User user = userService.authenticate(users);
		return user;
	}
	
	@PostMapping(value = "/rest/signup")
	public ResponseEntity<?> register(@Validated @RequestBody User users, BindingResult result, Model model) throws Exception {
		if (!result.hasErrors()) {
			return ResponseEntity.ok(userService.save(users));
		} else {
			return ResponseEntity.badRequest().body(result);
		}
	}
}
