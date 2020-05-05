<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<!-- 아이콘 -->
<link rel="shortcut icon" href="../img/favicon.ico">

<!-- 웹폰트 -->
<link href="https://fonts.googleapis.com/css?family=Noto+Sans+KR:300,400&display=swap&subset=korean" rel="stylesheet">
    
<!-- 부트스트랩 -->
<link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css">
<script src="https://code.jquery.com/jquery-3.3.1.slim.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.3/umd/popper.min.js"></script>
<script src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/js/bootstrap.min.js"></script>

<style>
* {
    font-family: 'Noto Sans KR', sans-serif;
}
</style>

<title>아이디 찾기</title>
</head>
<body class="bg-light">

<!-- 일치하지 않는 경우 경고창 띄우고 이전 페이지로 이동 -->
<%
	request.setCharacterEncoding("UTF-8");
	String name= request.getParameter("mem_name");
	
	if(name.equals("양지현")==false){

	out.println("<script>alert('일치하는 회원정보가 없습니다.');history.back();</script>");	
	}else{
%>


<!-- 회원정보가 일치한 경우 보여주는 페이지 -->
	<div class="container-fluid">
		<div class="row justify-content-md-center">
			<div class="col-sm-4 shadow-sm p-3 mb-5 bg-white p-5">
				<div class="title">
					<h4>아이디 찾기</h4><hr>
				</div>
				<div>
					<p style="font-size:15px;">회원님의 정보와 일치하는 아이디입니다.</p><br>
				</div>
				<div style="border:#BDBDBD solid 1px;" class="pt-3 pl-4">
					<table class="table table-borderless">
						<tr><th>아이디</th><td>yangz</td> <th>가입일</th> <td>1999년 7월 27일</td> </tr>
					</table>
				</div>
				<div style="text-align:right;" class="mt-4">
                    <button class="btn btn-outline-success mr-1" >로그인</button>
					<button class="btn btn-outline-info" >비밀번호 찾기</button>
				</div>
			</div>
		</div>
	</div>
<%} %>
</body>
</html>