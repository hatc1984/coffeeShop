package edu.mum.coffee.controller;

import java.security.Principal;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.CartInfo;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductInfo;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.service.UserService;
import edu.mum.coffee.util.Utils;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	private ProductService productService;
	
	@GetMapping({"/", "/index", "/home"})
	public String homePage(Model model, HttpServletRequest request) {
		List<Product> products =  productService.getAllProduct();
		model.addAttribute("products", products);
		
		return "home";
	}
	
	@Autowired
	@Qualifier("userSignUpValidator")
	private org.springframework.validation.Validator validator;
	
	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}
	
	@GetMapping({"/secure"})
	public String securePage() {
		return "secure";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signUp(Model model) {
		model.addAttribute("user", new User());
		return "signUp";
	}
	
   @RequestMapping({ "/buyProduct" })
   public String listProductHandler(HttpServletRequest request, Model model, 
		   @RequestParam(value = "code") int code) {
 
       Product product = null;
       if (code>0) {
           product = productService.getProduct(code);
       }
       if (product != null) {
           CartInfo cartInfo = Utils.getCartInSession(request);
 
           ProductInfo productInfo = new ProductInfo(product);
 
           cartInfo.addProduct(productInfo, 1);
       }
    
       return "redirect:/shoppingCart";
   }
  
   // POST: Update number for product
   @RequestMapping(value = { "/shoppingCart" }, method = RequestMethod.POST)
   public String shoppingCartUpdateQty(HttpServletRequest request, //
           Model model, //
           @ModelAttribute("cartForm") CartInfo cartForm) {
 
       CartInfo cartInfo = Utils.getCartInSession(request);
       cartInfo.updateQuantity(cartForm);
 
     
       // go to page all bought product
       return "redirect:/shoppingCart";
   }
 
   // GET: Display cart.
   @RequestMapping(value = { "/shoppingCart" }, method = RequestMethod.GET)
   public String shoppingCartHandler(HttpServletRequest request, Model model) {
       CartInfo myCart = Utils.getCartInSession(request);
 
       model.addAttribute("cartForm", myCart);
       return "shoppingCart";
   }
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public String accesssDenied(Principal user) {
		return "403";
	}
	
	@RequestMapping(value = "*")
	public String notFoundError(HttpServletRequest request) {
		return "404";
	}

	@RequestMapping(value = "/login", method = RequestMethod.GET)
	public String login(@RequestParam(value = "error", required = false) String error,
			@RequestParam(value = "logout", required = false) String logout, Model model) {

		if (error != null) {
			model.addAttribute("error", "Invalid UserName And PassWord");
		}

		if (logout != null) {
			return "redirect:home";
		}
		return "login";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String register(@ModelAttribute("user") @Validated User user, BindingResult result, Model model) {
		if (!result.hasErrors()) {
			try {
				userService.save(user);
			} catch (Exception e) {
				model.addAttribute("error", e.getMessage());
				return "signUp";
			}
			return "redirect:/home";
		} else {
			model.addAttribute("user", user);
			return "signUp";
		}
	}
}
