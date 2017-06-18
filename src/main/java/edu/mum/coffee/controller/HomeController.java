package edu.mum.coffee.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.annotation.GetMapping;
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
	
	@GetMapping({"/secure"})
	public String securePage() {
		return "secure";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.GET)
	public String signUp(Model model) {
		model.addAttribute("users", new User());
		return "signUp";
	}
	
	@RequestMapping(value = "/signup", method = RequestMethod.POST)
	public String register(@ModelAttribute("users")@Validated User users, BindingResult result, Model model) {
		if (!result.hasErrors()) {
			userService.save(users);
			return "redirect:/home";
		} else {
			model.addAttribute("users", users);
			return "signUp";
		}
	}
}
