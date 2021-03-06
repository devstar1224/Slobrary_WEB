<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, database.*"%>
<%@page import="bucketConnector.BucketManager"%>
<jsp:useBean id="bookMgr" class="database.BookMgr" />
<%@ include file="/CND.jsp" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<!-- 아이콘 -->
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/font-awesome/4.7.0/css/font-awesome.min.css">
 <link href="/css/pagination.css" rel="stylesheet">
 <style>
.img{
	text-align: center;
	align-self: center;
}
.keyword{
	color:#353535;
}
.oth{
	color:#747474;
}
.count{
	color:#DE4F4F;
}
.non_keyword{
	color:#9354ED;
}
.alink a:hover{
	color: #424242;
	text-decoration: underline;
}
.alink a:link { color: #424242;}
.alink a:visited { color: #424242; text-decoration: none;}

.ap{
	color:6C6C6C;
	font-size:14px;
}
.title{
	color:#A593E0;
}
.alinl{
	font-size:15px;
}
.point{
	font-size:14px;
 	color:9D9D9D;
}
.keytype{
	border: 1px solid #EAEAEA;
}
.n_border{
	border-bottom: 1px solid #EAEAEA;
	border-top: 1px solid #EAEAEA;
}
</style>

<%
	request.setCharacterEncoding("UTF-8");
	//keytype과 keyword
	String keytype =request.getParameter("keytype");
	String keyword =request.getParameter("keyword");
	
	//도서결과 표기를 위해 한글로 바꿈
	String keyKor;
	if(keytype.equals("all")){
		keyKor = "전체";
	}else if(keytype.equals("title")){
		keyKor="도서명";
	}else if(keytype.equals("author")){
		keyKor="저자";
	}else{
		keyKor="출판사";
	}
	Vector vResult = bookMgr.searchBook(keytype, keyword);
	
%>
</head>
<body>
	
	<%
		//검색결과가 있는 경우
		if(vResult.size() != 0){
	%>
	<!-- 검색결과 타이틀 및 검색 옵션과 키워드 검색결과 개수 -->
  	<div class="mt-2 mb-3 pl-3">
			<h4><span style="color:#A593E0;"><i class="fas fa-search"></i></span>&nbsp;&nbsp;검색결과</h4>
			<div class="mt-3">
			    <!-- 맨 오른쪽 검색결과 개수 n권 표시 -->
				<span class="keytype m-2 mt-1 p-1 pr-2 pl-2 "><%=keyKor%></span><span class="keyword"><strong>"<%=keyword %>"</strong></span><span class="oth">(의)로 검색한 결과 </span><span class="count">총 <%=vResult.size() %>권</span>
			</div>
	</div>
	<!-- 검색결과 리스트 디자인 -->
  	<div class="pr-2 pl-2 justify-content-md-center">
  	
	<table class="table"  id="myTable">
		<!-- dataTable 생성하려면 thead 필수 -->
		<thead style="display: none;">
			 <tr><th>이미지</th><th>정보</th></tr>
		</thead>
		<tbody>
		<%
			//검색결과 개수 만큼 반복
			for(int i = 0; i<vResult.size(); i++){
				BookBean bookBean = (BookBean)vResult.get(i);
				RatingBean rateBean = bookMgr.getBookrating(bookBean.getId_num());
		%>
		<tr>
			<td class="img">
				<!-- 도서 이미지 -->
				<img class="shadow-sm" width="110" height="140" alt="<%=bookBean.getName() %>" src="<%=new BucketManager().base64DownLoader(bookBean.getImage())%>">
			</td>
			<td>
			<!--오른쪽 끝 도서명 표시 -->					<!-- 도서명 클릭시 상세보기 페이지이동 파라메타로 책구분할 id -->													
			<span class="title mr-2"><strong>[&nbsp;도서&nbsp;]</strong></span><span class="alink">
			<a href="/contents/BookDetailPage.jsp?bookid=<%=bookBean.getId_num()%>">
			<%=bookBean.getName() %></a></span><br>
			<!-- 별점 -->
			<div style="font-size: 17px;">
						<%
							double star=Double.parseDouble(rateBean.getRating());
							int fullStar = (int)Math.floor(star/1.0); //꽉찬별 개수
							boolean halfStar=false;
							
							// 0.5 경우 반별
							if(star-fullStar==0.5){
								halfStar=true;
							}
							
							for(int s=1;s<=5;s++){
								if(s<=fullStar){
								%>
									<span style="color:var(--main-color);"><i class="fas fa-star"></i></span>
								<%
								}else if(s>fullStar && halfStar==true){
									%>
									<span style="color:var(--main-color);"><i class="fas fa-star-half"></i></span>
									<span style="color:#B8B8B8; margin-left: -1.5rem;"><i class="fas fa-star-half fa-flip-horizontal"></i></span>
									<%
									if(s==5){
										break;
									}
									halfStar=false;
								}else{
								%>
									<span style="color:#B8B8B8;"><i class="fas fa-star"></i></span>
								<%
								}
							}
						%>
						<!-- 별점 숫자 표기 -->
						<span class="point ml-2"><%=star %></span>
					</div>
			<!-- 저자 -->
			<div>
			<span class="mr-2" style="color:BDBDBD; font-size:0.7px;"><i class="fas fa-square-full"></i></span><span class="ap">저자 : <%=bookBean.getAuthor() %></span><br>
			<!-- 출판사 -->
			<span class="mr-2" style="color:BDBDBD; font-size:0.7px;"><i class="fas fa-square-full"></i></span><span class="ap">출판사 : <%=bookBean.getPublisher() %></span>
			</div>
			<div id="btnbstatus"> <!-- 상세보기, 관심도서 버튼 배경색 지정하려면  class="bg-light" -->
			<div class="mt-2 pr-2" id="btnboxs">
			<div class="pt-2 float-right">
					<!-- 상세보기버튼 onclick 주소에 도서id -->
					<button id="bt1" class="btn btn-outline-secondary" onclick="location.href='/contents/BookDetailPage.jsp?bookid=<%=bookBean.getId_num() %>'" type="button">상세보기</button>
			</div>
			<div class="pt-2 pr-2 float-right">
			<!-- 관심도서 등록 form -->
				<form method="post" action="WatchBookProc.jsp">
					<!-- 도서id -->
					<input type="hidden" name="book_id" value="<%=bookBean.getId_num()%>">
					<input type="hidden" name="type" value="register">
					<button id="bt2" class="btn btn-outline-secondary" type="submit">관심도서등록</button>
				</form>
			</div>
			</div>
			<!-- 도서상태 -->
			<div id="bstauts" class="bg-light p-3">상태 : <span>&nbsp;&nbsp;<%=bookBean.getStatus() %></span></div>
			</div>
			</td>
		</tr>
		
		<%
			}
		%>
		</tbody>
	</table>
	</div>
	<%	//검색결과가 없는 경우
		}else{
		%>	
			<div class="mb-3 pl-3">
			<h4><span style="color:#A593E0;"><i class="fas fa-search"></i></i></i></span>&nbsp;&nbsp;검색결과</h4>
			<div class="mt-3">
				<span class="keytype m-2 mt-1 p-1 pr-2 pl-2 "><%=keyKor%></span><span class="keyword"><strong><%=keyword %></strong></span><span class="oth">(의)로 검색한 결과 </span><span class="count">총 0권</span>
			</div>
			</div>
			<div class="row n_border justify-content-md-center" style="text-align: center;">
			<div class="p-5">
				<p><span style='font-size:60px;'>&#128531;</span></p>
				<div>
					"<span class="non_keyword"><%=keyword %></span>"<span>에 대한 검색 결과가 없습니다.</span>
				</div>
			</div>
			</div>
		<%
		}
	%>
	
<!-- dataTable js -->
<script src="https://code.jquery.com/jquery-3.5.1.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/jquery.dataTables.min.js"></script>
<script src="https://cdn.datatables.net/1.10.21/js/dataTables.bootstrap4.min.js"></script>
<!-- paging js -->
<script type='text/javascript'>  
	var $jq = jQuery.noConflict(true);  
</script>
<script>
$jq(document).ready( function () {
	$jq('#myTable').DataTable({
    	// 표시 건수기능 숨기기 select로 몇개씩 표출할지
    	lengthChange: false,
    	
    	// 검색 기능 숨기기
    	searching: false,
    	
    	// 정렬 기능 숨기기
    	ordering: false,
    	
    	// 정보 표시 숨기기
    	info: false,
    	
    	//몇개씩 보여줄지
    	displayLength: 5,
    	language: {
            paginate: {
                previous: '‹',
                next:     '›'
            }
        }
    });
  });
    </script>
</body>
</html>