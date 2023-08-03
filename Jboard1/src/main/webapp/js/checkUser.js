/**
 * 사용자 개인정보 중복체크
 */
// 사용자 개인정보 중복체크
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
	
}); // 사용자 개인정보 중복체크 끝