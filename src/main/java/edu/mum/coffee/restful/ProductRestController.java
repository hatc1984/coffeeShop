package edu.mum.coffee.restful;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import edu.mum.coffee.domain.Cart;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.ProductService;

@RestController
@RequestMapping("/rest/productRestFul")
public class ProductRestController {
	
	@Autowired
	private ProductService productService;
	
	@GetMapping(value="/list")
	public List<Product> listAllProduct() {
		List<Product> products = productService.getAllProduct();
		return products;
	}
	
	@GetMapping(value = "/addToCart")
	public Cart addProductPage(@RequestParam("productId") String productId, HttpServletRequest request) {
		Product productToAddToCart = productService.getProduct(Integer.parseInt(productId));
		Cart cart = (Cart) request.getSession().getAttribute("cart");
		if (cart == null) {
			cart = new Cart();
			cart.getProducts().add(productToAddToCart);
		} else {
			cart.getProducts().add(productToAddToCart);
		}
		request.getSession().setAttribute("cart", cart);
		return cart;
	}
	
	@GetMapping(value="/delete/{id}")
	public List<Product> deleteProduct(@PathVariable("id") String productId) {
		return productService.deleteAPI(Integer.parseInt(productId));
	}
	
	@GetMapping(value="/get/{id}")
	public Product findProduct(@PathVariable("id") String productId) {
		return productService.getProduct(Integer.parseInt(productId));
	}
	
	@PostMapping(value="/update") 
	public List<Product> updateProduct(@Valid @RequestBody Product product) {
		return productService.updateProductAPI(product);
	}
	
	@PostMapping(value="/insert")
	public List<Product> insertProduct(@Valid @RequestBody Product product) {
		return productService.insertProductAPI(product);
	}
}
