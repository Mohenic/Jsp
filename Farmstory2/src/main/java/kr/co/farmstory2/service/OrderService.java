package kr.co.farmstory2.service;

import java.util.List;

import kr.co.farmstory2.dao.OrderDAO;
import kr.co.farmstory2.dto.OrderDTO;

public enum OrderService {

	instance;
	
	OrderDAO dao = new OrderDAO();
	
	public void insertOrder(OrderDTO dto) {
		dao.insertOrder(dto);
	}
	
	public List<OrderDTO> selectOrders(int start){
		return dao.selectOrders(start);
	}
	
	public OrderDTO selectOrder(String orderNo) {
		return dao.selectOrder(orderNo);
	}
	
	public int selectCountOrders() {
		return dao.selectCountOrders();
	}
}
