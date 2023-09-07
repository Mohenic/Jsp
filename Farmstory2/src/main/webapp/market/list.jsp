<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="../_header.jsp" %>
<div id="sub">
    <div><img src="/Farmstory2/images/sub_top_tit2.png" alt="MARKET"></div>
    <section class="market">
        <aside>
            <img src="/Farmstory2/images/sub_aside_cate2_tit.png" alt="장보기"/>

            <ul class="lnb">
                <li class="on"><a href="/Farmstory2/market/list.do">장보기</a></li>
            </ul>
        </aside>
        <article class="list">
            <nav>
                <img src="/Farmstory2/images/sub_nav_tit_cate2_tit1.png" alt="장보기"/>
                <p>
                    HOME > 장보기 > <em>장보기</em>
                </p>
            </nav>

                    <!-- 내용 시작 -->
                    <p class="sort">
                        <a href="/Farmstory2/market/list.do?type=0">전체 |</a>
                        <a href="/Farmstory2/market/list.do?type=1">과일 |</a>
                        <a href="/Farmstory2/market/list.do?type=2">야채 |</a>
                        <a href="/Farmstory2/market/list.do?type=3">곡류</a>
                    </p>
                    <table border="0">
                    <c:forEach var="product" items="${requestScope.products}">
                        <tr>
                            <td>
                                <a href="./view.do?pNo=${product.pNo}"><img src="/Farmstory2/thumb/${product.thumb1}" class="thumb" alt="${product.pName}"></a>
                            </td>
		                    <c:if test="${product.type eq 1}">
		                    	<td>과일</td>
		                    </c:if>
		                    <c:if test="${product.type eq 2}">
		                    	<td>야채</td>
		                    </c:if>
		                    <c:if test="${product.type eq 3}">
		                    	<td>곡물</td>
		                    </c:if>
                            <td><a href="./view.do">${product.pName}</a></td>
                            <td><strong>${product.price}</strong>원</td>
                        </tr>
                    </c:forEach>
                    </table>

	                <p class="paging">
		       			<c:if test="${pageGroupStart > 1 }">
		                   <a href="/Farmstory2/market/list.do?type=${type}&pg=1" class="prev">처음으로</a>
		                   <a href="/Farmstory2/market/list.do?type=${type}&pg=${pageGroupStart -1}" class="prev">이전</a>
						</c:if>
		              
						<c:forEach var="i" begin="${pageGroupStart}" end="${pageGroupEnd}" >               
		                   <a href="/Farmstory2/market/list.do?type=${type}&pg=${i}" class="num ${currentPage==i ? 'current':''}">[${i}]</a>
		                </c:forEach>
						
						<c:if test="${pageGroupEnd < lastPageNum }">
		                   <a href="/Farmstory2/market/list.do?type=${type}&pg=${pageGroupEnd +1 }" class="next">다음</a>
		                   <a href="/Farmstory2/market/list.do?type=${type}&pg=${lastPageNum}" class="next">마지막으로</a>
		             	</c:if>
					</p>
                    <!-- 내용 끝 -->

                </article>
            </section>

        </div>
<%@ include file="../_footer.jsp" %>