package edu.mum.coffee.validator;

import java.util.regex.Matcher;
import java.util.regex.Pattern;

import org.springframework.validation.Errors;
import org.springframework.validation.ValidationUtils;
import org.springframework.validation.Validator;

import edu.mum.coffee.domain.User;

public class UserUpdateValidator implements Validator {

	private static final String EMAIL_PATTERN =
			"^[_A-Za-z0-9-\\+]+(\\.[_A-Za-z0-9-]+)*@"
			+ "[A-Za-z0-9-]+(\\.[A-Za-z0-9]+)*(\\.[A-Za-z]{2,})$";
	
	@Override
	public boolean supports(Class<?> paramClass) {
		return User.class.equals(paramClass);
	}
	
	@Override
	public void validate(Object obj, Errors errors) {
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "firstName", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "lastName", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "email", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "phone", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address.city", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address.state", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address.country", "required");
		ValidationUtils.rejectIfEmptyOrWhitespace(errors, "address.zipcode", "required");
		
		User user = (User) obj;
		if (user.getFirstName().length() > 255) {
			errors.reject("firstName", "firstName.tooLong");
		}
		
		if (user.getLastName().length() > 255) {
			errors.reject("lastName", "lastName.tooLong");
		}
		
		if (user.getEmail().length() > 50) {
			errors.reject("userName", "userName.tooLong");
		}
		
		if (user.getPhone().length() > 50) {
			errors.reject("phone", "phone.tooLong");
		}
		
		if (user.getAddress() != null && user.getAddress().getCity().length() > 50) {
			errors.reject("city", "city.tooLong");
		}
		
		if (user.getAddress() != null && user.getAddress().getState().length() > 50) {
			errors.reject("state", "state.tooLong");
		}
		
		if (user.getAddress() != null && user.getAddress().getCountry().length() > 50) {
			errors.reject("country", "country.tooLong");
		}
		
		if (user.getAddress() != null && user.getAddress().getZipcode().length() > 50) {
			errors.reject("zipcode", "zipcode.tooLong");
		}
		
		Pattern pattern = Pattern.compile(EMAIL_PATTERN);
		Matcher matcher = pattern.matcher(user.getEmail());
		if (!matcher.matches()) {
			errors.rejectValue("email", "invalidEmail", new Object[]{"'email'"}, "Must be abc@xyz.abd");
		}
		
	}
}
