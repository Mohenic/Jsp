<%@page import="kr.co.jboard1.vo.ArticleVO"%>
<%@page import="java.util.List"%>
<%@page import="kr.co.jboard1.dao.ArticleDAO"%>
<%@page import="kr.co.jboard1.vo.UserVO"%>
<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<%
	request.setCharacterEncoding("UTF-8");
	String pg = request.getParameter("pg");

	
	
	// 페이지 관련 변수
	int currentPage = 1;
	int total = 0;
	int lastPageNum = 0;
	
	if(pg != null){
		currentPage = Integer.parseInt(pg);
	}
	
	int start = (currentPage - 1) * 10;

	
	ArticleDAO dao = new ArticleDAO();
	
	// 전체 게시물 갯수 조회
	total = dao.selectCountTotal();
	
	// 페이지 번호 계산
	if(total % 10 == 0){
		lastPageNum = (total / 10);
	}else{
		lastPageNum = (total / 10) + 1;
	}
	
	
	// 현재 페이지 게시물 조회
	List<ArticleVO> articles = dao.selectArticles(start);
%>
<main>
    <section class="list">
        <h3>글목록</h3>
        <article>
            <table border="0">
                <tr>
                    <th>번호</th>
                    <th>제목</th>
                    <th>글쓴이</th>
                    <th>날짜</th>
                    <th>조회</th>
                </tr>
                <% for(ArticleVO article : articles){ %>
                <tr>
                    <td><%= article.getNo() %></td>
                    <td><a href="#"><%= article.getTitle() %></a>&nbsp;[<%= article.getComment() %>]</td>
                    <td><%= article.getNick() %></td>
                    <td><%= article.getRdate() %></td>
                    <td><%= article.getHit() %></td>
                </tr>
                <% } %>
            </table>
        </article>

        <!-- 페이지 네비게이션 -->
        <div class="paging">
            <a href="#" class="prev">이전</a>
            <% for(int i=1 ; i<=lastPageNum ; i++){ %>
            <a href="/Jboard1/list.jsp?pg=<%= i %>" class="num <%= (currentPage == i)?"current":"" %>"><%= i %></a>
            <% } %>
            <a href="#" class="next">다음</a>
        </div>

        <!-- 글쓰기 버튼 -->
        <a href="/Jboard1/write.jsp" class="btnWrite">글쓰기</a>
    </section>
</main>
<%@ include file="./_footer.jsp" %>