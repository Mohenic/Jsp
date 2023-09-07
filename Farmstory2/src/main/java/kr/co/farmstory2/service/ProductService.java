package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.ProductDAO;
import kr.co.farmstory2.dto.ProductDTO;

public enum ProductService {
	
	instance;
	
	private ProductDAO dao = new ProductDAO();
	
	public void insertProduct(ProductDTO dto) {
		dao.insertProduct(dto);
	}
	
	public ProductDTO selectProduct(String pNo) {
		return dao.selectProduct(pNo);
	}
	
	public List<ProductDTO> selectProducts(String type, int start){
		return dao.selectProducts(type, start);
	}
	
	public int selectCountProductTotal(String type) {
		return dao.selectCountProductsTotal(type);
	}
}
