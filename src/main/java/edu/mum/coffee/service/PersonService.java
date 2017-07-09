package edu.mum.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.mum.coffee.domain.Person;
import edu.mum.coffee.repository.PersonRepository;

@Service
@Transactional
public class PersonService {

	@Autowired
	private PersonRepository personRepository;

	public Person savePerson(Person person) {
		return personRepository.save(person);
	}
	
	public List<Person> findByEmail(String email) {
		return personRepository.findByEmail(email);
	}

	public Person findById(Long id) {
		return personRepository.findOne(id);
	}

	public void removePerson(Person person) {
		personRepository.delete(person);
	}
	
	public List<Person> getAllPerson() {
		return personRepository.findAll();
	}

	public Person SaveOrUpdatePersonAPI(Person person) {
		return savePerson(person);
	}
	
	public Page<Person> findPersonPagination(Integer pageNumber) {
        PageRequest request =
            new PageRequest(pageNumber - 1, 7, Sort.Direction.ASC, "firstName");
        return personRepository.findAll(request);
    }

}
