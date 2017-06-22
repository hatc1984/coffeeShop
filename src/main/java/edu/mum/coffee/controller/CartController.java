package edu.mum.coffee.controller;


import java.security.Principal;

import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Propagation;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import edu.mum.coffee.domain.CartInfo;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductInfo;
import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.OrderService;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.service.UserService;
import edu.mum.coffee.util.Utils;

@Controller
public class CartController {

	@Autowired
	private ProductService productService;
	
	@Autowired
	private UserService userService;
	
	@Autowired
	OrderService orderService;
	
   @RequestMapping({ "/buyProduct" })
   public String listProductHandler(HttpServletRequest request, Model model, 
		   @RequestParam(value = "code") int code,Principal princial) {
 
       Product product = null;
       if (code>0) {
           product = productService.getProduct(code);
       }
       if (product != null) {
           CartInfo cartInfo = Utils.getCartInSession(request);
 
           ProductInfo productInfo = new ProductInfo(product);
 
           cartInfo.addProduct(productInfo, 1);
           
           User user = userService.findUserByEmail(princial.getName());
           cartInfo.setCustomerInfo(user);
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
   
   @RequestMapping({ "/shoppingCartRemoveProduct" })
   public String removeProductHandler(HttpServletRequest request, Model model, //
           @RequestParam(value = "code") int code) {
       Product product = null;
       if (code > 0) {
           product = productService.getProduct(code);
       }
       if (product != null) {

           CartInfo cartInfo = Utils.getCartInSession(request);
 
           ProductInfo productInfo = new ProductInfo(product);
 
           cartInfo.removeProduct(productInfo);
 
       }
  
       return "redirect:/shoppingCart";
   }
 
   // GET: Display cart.
   @RequestMapping(value = { "/shoppingCart" }, method = RequestMethod.GET)
   public String shoppingCartHandler(HttpServletRequest request, Model model) {
       CartInfo myCart = Utils.getCartInSession(request);
       
       model.addAttribute("cartForm", myCart);
       return "shoppingCart";
   }
   
   
   @RequestMapping(value = { "/checkout" }, method = RequestMethod.GET)
   public String shoppingCartCustomerForm(HttpServletRequest request, Model model) {
       CartInfo cartInfo = Utils.getCartInSession(request);
       if (cartInfo.isEmpty()) {

           return "redirect:/shoppingCart";
       }
 
       User customerInfo = cartInfo.getCustomerInfo();
       if (customerInfo == null) {
           customerInfo = new User();
       }
       model.addAttribute("checkoutForm", customerInfo);
       
       CartInfo myCart = Utils.getCartInSession(request);
       model.addAttribute("cartForm", myCart);
 
       return "checkout";
   }
 
  
   // POST: Save thông tin khách hàng.
   @RequestMapping(value = { "/checkout" }, method = RequestMethod.POST)
   public String shoppingCartCustomerSave(HttpServletRequest request, //
           Model model, //
           BindingResult result, //
           final RedirectAttributes redirectAttributes) {
 
       return "redirect:/shoppingCartConfirmation";
   }
 

   @RequestMapping(value = { "/shoppingCartConfirmation" }, method = RequestMethod.GET)
   public String shoppingCartConfirmationReview(HttpServletRequest request, Model model) {
       CartInfo cartInfo = Utils.getCartInSession(request);
 
    
       if (cartInfo.isEmpty()) {
         
           return "redirect:/shoppingCart";
       } else if (!cartInfo.isValidCustomer()) {
          
           return "redirect:/shoppingCartCustomer";
       }
 
       return "shoppingCartConfirmation";
   }
 
   @RequestMapping(value = { "/shoppingCartConfirmation" }, method = RequestMethod.POST)
   @Transactional(propagation = Propagation.NEVER)
   public String shoppingCartConfirmationSave(@ModelAttribute("checkoutForm") User ship_customer, HttpServletRequest request, Model model) {
       CartInfo cartInfo = Utils.getCartInSession(request);

       if (cartInfo.isEmpty()) {  
           return "redirect:/shoppingCart";
       } else if (!cartInfo.isValidCustomer()) {
        
           return "redirect:/checkout";
       }
       try {
           //orderDAO.saveOrder(cartInfo);   // TODO: Save order to database
    	   orderService.save(ship_customer, cartInfo);
    	   
       } catch (Exception e) {
        
           return "shoppingCartConfirmation";
       }
      
       // Delete cart from Session
       Utils.removeCartInSession(request);
        
   
       // Save order
       Utils.storeLastOrderedCartInSession(request, cartInfo);
 
    
       // Finish.
       return "redirect:/shoppingCartFinalize";
   }
   
	@RequestMapping(value = "modify" , method = RequestMethod.POST)
	public String modifyUser(@ModelAttribute("user") @Validated User user,BindingResult result, Model model, HttpServletRequest request) throws Throwable {
		if (!result.hasErrors()) {
			userService.update(user);
		} else {
			model.addAttribute("user", user);
			return "modifyUser"; 
		}
		
		Authentication auth = SecurityContextHolder.getContext().getAuthentication();
		String r= auth.getAuthorities().toString();
		if ("[ROLE_USER]".equals(r)) {
			return "redirect:/home";
		} else {
			return "redirect:list";
		}
	}
    
 
   @RequestMapping(value = { "/shoppingCartFinalize" }, method = RequestMethod.GET)
   public String shoppingCartFinalize(HttpServletRequest request, Model model) {
 
       CartInfo lastOrderedCart = Utils.getLastOrderedCartInSession(request);
 
       if (lastOrderedCart == null) {
           return "redirect:/shoppingCart";
       }
 
       return "shoppingCartFinalize";
   }
   
   
   
   
   
   
   
   
	
}
