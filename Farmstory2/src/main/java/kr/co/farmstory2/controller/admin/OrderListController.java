package kr.co.farmstory2.controller.admin;

import java.io.IOException;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import kr.co.farmstory2.dto.OrderDTO;
import kr.co.farmstory2.dto.ProductDTO;
import kr.co.farmstory2.dto.UserDTO;
import kr.co.farmstory2.service.OrderService;

@WebServlet("/admin/orderList.do")
public class OrderListController extends HttpServlet {
	private static final long serialVersionUID = -5110777892702223684L;
	
	private Logger logger = LoggerFactory.getLogger(this.getClass());
	private OrderService oService = OrderService.instance;

	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

			//데이터수신
			String pg = req.getParameter("pg");
			
			//페이지 관련 변수
			int start=0;
			int currentPage =1;
			int total=0;
			int lastPageNum=0;
			int pageGroupCurrent=1;
			int pageGroupStart=1;
			int pageGroupEnd=0;
			int pageStartNum=0;
			
			
			// 현재페이지계산
			if(pg!=null){
				currentPage =Integer.parseInt(pg);
				
			}
			
			// 전체 상품 갯수
			total = oService.selectCountOrders();
			
			//LIMIT 시작값계산
			start =(currentPage -1)*10;

			if(total%10 == 0){
				lastPageNum =(total/10);
			}else{
				lastPageNum =(total/10)+1;
			}
			
			//페이지 그룹계산
			pageGroupCurrent=(int) Math.ceil(currentPage/10.0);
			pageGroupStart=(pageGroupCurrent-1)*10+1;
			pageGroupEnd=pageGroupCurrent*10;
			
			if(pageGroupEnd > lastPageNum){
				pageGroupEnd=lastPageNum;
			}
			
			//페이지 시작번호 계산
			pageStartNum = total-start;
			

			List<OrderDTO> orders = oService.selectOrders(start);
			
			req.setAttribute("start", start);
			req.setAttribute("orders", orders);
			req.setAttribute("currentPage", currentPage);
			req.setAttribute("total", total);
			req.setAttribute("lastPageNum", lastPageNum);
			req.setAttribute("pageGroupCurrent", pageGroupCurrent);
			req.setAttribute("pageGroupStart", pageGroupStart);
			req.setAttribute("pageGroupEnd", pageGroupEnd);
		
		
		RequestDispatcher dispatcher = req.getRequestDispatcher("/admin/orderList.jsp");
		dispatcher.forward(req, resp);
		
	}
}
