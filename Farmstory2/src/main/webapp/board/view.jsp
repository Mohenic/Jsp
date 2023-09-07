<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"  %>
<%@ include file="../_header.jsp" %>
<script>

	window.onload = function(){
		
		const commentURL = "/Farmstory2/board/comment.do"
		const formComment = document.getElementById('formComment');
		const commentList = document.getElementsByClassName('commentList')[0];
		
		// 댓글 입력(최신 Javascript(ES6) 문법 적용)
		formComment.onsubmit = async (e) => {
			e.preventDefault();
			
			// 개별 데이터 취합
			const parent  = formComment.parent.value;
			const writer  = formComment.writer.value;
			const content = formComment.content.value;
			
			// 전송 데이터 생성(폼데이터)
			const paramsData = new URLSearchParams({
				'parent': parent,
				'writer': writer,
				'content': content
			});
			
			// 데이터 서버 전송
			const response = await fetch(commentURL, {
				method: 'POST',
				body: paramsData
			});
						
			// 서버 응답 데이터 수신
			const data = await response.json();
			console.log('data : ' + JSON.stringify(data));
			
			if(data != null){
				// 댓글목록 동적 처리
				let article = "<article>";
				    article += "<span class='nick'>"+data.nick+"</span>";
					article += "<span class='date'>"+data.rdate+"</span>";
					article += "<textarea readonly class='content' data-value='"+data.content+"'>"+data.content+"</textarea>";
					article += "<div>";
					article += "<a href='#' class='remove' data-no='"+data.no+"'>삭제</a>";
					article += "<a href='#' class='cancel' data-no='"+data.no+"'>취소</a>";
					article += "<a href='#' class='modify' data-no='"+data.no+"'>수정</a>";
					article += "</div>";
					article += "</article>";
				
				commentList.insertAdjacentHTML('beforeend', article);
				alert('댓글이 등록 되었습니다.');
				
			}else{
				alert('댓글이 등록이 실패 했습니다.');
			}
		}; // 댓글 입력 end
		
		// 댓글 삭제 (동적 이벤트 바인딩 처리 -> 동적 생성되는 새로운 댓글목록 삭제링크가 동작함)
		
		document.addEventListener('click', function(e){
			if(e.target && e.target.classList.value == 'remove'){
				e.preventDefault();
				
				if(!confirm('정말 삭제 하시겠습니까?')){
					return;
				}
				
				const no = e.target.dataset['no'];
				//console.log('no : ' + no);
				
				const params = new URLSearchParams({
					'type': 'REMOVE',
					'no': no,
				});
				
				fetch(commentURL+'?'+params, {
					method: 'GET'
				})
				.then(res => res.json())
				.then(data => {
					console.log('data : ' + data);
					
					if(data.result > 0){
						
						alert('댓글을 삭제했습니다.');
						
						// 댓글 동적 삭제
						const article = e.target.parentNode.closest('article');
						commentList.removeChild(article);
					}else{
						alert('댓글 삭제가 실패 했습니다.');
					}
				});
			}
		});
		
		// 댓글 수정
		
		document.addEventListener('click', async function(e){
			
			const article  = e.target.parentNode.closest('article');
			const textarea = article.getElementsByTagName('textarea')[0];
			const remove   = article.getElementsByClassName('remove')[0];
			const cancel   = article.getElementsByClassName('cancel')[0];
			const modify   = article.getElementsByClassName('modify')[0];
			
			// 수정&수정완료
			if(e.target && e.target.classList.value == 'modify'){
				e.preventDefault();
				
				const txt = e.target.innerText;
				
				if(txt == '수정'){
					// 수정모드				
					const value = textarea.value;
					textarea.style.border = '1px solid #e4eaec';
					textarea.style.background = '#fff';
					textarea.readOnly = false;
					textarea.focus();
					
					remove.style.display = 'none';
					cancel.style.display = 'inline';
					modify.innerText = '수정완료';
					
				}else if(txt == '수정완료'){
					
					if(!confirm('정말 수정 하시겠습니까?')){
						return;
					}
										
					const no = e.target.dataset['no'];
					const content = textarea.value;
					
					const params = new URLSearchParams({
						'type': 'MODIFY',
						'no': no,
						'content': content
					});
					
					// 데이터 서버 전송
					const response = await fetch(commentURL+"?"+params, {
						method: 'GET'
					});
								
					// 서버 응답 데이터 수신
					const data = await response.json();
					console.log('data : ' + JSON.stringify(data));
					
					if(data.result > 0){
						alert('수정완료 했습니다.');
						
						// 수정모드 해제
						textarea.style.border = 'none';
						textarea.style.background = 'none';
						textarea.readOnly = true;
						
						remove.style.display = 'inline';
						cancel.style.display = 'none';
						modify.innerText = '수정';
						
					}else{
						alert('수정실패 했습니다.');
					}
				}
			}
			
			// 수정취소
			if(e.target && e.target.classList.value == 'cancel'){
				e.preventDefault();

				const value = textarea.dataset['value'];
				console.log('value : ' + value);
				
				// 수정모드 해제
				textarea.style.border = 'none';
				textarea.style.background = 'none';
				textarea.readOnly = true;
				textarea.value = value;
				
				remove.style.display = 'inline';
				cancel.style.display = 'none';
				modify.innerText = '수정';
			}
		});// 댓글수정  end
	}
</script>
<jsp:include page="./_aside${group}.jsp"/>
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
								<a href="/Farmstory2//board/fileDownload.do?fno=${article.fileDto.fno}">${article.fileDto.ofile}</a>&nbsp;
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
			        <a href="/Farmstory2//board/delete.do?group=${group}&cate=${cate}&no=${article.no}" class="btnDelete">삭제</a>
			        <a href="/Farmstory2//board/modify.do?group=${group}&cate=${cate}&no=${article.no}" class="btnModify">수정</a>
			        <a href="/Farmstory2//board/list.do?group=${group}&cate=${cate}" class="btnList">목록</a>
			    </div>
			    
			    <!-- 댓글리스트 -->
			    <section class="commentList">
			        <h3>댓글목록</h3>
			        <c:forEach var="comment" items="${comments}">
			            <article>
			                <span class="nick">${comment.nick}</span>
			                <span class="date">${comment.rdate}</span>
			                <textarea readonly class="content" data-value="${comment.content}">${comment.content}</textarea>                        
			                <div>
			                    <a href="#" class="remove" data-no="${comment.no}">삭제</a>
			                    <a href="#" class="cancel" data-no="${comment.no}">취소</a>
			                    <a href="#" class="modify" data-no="${comment.no}">수정</a>			                    
			                </div>
			            </article>
					</c:forEach>
					<c:if test="${empty comments}">
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
			                <input type="submit" id="btnComment" class="btnWrite" value="작성완료"/>
			            </div>
			        </form>
			    </section>
			</section>
			<!-- 내용 끝 -->
        </article>
    </section>
</div>			
<%@ include file="../_footer.jsp" %>