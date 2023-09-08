<%@page import="kr.co.farmstory2.dao.OrderDAO"%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script>
    $(function(){

        $('.showPopup').click(function(e){
            e.preventDefault();
            
            const tr = $(this).parent().parent();
            const orderNo = tr.find('.orderNo').text();
            const thumb = tr.find('.thumb1').text();
            const receiver = tr.find('.receiver').text();
            const address  = tr.find('.address').text();
            const pName = tr.find('.pName').text();
            const price = tr.find('.price').text();
            const count = tr.find('.count').text();
            const delivery = tr.find('.delivery').text();
            const total = tr.find('.total').text();
            const orderer = tr.find('.orderer').text();
            const date = tr.find('.orderDate').text();
            
            const popup = $('#orderPopup');
            popup.find('.orderNo').text(orderNo);
            popup.find('.thumb > img').attr('src', '/Farmstory2/thumb/'+thumb);
            popup.find('.receiver').text(receiver);
            popup.find('.address').text(address);
            popup.find('.pName').text(pName);
            popup.find('.price').text(price);
            popup.find('.count').text(count);
            popup.find('.delivery').text(delivery);
            popup.find('.total').text(total);
            popup.find('.orderer').text(orderer);
            popup.find('.date').text(date);
            popup.show();
        	
        });

        $('#orderPopup .btnClose').click(function(){
            $('#orderPopup').hide();
        });

    });
</script>
<main>
<%@ include file="./_aside.jsp" %>
    <section id="orderList">
        <nav>
            <h3>주문목록</h3>
        </nav>
        <article>
        <form id="formCheck" action="/Farmstory2/admin/delete.do" method="get">
            <table border="0">
                <tr>
                    <th><input type="checkbox" name="all"/></th>
                    <th>주문번호</th>
                    <th>상품명</th>
                    <th>판매가격</th>
                    <th>수량</th>
                    <th>배송비</th>
                    <th>합계</th>
                    <th>주문자</th>
                    <th>주문일</th>
                    <th>확인</th>
                </tr>
                <c:forEach var="orders" items="${orders}">
                <tr>
                    <td><input type="checkbox" name=""/></td>
                    <td class="orderNo">${orders.orderNo}</td>
                    <td class="pName">${orders.pName}</td>                            
                    <td class="price">${orders.orderPrice}원</td>
                    <td class="count">${orders.orderCount}</td>
                    <td class="delivery">${orders.orderDelivery}원</td>
                    <td class="total">${orders.orderTotal}원</td>
                    <td class="orderer">${orders.orderUser}</td>
                    <td class="date">${orders.orderDate}</td>
                    <td><a href="#" class="showPopup">[상세확인]</a></td>
                    <td class="hidden thumb1">${orders.thumb1}</td>
                    <td class="hidden receiver">${orders.receiver}</td>
                    <td class="hidden address">${orders.addr1} ${orders.addr2}</td>
                </tr>
                </c:forEach>
            </table>
            </form>

            <p>
                <a href="#" class="orderDelete">선택삭제</a>                        
            </p>
            
			<p class="paging">
       			<c:if test="${pageGroupStart > 1 }">
                   <a href="/Farmstory2/admin/orderList.do?pg=1" class="prev">처음으로</a>
                   <a href="/Farmstory2/admin/orderList.do?pg=${pageGroupStart -1}" class="prev">이전</a>
				</c:if>
              
				<c:forEach var="i" begin="${pageGroupStart}" end="${pageGroupEnd}" >               
                   <a href="/Farmstory2/admin/orderList.do?pg=${i}" class="num ${currentPage==i ? 'current':''}">${i}</a>
                </c:forEach>
				
				<c:if test="${pageGroupEnd < lastPageNum }">
                   <a href="/Farmstory2/admin/orderList.do?pg=${pageGroupEnd +1 }" class="next">다음</a>
                   <a href="/Farmstory2/admin/orderList.do?pg=${lastPageNum}" class="next">마지막으로</a>
             	</c:if>
            </p>
        </article>
    </section>
</main>
<div id="orderPopup">
    <section>
        <nav>
            <h1>상세주문내역</h1>
            <button class="btnClose">닫기</button>
        </nav>

        <article>
            <h3>기본정보</h3>
            <table border="0">
                <tr>
                    <td rowspan="7" class="thumb"><img src="./images//sample_item1.jpg" alt="사과 500g"></td>
                    <td>상품번호</td>
                    <td class="orderNo">1011</td>
                </tr>
                <tr>
                    <td>상품명</td>
                    <td class="pName">사과 500g</td>
                </tr>
                <tr>
                    <td>판매가격</td>
                    <td class="price">4,000원</td>
                </tr>
                <tr>
                    <td>수량</td>
                    <td class="count">2개</td>
                </tr>
                <tr>
                    <td>배송비</td>
                    <td class="delivery">3,000원</td>
                </tr>
                <tr>
                    <td>합계</td>
                    <td class="total">11,000원</td>
                </tr>
                <tr>
                    <td>주문자</td>
                    <td class="orderer">홍길동</td>
                </tr>
            </table>

            <h3>배송지 정보</h3>
            <table border="0">
                <tr>
                    <td>받는분</td>
                    <td class="receiver">홍길동</td>
                </tr>
                <tr>
                    <td>배송지</td>
                    <td class="address">부산광역시 부산진구 대연동 120 루미너스 10층</td>
                </tr>
            </table>
        </article>
    </section>
</div>
<%@ include file="./_footer.jsp" %>