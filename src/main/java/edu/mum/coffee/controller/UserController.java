package edu.mum.coffee.controller;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.data.domain.Page;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.validation.annotation.Validated;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;

import edu.mum.coffee.domain.User;
import edu.mum.coffee.service.UserService;

@Controller
@RequestMapping("/user")
public class UserController {
	
	@Autowired
	private UserService userService;
	
	@Autowired
	@Qualifier("userUpdateValidator")
	private org.springframework.validation.Validator validator;
	
	@InitBinder
	private void initBinder(WebDataBinder binder) {
		binder.setValidator(validator);
	}
	
	@RequestMapping(method = RequestMethod.GET)
	public String action(@RequestParam("action") String action, @RequestParam("userId") String userId,
			Model model) {
		if ("delete".equals(action)) {
			Long id = Long.parseLong(userId);
			userService.deleteById(id);
			return "redirect:user/list";
		} else if ("update".equals(action)) {
			User user = userService.getUser(Long.parseLong(userId));
			model.addAttribute("user", user);
			return "modifyUser";
		} 
		User user = new User();
		model.addAttribute("user", user);
		return "modifyUser";
	}
	
	@RequestMapping(method = RequestMethod.GET, value = "add")
	public String addUserPage(Model model) {
		User user = new User();
		model.addAttribute("user", user);
		return "modifyUser";
	}
	
	@RequestMapping(method = RequestMethod.GET, value="list")
	public String listAllUser(@RequestParam(value = "index",required = false) String pageNumber, Model model) {

			Page<User> page = userService.findUserPagination(pageNumber == null ? 1 : Integer.parseInt(pageNumber));

		    int current = page.getNumber() + 1;
		    int begin = Math.max(1, current - 5);
		    int end = Math.min(begin + 10, page.getTotalPages());

		    model.addAttribute("deploymentLog", page);
		    model.addAttribute("beginIndex", begin);
		    model.addAttribute("endIndex", end);
		    model.addAttribute("currentIndex", current);
		
			model.addAttribute("users", page.getContent());
			return "users";
	}

	@RequestMapping(value = "modify" , method = RequestMethod.POST)
	public String modifyUser(@ModelAttribute("user") @Validated User user,BindingResult result, Model model, HttpServletRequest request) throws Throwable {
		if (!result.hasErrors()) {
			userService.update(user);
		} else {
			model.addAttribute("user", user);
			return "modifyUser"; 
		}
		
		return "redirect:list";
	}
	
	
	@RequestMapping(value = "add", method = RequestMethod.POST)
	public String addUser(@ModelAttribute("user") @Valid User user, BindingResult result, Model model,
			HttpServletRequest request) throws Throwable {
		if (!result.hasErrors()) {
			userService.save(user);
		} else {
			model.addAttribute("user", user);
			return "modifyUser";
		}

		return "redirect:list";
	}
	
}
