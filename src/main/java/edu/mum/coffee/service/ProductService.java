package edu.mum.coffee.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.domain.Page;
import org.springframework.data.domain.PageRequest;
import org.springframework.data.domain.Pageable;
import org.springframework.data.domain.Sort;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import edu.mum.coffee.domain.Product;
import edu.mum.coffee.domain.ProductType;
import edu.mum.coffee.repository.ProductRepository;

@Service
@Transactional
public class ProductService   {
	
	private static final int PAGE_SIZE = 7;
	
	@Autowired
	private ProductRepository productRepository;
		
	public Product save(Product product) {
		return productRepository.save(product);
	}
	
	public void deleteById(int productId) {
		Product product = getProduct(productId);
		delete(product);
	}

	public void delete(Product product) {
		productRepository.delete(product);
	}

	public Product getProduct(int productId) {
		return  productRepository.findOne(productId);
	}

	public List<Product> getAllProduct() {
		return  productRepository.findAll() ;
	}
	
	public List<Product> findByPrice(double minPrice, double maxPrice) {
		return  productRepository.findByPriceBetween(minPrice, maxPrice);
	}
	
	public List<Product> findByProductType(ProductType productType) {
		 return productRepository.findByProductType(productType);
	}
	
	public Page<Product> findProductPagination(Integer pageNumber) {
        PageRequest request =
            new PageRequest(pageNumber - 1, PAGE_SIZE, Sort.Direction.DESC, "price");
        return productRepository.findAll(request);
    }
	
	public Page<Product> findProductPaginationWithType(Integer pageNumber, ProductType productType) {
		Pageable request =
            new PageRequest(pageNumber - 1, PAGE_SIZE, Sort.Direction.DESC, "price");
        return productRepository.findByProductType(request, productType);
    }
	
	public List<Product> findByTextSearch(String criteria) {
		if (!criteria.contains("%")) {
			criteria = "%"+criteria+"%";
		}
		return productRepository.findByProductNameLikeOrDescriptionLikeAllIgnoreCase(criteria, criteria);
	}
	
}
