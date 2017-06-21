package edu.mum.coffee.controller;

import java.io.File;
import java.security.Principal;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
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
import org.springframework.web.multipart.MultipartFile;

import edu.mum.coffee.domain.Image;
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
	public String modifyProduct(@ModelAttribute("product") @Valid Product product, BindingResult result, Model model, 
			HttpServletRequest request) {
		
		if (product.getId() == 0) {
			boolean noImageUpload = false;
			if ("".equals(product.getProductImage().get(0).getOriginalFilename())) {
				noImageUpload = true;
			}
			
			if (!result.hasErrors() && !noImageUpload) {
				List<Image> images = new ArrayList<>();
				for (MultipartFile file : product.getProductImage()) {
					String rootDirectory = request.getSession().getServletContext().getRealPath("/");
					if (file != null && !file.isEmpty()) {
						try {
							file.transferTo(new File(rootDirectory + "resources//image//" + file.getOriginalFilename()));
							Image image = new Image();
							image.setImageLink("../resources/image/" + file.getOriginalFilename());
							image.setImageName(file.getOriginalFilename());
							images.add(image);
						} catch (Exception e) {
							throw new RuntimeException("Product Image saving failed", e);
						}
					}
				}
				product.setImage(images);
				productService.save(product);
			} else {
				if (noImageUpload) {
					model.addAttribute("imageError", "product Image need to upload");
				}
				model.addAttribute("product", product);
				return "modifyProduct";
			}
		} else {
			if (!result.hasErrors()) {
				productService.save(product);
			} else {
				model.addAttribute("product", product);
				return "modifyProduct";
			}
		}

		return "redirect:list";
	}

}
