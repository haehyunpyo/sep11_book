<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="https://developers.kakao.com/sdk/js/kakao.js"></script>
<script src="./js//jquery-3.7.0.min.js"></script>
<script type="text/javascript">

function kakaoLogout(){
	location.href="https://kauth.kakao.com/oauth/logout?client_id=***REST_API***&logout_redirect_uri=http://localhost/logout/kakao";
}
function naverLogout(){
	let Npopup = window.open("https://nid.naver.com/nidlogin.logout", "_blank", "width=500, height=500");
	setTimeout(function() {
		Npopup.close();
	}, 1000);
}

	$(function(){
	
		// 로그아웃_자동로그인 해제
		let sid = getCookie("SuserID");
		let setS = getCookie("setS");
		let setY = getCookie("setY");
		
		$("#logoutbtn").click(function(){
				//delCookie("SuserID");
				//delCookie("setS");
				Logout();
		});
		
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
		
		// 로그아웃
		function Logout(){
			
			if(${sessionScope.withN eq 2}){	// 네이버로그아웃 이후 로그아웃실행 
				alert("네이버로그아웃하자");
				naverLogout();
			} else if(${sessionScope.withK eq 1}){ // 카카오로그아웃 이후 로그아웃실행 
				kakaoLogout();
			} 
			window.location.href = "/logout";	// 일반로그아웃
		}
		
		
		
	});

</script>
</head>
<body>
  <%@ include file="menu.jsp"%>
	<br><br><br><br><br><br><br><br><br>
	<h1>첫 화면</h1>
	
		<div>
			<button type="button" id="logoutbtn">
				로그아웃
			</button>
		</div>
		
		
		<div>
         <c:choose>
            <c:when test="${sessionScope.mid ne null}"> id : ${sessionScope.mid} _ 로그인완</c:when>
            <c:otherwise>로그아웃상태 </c:otherwise>
         </c:choose>
      </div>
		
	
</body>
</html>
