<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <!--  
    Document Title
    =============================================
    -->
    <title>LOGIN</title>
    <!--  
    Favicons
    =============================================
    -->
    <link rel="apple-touch-icon" sizes="57x57" href="assets/images/favicons/apple-icon-57x57.png">
    <link rel="apple-touch-icon" sizes="60x60" href="assets/images/favicons/apple-icon-60x60.png">
    <link rel="apple-touch-icon" sizes="72x72" href="assets/images/favicons/apple-icon-72x72.png">
    <link rel="apple-touch-icon" sizes="76x76" href="assets/images/favicons/apple-icon-76x76.png">
    <link rel="apple-touch-icon" sizes="114x114" href="assets/images/favicons/apple-icon-114x114.png">
    <link rel="apple-touch-icon" sizes="120x120" href="assets/images/favicons/apple-icon-120x120.png">
    <link rel="apple-touch-icon" sizes="144x144" href="assets/images/favicons/apple-icon-144x144.png">
    <link rel="apple-touch-icon" sizes="152x152" href="assets/images/favicons/apple-icon-152x152.png">
    <link rel="apple-touch-icon" sizes="180x180" href="assets/images/favicons/apple-icon-180x180.png">
    <link rel="icon" type="image/png" sizes="192x192" href="assets/images/favicons/android-icon-192x192.png">
    <link rel="icon" type="image/png" sizes="32x32" href="assets/images/favicons/favicon-32x32.png">
    <link rel="icon" type="image/png" sizes="96x96" href="assets/images/favicons/favicon-96x96.png">
    <link rel="icon" type="image/png" sizes="16x16" href="assets/images/favicons/favicon-16x16.png">
    <link rel="manifest" href="/manifest.json">
    <meta name="msapplication-TileColor" content="#ffffff">
    <meta name="msapplication-TileImage" content="assets/images/favicons/ms-icon-144x144.png">
    <meta name="theme-color" content="#ffffff">
    <!--  
    Stylesheets
    =============================================
    
    -->
    <!-- Default stylesheets-->
    <link href="assets/lib/bootstrap/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Template specific stylesheets-->
    <link href="https://fonts.googleapis.com/css?family=Roboto+Condensed:400,700" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Volkhov:400i" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,600,700,800" rel="stylesheet">
    <link href="assets/lib/animate.css/animate.css" rel="stylesheet">
    <link href="assets/lib/components-font-awesome/css/font-awesome.min.css" rel="stylesheet">
    <link href="assets/lib/et-line-font/et-line-font.css" rel="stylesheet">
    <link href="assets/lib/flexslider/flexslider.css" rel="stylesheet">
    <link href="assets/lib/owl.carousel/dist/assets/owl.carousel.min.css" rel="stylesheet">
    <link href="assets/lib/owl.carousel/dist/assets/owl.theme.default.min.css" rel="stylesheet">
    <link href="assets/lib/magnific-popup/dist/magnific-popup.css" rel="stylesheet">
    <link href="assets/lib/simple-text-rotator/simpletextrotator.css" rel="stylesheet">
    <!-- Main stylesheet and color file-->
    <link href="assets/css/style.css" rel="stylesheet">
    <link id="color-scheme" href="assets/css/colors/default.css" rel="stylesheet">
	<link href="../css/login.css" rel="stylesheet">
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
<script src="https://cdn.jsdelivr.net/npm/sweetalert2@10"></script>
<script src="./js//jquery-3.7.0.min.js"></script>
<script type="text/javascript">

// 카카오로그인
function kakaoLogin(){
	location.href="https://kauth.kakao.com/oauth/authorize?client_id=***REST_API***&redirect_uri=http://localhost/login/kakao&response_type=code"
	//window.open("https://kauth.kakao.com/oauth/authorize?client_id=***REST_API***&redirect_uri=http://localhost/login&response_type=code", "_blank", "width=500, height=500");
	//opner.document.location.href="http://localhost/"
}

//네이버로그인
function naverLogin(){
	location.href="https://nid.naver.com/oauth2.0/authorize?client_id=***CLIENT_ID***&redirect_uri=http://localhost/login/naver&response_type=code";
}


