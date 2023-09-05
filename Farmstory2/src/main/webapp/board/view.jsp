<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ include file="../_header.jsp" %>
<jsp:include page="./_aside${group}.jsp"/>
<script>
	
	$(function(){
		
		// 댓글 삭제
		
		$(document).on('click','.del', function(e){
			e.preventDefault();
			
			const no = $(this).data('no');
			const article = $(this).parent().parent();
			
			console.log('no : ' + no)
			
			const jsonData = {
				"kind" : "DEL",
				"no" : no
			}
			
			$.ajax({
				url: '/Farmstory2/comment.do',
				type: 'GET',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					
					if(data.result > 0){
						alert('댓글이 삭제 되었습니다.');
						
						article.del();
					}
				}
			});
		});
		
		// 댓글 입력
		
		$('#btnWrite').click(function(e){
			e.preventDefault();
			
			const parent = $('#formComment > input[name=parent]').val();
			const content = $('#formComment > textarea[name=content]').val();
			const writer = $('#formComment > input[name=writer]').val();
			
			const jsonData = {
					"parent": parent,
					"content": content,
					"writer": writer
			};
			
			console.log('jsonData : ' + jsonData);
			
			$.ajax({
				url: '/Farmstory2/comment.do',
				type: 'post',
				data: jsonData,
				dataType: 'json',
				success: function(data){
					console.log(data);
					
					if(data.result > 0){
						alert('댓글이 등록 되었습니다.');
						
						const dt = new Date();
						const year = dt.getFullYear().toString().substr(2, 4);
						const month = dt.getMonth()+1;
						const date = dt.getDate();
						const now = yesr + "-" + month + "-" + date;
						
						const article = `<article>
											<span class='nick'>${sessUser.nick}</span>
											<span class='date'>`+now+`</span>
											<p class='content'>`+content+`</p>
											<div>
												<a href='#' class='del'>삭제</a>
												<a href='#' class='mod'>수정</a>
											</div>						
					 					 </article>`;
					 	
					 	$('.commentList').append(article);
					 					 
					}else{
						alert('댓글 등록이 실패했습니다.')
					}
				}
			});
		});
	});
</script>
			<section class="view">
			    <h3>글보기</h3>
			    <table>
			        <tr>
			            <td>제목</td>
			            <td><input type="text" name="title" value="${article.title}" readonly/></td>
			        </tr>
			        <c:if test="${article.file > 0}">
				        <tr>
				            <td>첨부파일</td>
				            <td>
				                <a href="/Farmstory2/board/fileDownload.do?fno=${article.fileDto.fno}">${article.fileDto.ofile}</a>&nbsp;
				                <span>${article.fileDto.download}</span>회 다운로드
				            </td>
				        </tr>
			        </c:if>
			        <tr>
			            <td>내용</td>
			            <td>
			                <textarea name="content" readonly>${article.content}</textarea>
			            </td>
			        </tr>
			    </table>
			    <div>
			        <a href="/Farmstory2/board/delete.do?group=${group}&cate=${cate}&no=${article.no}" class="btnDelete">삭제</a>
			        <a href="/Farmstory2/board/modify.do?group=${group}&cate=${cate}" class="btnModify">수정</a>
			        <a href="/Farmstory2/board/list.do?group=${group}&cate=${cate}" class="btnList">목록</a>
			    </div>
			    
			    <!-- 댓글리스트 -->
			    <section class="commentList">
			        <h3>댓글목록</h3>
			        <c:forEach var="comment" items="${comments}">
			        <article class="comment">
							<span>
								<span class="nick">${comment.nick}</span>
								<span class="date">${comment.rdate}</span>
							</span>
							<textarea class="content" name="comment" readonly>${comment.content}</textarea>
							<div>
								<a href="#" class="del" data-no="${comment.no}">삭제</a>
								<a href="#" class="can">취소</a>
								<a href="#" class="mod">수정</a>
							</div>                
			        </article>
			        	</c:forEach>
			        	<c:if test="${comments.size() == 0}">
			        <p class="empty">등록된 댓글이 없습니다.</p>
			        	</c:if>
			    </section>
			
			    <!-- 댓글입력폼 -->
			    <section class="commentForm">
			        <h3>댓글쓰기</h3>
			        <form id="formComment" action="#" method="post">
			        	<input type="hidden" name="parent" value="${no}"/>
			        	<input type="hidden" name="writer" value="${sessUser.uid}"/>
			            <textarea name="content"></textarea>
			            <div>
			                <a href="#" class="btnCancel">취소</a>
			                <input type="submit" class="btnWrite" value="작성완료"/>
			            </div>
			        </form>
			    </section>
			</section>
			<!-- 내용 끝 -->
        </article>
    </section>
</div>			
<%@ include file="../_footer.jsp" %>