package edu.mum.coffee.controller;

import java.security.Principal;

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

import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.UserService;

@Controller
public class HomeController {
	
	@Autowired
	private UserService userService;
	
	@GetMapping({"/", "/index", "/home"})
	public String homePage() {
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
	
	@RequestMapping(value = "/403", method = RequestMethod.GET)
	public String accesssDenied(Principal user) {
		return "403";
	}
	
	@RequestMapping(value = "*")
	public String notFoundError(HttpServletRequest request) {
		return "404";
	}

    @RequestMapping("/login") 
    public String getLogin() {
        return "login";
    }
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String register(@ModelAttribute("user") @Validated User user, BindingResult result, Model model) {
		if (!result.hasErrors()) {
			userService.save(user);
			return "redirect:/home";
		} else {
			model.addAttribute("user", user);
			return "signUp";
		}
	}
}