$(function() {
	
	//쿠키 검사
	let userID = getCookie("userID");
	let setY = getCookie("setY");
	let setS = getCookie("setS");
	
	
	if (setS == "S"){
		alert("자동로그인에 체크함");
		window.location.href = "/login";
	}
	else if(setY == "Y"){
		$("#saveID").prop("checked", true);
		$("#id").val(userID);
	} 
	else{
		$("#saveID").prop("checked", false);
	}
	
	
	$("#loginbtn").click(function(){
		
		let check = false;	// login-form 최종제출을 위한 변수선언

		let id = $("#id").val();
		let pw = $("#pw").val();
		
		if(id == "" || id.length < 3){
			Swal.fire('아이디를 입력해주세요.');
			$("#id").focus();
		} 
		else if(pw.length < 3) {
			Swal.fire('비밀번호를 입력해주세요.');
			$("#pw").focus();
		}  
		else{
			check = true;
		}
		
		// 체크여부확인
		let saveIDT = $("#saveID").is(":checked"); // 아이디저장체크_ true
		let saveAllT = $("#saveAll").is(":checked"); // 자동로그인체크_ true
		
		if(saveAllT){
			alert("S쿠키저장");
			setCookie("SuserID", id, 2)
			setCookie("setS", "S", 2)
			
			let sid = getCookie("SuserID");
			let setS = getCookie("setS");
			
			$.ajax({
				url : "./autoLogin",
				type : "post",
				data : {sid : sid, setS : setS},
					dataType : "json",
					success : function(data) {
						saveIDT = false;
					},
					error : function(error) {
						alert("에러발생");
						}
				});
			
		} else if(saveIDT) {	// true
			
			alert("쿠키저장");
			setCookie("userID", id, 2);
			setCookie("setY", "Y", 2);
			saveIDT = false;
			
		} else if (!saveIDT) {	// false
			
			alert("진행x"); 
			delCookie("userID");
			delCookie("setY");
		}

		//login-form 최종제출
 		if(check){
			document.getElementById('frm').submit();
		}
	});
	
	
	// 쿠키 저장
	function setCookie(cookieName, value, exdays){
		let exdate = new Date();
		exdate.setDate(exdate.getDate() + exdays);
		
		let cookieValue;
		if(exdays == null) {
			cookieValue = value;
		} else {
			cookieValue = value +"; expires="+ exdate.toUTCString()
		}
		
		document.cookie = cookieName+"="+cookieValue;
	}
	
	
	// 쿠키 삭제
	function delCookie(cookieName){
		let expireDate = new Date();
		expireDate.setDate(expireDate.getDate() - 1);
		document.cookie = cookieName +"="+ "; expires="+ expireDate.toUTCString()
	}
	
	
	// 쿠키가져오기
	function getCookie(cookieName){
		let cname, cvalue;
		let val = document.cookie.split(";");
		for(let i = 0; i < val.length; i++){
			cname = val[i].substr(0, val[i].indexOf("="));
			cvalue = val[i].substr(val[i].indexOf("=")+1);
			cname = cname.trim();
			
			if(cname == cookieName){
				return cvalue;
			}
		}
	}

});

</script>

</head>
<body data-spy="scroll" data-target=".onpage-navigation" data-offset="60">
  <%@ include file="menu.jsp"%>
  
	<div class="Lcontainer" align="center">
		<div class="login-form" align="center">
			<form action="/login" method="post" id="frm">
				<div class="form-item idBox">
					<input type="text" name="id" id="id" placeholder="아이디를 입력하세요">
				</div>
				<div class="form-item pwBox">
					<input type="password" name="pw" id="pw" placeholder="패스워드를 입력하세요">
				</div>
				<div class="saveBox">
					<div class="form-item saveIDBox">
						<input type="checkbox" id="saveID"> <label for="saveID">아이디저장</label>
					</div>
					<div class="form-item saveAllBox">
						<input type="checkbox" id="saveAll"> <label for="saveAll">자동로그인</label>
					</div>
				</div>

				<div class="form-item loginBtnBox">
					<button type="button" id="loginbtn">로그인</button>
				</div>
			</form>
		</div>

		<div class="login-with" align="center">
			<div id="kbtnBox">
				<img src="img/login/login_kakaoBtn.png" alt="kakaoBtn" id="kakao" onclick="kakaoLogin()">
			</div>
			<div id="nbtnBox">
				<img src="img/login/login_naverBtn.png" alt="naverBtn" id="naver" onclick="naverLogin()">
			</div>
		</div>
		
		<div class="forUserBox" align="center">
			<a href="./finduser">아이디 & 비밀번호 찾기 </a> |
			<a href="./join"> 회원가입</a>
		</div>
	</div>
	    <!--  
    JavaScripts
    =============================================
    -->
    <script src="assets/lib/jquery/dist/jquery.js"></script>
    <script src="assets/lib/bootstrap/dist/js/bootstrap.min.js"></script>
    <script src="assets/lib/wow/dist/wow.js"></script>
    <script src="assets/lib/jquery.mb.ytplayer/dist/jquery.mb.YTPlayer.js"></script>
    <script src="assets/lib/isotope/dist/isotope.pkgd.js"></script>
    <script src="assets/lib/imagesloaded/imagesloaded.pkgd.js"></script>
    <script src="assets/lib/flexslider/jquery.flexslider.js"></script>
    <script src="assets/lib/owl.carousel/dist/owl.carousel.min.js"></script>
    <script src="assets/lib/smoothscroll.js"></script>
    <script src="assets/lib/magnific-popup/dist/jquery.magnific-popup.js"></script>
    <script src="assets/lib/simple-text-rotator/jquery.simple-text-rotator.min.js"></script>
    <script src="assets/js/plugins.js"></script>
    <script src="assets/js/main.js"></script>
</body>
</html>
