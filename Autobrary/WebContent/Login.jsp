<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	Cookie[] idcookie = request.getCookies();
	Cookie[] chkcookie = request.getCookies();
	String id = "";
	String chk="";
	if(idcookie != null){
		for(Cookie c : idcookie){
			if(c.getName().equals("mem_id"))
				id=c.getValue();
			
		}
	}
	if(chkcookie != null){
		for(Cookie c : chkcookie){
			if(c.getName().equals("chk"))
				chk = c.getValue();
		}
	}
%>
<!DOCTYPE html>
<html>
<head>
	<title>Slobrary - 로그인</title>
	<%@ include file="/CND.jsp" %>
    <link href="css/login.css" rel="stylesheet">
</head>
<body class="bg-light">
    <jsp:include page="Top.jsp" flush="false"/>

    <div id="document">
        <div class="row p-5 ml-5 mr-5" id="div1"> <!-- 5에서 3으로 수정 -->
            <div class="col bg-white shadow-sm p-5 ml-5 mr-5" id="div2">
                <div id="wrapper">
                <h4 id="h4log">로그인</h4>
                <hr>
                <form action="LoginCookie.jsp" method="post" id="login-form">
                    <div class="form-group">
                        <label for="input_id">아이디</label>                        
                        <input type="text" class="form-control" id="input_id" name="mem_id" placeholder="아이디를 입력해주세요." value=<%=id %>>
                   
                        <label for="input_pw">비밀번호</label>
                        <input type="password" class="form-control" id="input_pw" name="mem_pw" placeholder="비밀번호를 입력해주세요.">

                        <div class="custom-control custom-checkbox mt-1">
                            <input type="checkbox" class="custom-control-input" id="remember" name="remember" value="true" <%=chk %> >
                            <label class="custom-control-label" for="remember">내 정보 기억하기</label>
                        </div>
                        <div id="btn-group" class="mt-3 mb-3 float-right">
                        	<a href="contents/FindId.jsp">아이디 찾기</a>
                        	<span>|</span>
                            <a href="contents/FindPwd.jsp">비밀번호 찾기</a>
                            <span>|</span>
                            <a href="Signup.jsp">회원가입</a>
                        </div>
                        <input id="submit-btn" type="submit" class="btn btn-dark mt-5" value="로그인">
                    </div>
                </form>
            </div>
            </div>
        </div>
    </div>
</body>
</html>