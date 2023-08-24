package kr.farmstory1.dao;

import java.util.ArrayList;
import java.util.List;

import kr.farmstory1.db.DBHelper;
import kr.farmstory1.db.SQL;
import kr.farmstory1.dto.OrderDTO;

public class OrderDAO extends DBHelper {
	
	// 기본 CRUD
	public void insertOrder(OrderDTO dto) {
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.INSERT_ORDER);
			psmt.setInt(1, dto.getOrderProduct());
			psmt.setInt(2, dto.getOrderCount());
			psmt.setInt(3, dto.getOrderDelivery());
			psmt.setInt(4, dto.getOrderPrice());
			psmt.setInt(5, dto.getOrderTotal());
			psmt.setString(6, dto.getReceiver());
			psmt.setString(7, dto.getHp());
			psmt.setString(8, dto.getZip());
			psmt.setString(9, dto.getAddr1());
			psmt.setString(10, dto.getAddr2());
			psmt.setString(11, dto.getOrderEtc());
			psmt.setString(12, dto.getOrderUser());
			psmt.executeUpdate();
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public OrderDTO selectOrder(int orderNo) {
		return null;
	}
	
	public List<OrderDTO> selectOrders() {
		
		List<OrderDTO> orders = new ArrayList<OrderDTO>();
		
		try {
			conn = getConnection();
			psmt = conn.prepareStatement(SQL.SELECT_ORDERS);
			rs = psmt.executeQuery();
			
			while(rs.next()) {
				OrderDTO order = new OrderDTO();
				order.setOrderNo(rs.getInt(1));
				order.setOrderProduct(rs.getInt(2));
				order.setOrderCount(rs.getInt(3));
				order.setOrderDelivery(rs.getInt(4));
				order.setOrderPrice(rs.getInt(5));
				order.setOrderTotal(rs.getInt(6));
				order.setReceiver(rs.getString(7));
				order.setHp(rs.getString(8));
				order.setZip(rs.getString(9));
				order.setAddr1(rs.getString(10));
				order.setAddr2(rs.getString(11));
				order.setOrderEtc(rs.getString(12));
				order.setOrderUser(rs.getString(13));
				order.setOrderDate(rs.getString(14));
				orders.add(order);
			}
			close();
		}catch (Exception e) {
			e.printStackTrace();
		}
		
		return orders;
	}
	
	public void updateOrder(OrderDTO dto) {
		
	}
	
	public void deleteOrder(int orderNo) {
		
	}
}
