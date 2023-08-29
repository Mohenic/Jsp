<%@ page contentType="text/html;charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="./_header.jsp" %>
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<script src="/Jboard2/js/zipcode.js"></script>
<script src="/Jboard2/js/authEmail.js"></script>
<script>
	// 폼 데이터 검증 상태변수
	let isUidOk   = false;
	let isPassOk  = false;
	let isNameOk  = false;
	let isNickOk  = false;
	let isEmailOk = false;
	let isHpOk    = false;
	
	// 데이터 검증에 사용하는 정규표현식
	const reUid   = /^[a-z]+[a-z0-9]{4,19}$/g;
	const rePass  = /^(?=.*[a-zA-z])(?=.*[0-9])(?=.*[$`~!@$!%*#^?&\\(\\)\-_=+]).{5,16}$/;
	const reName  = /^[가-힣]{2,10}$/ 
	const reNick  = /^[a-zA-Zㄱ-힣0-9][a-zA-Zㄱ-힣0-9]*$/;
	const reEmail = /^[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*@[0-9a-zA-Z]([-_\.]?[0-9a-zA-Z])*\.[a-zA-Z]{2,3}$/i;
	const reHp    = /^01(?:0|1|[6-9])-(?:\d{4})-\d{4}$/;

	// 유효성 검사(Validation)
	$(function(){
		// 아이디 검사
		$('input[name=uid]').keydown(function(){
			$('.uidResult').text('');
			isUidOk = false;
		});
		
		// 비밀번호 검사
		$('input[name=pass2]').focusout(function(){
			
			const pass1 = $('input[name=pass1]').val();
			const pass2 = $('input[name=pass2]').val();
			
			if(pass1 == pass2){
				
				if(pass2.match(rePass)){
					$('.passResult').css('color', 'green').text('사용할 수 있는 비밀번호 입니다.');
					isPassOk = true;
				}else{
					$('.passResult').css('color', 'red').text('사용할 수 없는 비밀번호 입니다.');
					isPassOk = false;
				}
			}else{
				$('.passResult').css('color', 'red').text('비밀번호가 일치하지 않습니다.');
				isPassOk = false;
			}
		});
		
		
		// 이름 검사
		// 별명 검사
		// 이메일 검사
		// 휴대폰 검사
		
		// 최종확인
		$('#formUser').submit(function(){
			
			if(!isUidOk){
				alert('아이디를 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			if(!isPassOk){
				alert('비밀번호를 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			if(!isNameOk){
				alert('이름을 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			if(!isNickOk){
				alert('별명을 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			if(!isEmailOk){
				alert('이메일을 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			if(!isHpOk){
				alert('휴대폰을 확인하십시요.');
				return false; // 폼 전송 취소
			}
			
			return true; // 폼 전송 시작
		});
	});
	
</script>
<script src="/Jboard2/js/checkUser.js"></script>

<main id="user">
    <section class="register">
        <form id="formUser" action="/Jboard2/user/register.do" method="post">
            <table border="1">
                <caption>사이트 이용정보 입력</caption>
                <tr>
                    <td>아이디</td>
                    <td>
                        <input type="text" name="uid" placeholder="아이디 입력"/>
                        <button type="button" id="btnCheckUid"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="uidResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>비밀번호</td>
                    <td><input type="password" name="pass1" placeholder="비밀번호 입력"/></td>
                </tr>
                <tr>
                    <td>비밀번호 확인</td>
                    <td>
                    	<input type="password" name="pass2" placeholder="비밀번호 입력 확인"/>
                    	<span class="passResult"></span>
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
                        <p class="nickInfo">공백없는 한글, 영문, 숫자 입력</p>
                        <input type="text" name="nick" placeholder="별명 입력"/>
                        <button type="button" id="btnCheckNick"><img src="../img/chk_id.gif" alt="중복확인"/></button>
                        <span class="nickResult"></span>
                    </td>
                </tr>
                <tr>
                    <td>이메일</td>
                    <td>
                        <input type="email" name="email" placeholder="이메일 입력"/>
                        <button type="button" id="btnEmailCode"><img src="../img/chk_auth.gif" alt="인증번호 받기"/></button>
                        <span class="resultEmail"></span>
                        <div class="auth">
                            <input type="text" name="auth" placeholder="인증번호 입력"/>
                            <button type="button" id="btnEmailAuth"><img src="../img/chk_confirm.gif" alt="확인"/></button>
                        </div>
                    </td>
                </tr>
                <tr>
                    <td>휴대폰</td>
                    <td>
                    	<input type="text" name="hp" placeholder="휴대폰 입력"/>
                    	<span class="resultHp"></span>
                    </td>
                </tr>
                <tr>
                    <td>주소</td>
                    <td>
                        <input type="text" name="zip" placeholder="우편번호"/>
                        <button type="button" onclick="zipcode()"><img src="../img/chk_post.gif" alt="우편번호찾기"/></button>
                        <input type="text" name="addr1" placeholder="주소 검색"/>
                        <input type="text" name="addr2" placeholder="상세주소 입력"/>
                    </td>
                </tr>
            </table>
            <div>
                <a href="./login.do" class="btn btnCancel">취소</a>
                <input type="submit" value="회원가입" class="btn btnRegister"/>
            </div>
        </form>
    </section>
</main>
<%@ include file="./_footer.jsp" %>