<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>회원가입</title>
    <link rel="stylesheet" href="../css/style.css">
    <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.7.0/jquery.min.js"></script>
    <script>
    	
    	$(function(){
    		
    		// 아이디 중복체크
    		$('#btnCheckUid').click(function(){
    			
    			const uid = $('input[name=uid]').val();
    			    			
    			const jsonData = {
    				"uid": uid
    			};
    			
    			$.ajax({
    				url:'/Jboard1/user/checkUid.jsp',
    				type:'GET',
    				data: jsonData,
    				dataType:'json',
    				success:function(data){
    					if(data.result >= 1){
    						$('.resultId').css('color', 'red').text('이미 사용중인 아이디 입니다.');
    					}else{
    						$('.resultId').css('color', 'green').text('사용 가능한 아이디 입니다.');
    					}
    				}
    			});
    			
    		}); // 아이디 중복체크 끝
    		
    		// 닉네임 중복체크
    		$('input[name=nick]').focusout(function(){
    			
    			// 입력 데이터 가져오기
    			const nick = $(this).val();
    			
    			// JSON 생성
    			const jsonData = {
    				"nick": nick 
    			};
    			
    			// 데이터 전송
    			$.get('/Jboard1/user/checkNick.jsp', jsonData, function(data){
    				if(data.result >= 1){
    					$('.resultNick').css('color', 'red').text('이미 사용중인 별명 입니다.');
    				}else{
    					$('.resultNick').css('color', 'green').text('사용 가능한 별명 입니다.');
    				}
    			});
    			
    		});// 닉네임 중복체크 끝
    		
    		// 이메일 중복체크
    		document.getElementsByName('email')[0].onfocusout = function(){
    			
    			// 입력 데이터 가져오기
    			const email = this.value;
    			 
    			// 데이터 전송
    			const xhr = new XMLHttpRequest();
    			xhr.open('GET', '/Jboard1/user/checkEmail.jsp?email='+email);
    			xhr.send();
    			
    			// 응답 결과
    			xhr.onreadystatechange = function(){    				
    				if(xhr.readyState == XMLHttpRequest.DONE){						
						if(xhr.status == 200){
							const data = JSON.parse(xhr.response);
							console.log('data : ' + data);
							
							const resultEmail = document.getElementById('resultEmail');
							
							if(data.result >= 1){
								resultEmail.innerText = '이미 사용중인 이메일 입니다.';
								resultEmail.style.color = 'red';
							}else{
								resultEmail.innerText = '사용 가능한 이메일 입니다.';
								resultEmail.style.color = 'green';
							}
						}
					}    				
    			}// onreadystatechange end
    		} // 이메일 중복체크 끝
    		
    		// 휴대폰 중복체크
    		document.getElementsByName('hp')[0].addEventListener('focusout', function(){
    			
    			const url = '/Jboard1/user/checkHp.jsp?hp='+this.value;
    			
				fetch(url)
					.then(response => response.json())
					.then(data => {
						console.log(data);
						const resultHp = document.getElementById('resultHp');
						
						if(data.result >= 1){
							resultHp.innerText = '이미 사용중인 휴대폰번호 입니다.';
							resultHp.style.color = 'red';
						}else{
							resultHp.innerText = '사용 가능한 휴대폰번호 입니다.';
							resultHp.style.color = 'green';
						}
					});
				
    		}); // 휴대폰 중복체크 끝
    		
    		
    	});
    
    </script>
</head>
<body>
    <div id="container">
        <header>
            <h3>Board System v1.0</h3>
        </header>
        <main>
            <section class="register">
                <form action="/Jboard1/user/registerProc.jsp" method="post">
                    <table border="1">
                        <caption>사이트 이용정보 입력</caption>
                        <tr>
                            <td>아이디</td>
                            <td>
                                <input type="text" name="uid" placeholder="아이디 입력"/>
                                <button type="button" id="btnCheckUid"><img src="../images/chk_id.gif" alt=""></button>
                                <span class="resultId"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호</td>
                            <td>
                                <input type="password" name="pass1" placeholder="비밀번호 입력"/>                            
                            </td>
                        </tr>
                        <tr>
                            <td>비밀번호 확인</td>
                            <td>
                                <input type="password" name="pass2" placeholder="비밀번호 확인 입력"/>
                                <span class="resultPass"></span>
                            </td>
                        </tr>
                    </table>
                    <table border="1">
                        <caption>개인정보 입력</caption>
                        <tr>
                            <td>이름</td>
                            <td>
                                <input type="text" name="name" placeholder="이름 입력"/>                            
                            </td>
                        </tr>
                        <tr>
                            <td>별명</td>
                            <td>
                                <p>공백없이 한글, 영문, 숫자만 입력가능</p>
                                <input type="text" name="nick" placeholder="별명 입력"/>
                                <span class="resultNick"></span>                            
                            </td>
                        </tr>
                        <tr>
                            <td>E-Mail</td>
                            <td>
                                <input type="email" name="email" placeholder="이메일 입력"/>
                                <span id="resultEmail"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>휴대폰</td>
                            <td>
                                <input type="text" name="hp" placeholder="- 포함 13자리 입력" minlength="13" maxlength="13" />
                                <span id="resultHp"></span>
                            </td>
                        </tr>
                        <tr>
                            <td>주소</td>
                            <td>
                                <div>
                                    <input type="text" name="zip" placeholder="우편번호" readonly/>                                
                                    <button class="btnZip"><img src="../images/chk_post.gif" alt=""></button>
                                </div>                            
                                <div>
                                    <input type="text" name="addr1" placeholder="주소를 검색하세요." readonly/>
                                </div>
                                <div>
                                    <input type="text" name="addr2" placeholder="상세주소를 입력하세요."/>
                                </div>
                            </td>
                        </tr>
                    </table>
    
                    <div>
                        <a href="#" class="btnCancel">취소</a>
                        <input type="submit"   class="btnSubmit" value="회원가입"/>
                    </div>    
                </form>
            </section>
        </main>
        <footer>
            <p>ⓒcopyright 김철학.com</p>
        </footer>
    </div>
</body>
</html>