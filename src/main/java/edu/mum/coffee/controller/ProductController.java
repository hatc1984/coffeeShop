package edu.mum.coffee.controller;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.Product;
import edu.mum.coffee.service.ProductService;

@Controller
@RequestMapping("/product")
public class ProductController {
	
	@Autowired
	private ProductService productService;
	
	@RequestMapping(method = RequestMethod.GET, value = "add")
	public String addProductPage(Model model) {
		Product product = new Product();
		model.addAttribute("product", product);
		return "modifyProduct";
	}
	
	@RequestMapping(method = RequestMethod.GET, value="list")
	public String listAllProduct(@RequestParam(value = "index",required = false) String pageNumber, Model model) {

			Page<Product> page = productService.findProductPagination(pageNumber == null ? 1 : Integer.parseInt(pageNumber));

		    int current = page.getNumber() + 1;
		    int begin = Math.max(1, current - 5);
		    int end = Math.min(begin + 10, page.getTotalPages());

		    model.addAttribute("deploymentLog", page);
		    model.addAttribute("beginIndex", begin);
		    model.addAttribute("endIndex", end);
		    model.addAttribute("currentIndex", current);
		
			model.addAttribute("products", page.getContent());
			return "products";
	}
	
	@RequestMapping(value = "modify" , method = RequestMethod.POST)
	public String modifyProduct(@ModelAttribute("product") @Valid Product product,BindingResult result, Model model) {
		if (!result.hasErrors()) {
			productService.save(product);
		} else {
			model.addAttribute("product", product);
			return "modifyProduct"; 
		}
		
		return "redirect:list";
	}
	
}
