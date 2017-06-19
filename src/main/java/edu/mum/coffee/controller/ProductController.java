package edu.mum.coffee.controller;

import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.Date;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
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
	
	@InitBinder
	public void initialiseBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		CustomDateEditor orderDateEditor = new CustomDateEditor(dateFormat, true);
		binder.registerCustomEditor(Date.class, orderDateEditor);
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String action(@RequestParam("action") String action, @RequestParam("productId") String productId,
			Model model) {
		if ("delete".equals(action)) {
			int id = Integer.parseInt(productId);
			productService.deleteById(id);
			return "redirect:product/list";
		} else if ("update".equals(action)) {
			Product product = productService.getProduct(Integer.parseInt(productId));
			model.addAttribute("product", product);
			return "modifyProduct";
		}
		Product product = new Product();
		model.addAttribute("product", product);
		return "modifyProduct";
	}

	@RequestMapping(method = RequestMethod.GET, value = "add")
	public String addProductPage(Model model) {
		Product product = new Product();
		model.addAttribute("product", product);
		return "modifyProduct";
	}

	@RequestMapping(method = RequestMethod.GET, value = "list")
	public String listAllProduct(@RequestParam(value = "index", required = false) String pageNumber, Model model,
			Principal principal) {

		Page<Product> page = productService
				.findProductPagination(pageNumber == null ? 1 : Integer.parseInt(pageNumber));

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

	@RequestMapping(value = "modify", method = RequestMethod.POST)
	public String modifyProduct(@ModelAttribute("product") @Valid Product product, BindingResult result, Model model) {
		if (!result.hasErrors()) {
			productService.save(product);
		} else {
			model.addAttribute("product", product);
			return "modifyProduct";
		}

		return "redirect:list";
	}

}
