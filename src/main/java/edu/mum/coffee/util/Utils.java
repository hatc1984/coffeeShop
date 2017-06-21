package edu.mum.coffee.util;

import javax.servlet.http.HttpServletRequest;

import edu.mum.coffee.domain.CartInfo;
 
public class Utils {
  
   // Infomation of all product bought, stored in Session.
   public static CartInfo getCartInSession(HttpServletRequest request) {
 
  
       // Information Cart maybe saved in Session.
       CartInfo cartInfo = (CartInfo) request.getSession().getAttribute("myCart");
      
  
       // If not, create Cart
       if (cartInfo == null) {
           cartInfo = new CartInfo();
          
  
           // save to this session.
           request.getSession().setAttribute("myCart", cartInfo);
       }
 
       return cartInfo;
   }
 
   public static void removeCartInSession(HttpServletRequest request) {
       request.getSession().removeAttribute("myCart");
   }
 
   public static void storeLastOrderedCartInSession(HttpServletRequest request, CartInfo cartInfo) {
       request.getSession().setAttribute("lastOrderedCart", cartInfo);
   }
  
   public static CartInfo getLastOrderedCartInSession(HttpServletRequest request) {
       return (CartInfo) request.getSession().getAttribute("lastOrderedCart");
   }
 
}