package edu.mum.coffee.config;

public class AuthoritiesConfiguration {
	
	public static final String[] ANONYMOUS = new String[] {
												"/", 
												"/home", 
												"/index", 
												"/resources/css/*",
												"/resources/image/*",
												"/resources/js/*", 
												"/signup*"
											};
	public static final String[] ADMIN_AUTHORITIES = new String[] {
												"/product/action**",
												"/product/add",
												"/product/list",
												"/product/modify", 
									    		"/person/list",
									    		"/person/add"
											};
	public static final String[] USER_AUTHORITIES = new String[] {
											
											};
}
