<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	#wrapper {
		padding: 0px;
		justify-content: center;
	}
	div#login-wrap {
		width: 480px;
		height: 600px;
		background: white;
		border-radius: 15px;
		box-shadow: 0px 5px 10px rgba(0,0,0,0.2);
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
	}
	
	.login-logo {
		width: 60%;
		margin-bottom: 50px;
	}
	.login-logo:hover {
		cursor: pointer;
	}
	
	form#login-form {
		width: 100%;
	}
	
	div#login-form-elements {
		width: 100%;
		display: flex;
		flex-direction: column;
		padding: 0px 80px;
	}
	
	.login-input {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border: 1px solid lightgray;
		border-radius: 25px;
		padding: 0px 20px;
		box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	}
	
	.login-submit {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border-radius: 25px;
		border: 0px;
	}
	
	button.login-button {
		width: 100%;
		margin: 10px 0px;
		height: 50px;
		border-radius: 25px;
		overflow: hidden;
	}
	
	button.login-button-kakao {
		background: #FEE500;
		position: relative;
	}
	
	button.login-button-kakao:active {
		filter: brightness(90%);
	}
	
	img.kakao-login-symbol {
		position: absolute;
		top: 0px;
		left: 0px;
	}
	
	div#login-link {
		width: 50%;
		margin-top: 40px;
		font-size: 14px;
		display: flex;
		justify-content: space-between;
	}
</style>

<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script>

Kakao.init('a8d83e76596a6e93d144575566c3d5ae'); //???????????? ??? ??? javascript?????? ???????????????.
console.log(Kakao.isInitialized()); // sdk?????????????????????
//??????????????????
function kakaoLogin() {
    Kakao.Auth.login({
      success: function (response) {
        Kakao.API.request({
          url: '/v2/user/me',
          success: function (response) {
        	  
        	  $.ajax({
        		  type: "post",
        		  url: "kakaoLogin.do",
        		  data: {
        			  email: response.kakao_account.email,
        			  profileSrc: response.kakao_account.profile.thumbnail_image_url,
        			  nickname: response.kakao_account.profile.nickname
        		  },
        		  success: function(data) {
        			  if (data == 0) {
        				  location.href='gjoin.do?isKakao=Y'
        			  } else if (data == 1) {
        				  location.href='/';
        			  }
        		  }
        	  })
          },
          fail: function (error) {
            console.log(error)
          },
        })
      },
      fail: function (error) {
        console.log(error)
      },
    })
  }
  
 function gLogin() {

	 var email = $("input[name=email]").val();
	 var password = $("input[name=password]").val();
	 
	 if (email == '' || email == null || email == undefined ||
			 password == '' || password == null || password == undefined) {
		 return;
	 }
	 
	 $.ajax({
		 type: "post",
		 url: "glogin.do",
		 data: $("form#login-form").serialize(),
		 success: function(data) {
			 
			 if (data == 0) {
				 alert('???????????? ?????? ????????? ????????????.\n???????????? ??????????????? ????????? ?????????.')
			 } else if (data == 1) {
				 location.href='/';
			 }
			 
		 }
	 })
 }
 
	function enterkey() {
		if (window.event.keyCode == 13) {
			gLogin();
	  }
	}

</script>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<div id="wrapper">
		<div id="login-wrap">
			<img src="<%=request.getContextPath() %>/images/logo.png" class="login-logo" onclick='location.href="/"'>
				<form id="login-form">
					<div id="login-form-elements">
						<input class="login-input" type="text" name="email" placeholder="?????????" required>
						<input class="login-input" type="password" name="password" placeholder="????????????" onkeyup="enterkey()" required>
						<button class="normal-button accent-button login-submit" type="button" onclick="gLogin()">?????????</button>
						<button type="button" class="normal-button login-button login-button-kakao" onclick="kakaoLogin()">
							<img class="kakao-login-symbol" src="<%=request.getContextPath()%>/images/kakao_login_large_symbol.png" height="100%">
							<div class="kakao-login-button-text">????????? ?????????</div>
						</button>
					</div>
				</form>
				<div id="login-link">
					<div id="findpw-link">??????????????? ????????????????</div>
					<div id="separator">|</div>
					<div id="join-link"><a href="gjoin.do?isKakao=N">????????????</a></div>
				</div>
		</div>
		
		<!-- ???????????? ????????? ????????? ?????? ???????????? 
		<div>
			???????????? ????????? ????????? ?????? ????????????
			<br><br><br>
			?????? ?????? ?????? ????????? border-radius??? ???????????????<br>
			<br>
			<button>??????</button> 
			?????? ?????? (????????? ????????? ????????? ????????? ??? ????????? ?????? ?????? ?????????)<br><br>
			<button class="accent-button">??????</button> ?????? ?????? (button class="accent-button")<br><br>
			<br><br><br>
			?????? ?????? ?????? ??????
			<div class="inner-box">
				<div class="inner-box-content">
				????????? ????????? ??????
				</div>
				<div class="inner-box-button-wrap">
					<button>????????????</button>
					<button class="accent-button" style="margin-left: 15px;">????????????</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- ???????????? -->
		
	</div>
	
</body>
</html>