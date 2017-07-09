package edu.mum.coffee.util;

import edu.mum.coffee.domain.Product;

public class ProductUtil {

	public static boolean isNewProduct(Product product) {
		return product.getId() == 0;
	}

}
