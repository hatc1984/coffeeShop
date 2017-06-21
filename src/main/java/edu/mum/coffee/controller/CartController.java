package edu.mum.coffee.controller;


import javax.servlet.http.HttpServletRequest;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.CartInfo;
import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductInfo;
import edu.mum.coffee.service.ProductService;
import edu.mum.coffee.util.Utils;

@Controller
public class CartController {

	@Autowired
	private ProductService productService;
	
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
	
}
