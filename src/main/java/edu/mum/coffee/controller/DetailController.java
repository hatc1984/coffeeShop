package edu.mum.coffee.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductType;
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

	@GetMapping(value = "/productAll")
	public String showAllProduct(@RequestParam(value = "type", required = false) String type,
			@RequestParam(value = "index", required = false) String pageNumber, Model model,
			HttpServletRequest request) {
		String category_title = null;
		Page<Product> page = null;
		if ("t".equals(type)) {
			page = productService.findProductPaginationWithType(pageNumber == null ? 1 : Integer.parseInt(pageNumber),
					ProductType.TEA);
			category_title = "Tea";
		} else if ("bf".equals(type)) {
			page = productService.findProductPaginationWithType(pageNumber == null ? 1 : Integer.parseInt(pageNumber),
					ProductType.BREAKFAST);
			category_title = "Breakfast Coffee";
		} else if ("l".equals(type)) {
			page = productService.findProductPaginationWithType(pageNumber == null ? 1 : Integer.parseInt(pageNumber),
					ProductType.LUNCH);
			category_title = "Luch Coffee";
		} else if ("d".equals(type)) {
			page = productService.findProductPaginationWithType(pageNumber == null ? 1 : Integer.parseInt(pageNumber),
					ProductType.DINNER);
			category_title = "Dinner Coffee";
		}

		if (type == null || "".equals(type)) {
			page = productService.findProductPaginationWithType(pageNumber == null ? 1 : Integer.parseInt(pageNumber),
					ProductType.BREAKFAST);
			category_title = "Breakfast Coffee";
		}

		int current = page.getNumber() + 1;
		int begin = Math.max(1, current - 5);
		int end = Math.min(begin + 10, page.getTotalPages());

		model.addAttribute("deploymentLog", page);
		model.addAttribute("beginIndex", begin);
		model.addAttribute("endIndex", end);
		model.addAttribute("currentIndex", current);
		
		model.addAttribute("productAll", "productAll");
		model.addAttribute("category_title", category_title);
		model.addAttribute("products", page.getContent());

		return "productAll";
	}
	
	@RequestMapping(value = "/filter", method = RequestMethod.GET)
	public String searchProduct(@RequestParam("info") String query, @RequestParam(value = "type", required = false) String type,
			Model model,
			HttpServletRequest request) {
		List<Product> products = productService.findByTextSearch(query);
		model.addAttribute("products", products);
		return "productAll";
	}
}
