package edu.mum.coffee.restful;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import edu.mum.coffee.domain.Person;
import edu.mum.coffee.service.PersonService;

@RestController
@RequestMapping("/rest/personRestFul")
public class PersonRestController {
	
	@Autowired
	private PersonService personService;
	
	@GetMapping(value="/list")
	public List<Person> listAllPerson(Model model) {
		return personService.getAllPerson();
	}
	
	@GetMapping(value="/show")
	public Person changeInformationPerson(@RequestParam("username") String username) {
		List<Person> persons = personService.findByEmail(username);
		Person person = persons != null && persons.size() > 0 ?
				persons.get(0) : null;
		return person;
	}
	
	@PostMapping(value="/update")
	public Person updatePerson(@Valid @RequestBody Person person) {
		return personService.SaveOrUpdatePersonAPI(person);
	}
	
	@PostMapping(value="/save")
	public Person savePerson(@Valid @RequestBody Person person) {
		return personService.SaveOrUpdatePersonAPI(person);
	}
}
