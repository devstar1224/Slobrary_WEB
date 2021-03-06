<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="/CND.jsp"%>
<%@ page import="java.util.*, database.*"%>
<jsp:useBean id="boardMgr" class="database.BoardMgr" />

<%
	String mem_id = (String)session.getAttribute("loginKey");
	String category = "커뮤니티";
	String pageNames = "도서 별점, 독서일기, 독후감, 자유게시판";
	String pageUrls = "ReviewPage.jsp, BookDiaryPage.jsp, " + "BookReportPage.jsp, CommunityPage.jsp";
	String currentPage = "자유게시판";
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Slobrary - <%=currentPage%></title>
<style>
.lock-icon{
	width:25px;
	color:#CFCFCF;
}
.lock{
	text-align: center;
}
.hide-text{
	visibility: hidden;
}
</style>
<link href="/css/allNeed.css" rel="stylesheet">
<link href="/css/bookReportPage.css?v=1" rel="stylesheet">
<link href="/css/dataTable_empty.css" rel="stylesheet">
<link href="/css/pagination.css" rel="stylesheet">
</head>
<body>
	<header>
		<jsp:include page="/Top.jsp" flush="false" />
	</header>
	
	<div class="container-fluid mb-5">
		<div class="row mt-4 pt-4 justify-content-md-center">
			<!-- sub nav -->
			<div class="col-xl-3 mr-n4" id="menuid">
				<jsp:include page="/SideMenuBar.jsp" flush="false">
					<jsp:param name="category" value="<%=category%>" />
					<jsp:param name="pageNames" value="<%=pageNames%>" />
					<jsp:param name="pageUrls" value="<%=pageUrls%>" />
					<jsp:param name="currentPage" value="<%=currentPage%>" />
				</jsp:include>
			</div>
			<%
				String type = request.getParameter("type");
			
				if(type==null){
				//모든 자유게시글..
			%>
			<section class="main-content col-xl-8 mt-3">
				<!-- title -->
				<h1 class="main-title mb-2">
					<i class="far fa-square"></i>
					&nbsp;<%=currentPage%>
				</h1>
				<div class="table_div">
				<table class="table contents mb-4" id="freeTable">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col" class="lock"><span class="hide-text">공개</span></th>
						</tr>
					</thead>
					<tbody>
						<%
							Vector Vboard = boardMgr.getBoardList(null, "all");
							for(int i=0;i<Vboard.size();i++){
								BoardBean boardBean = (BoardBean)Vboard.get(i);
						%>
						<tr>
							<td><%=i+1 %></td>
							<!-- 제목 및 링크 -->
							<td class="alink"><a href="GoDetailProc.jsp?board_id=<%=boardBean.getBoard_id()%>"><%=boardBean.getTitle() %></a></td>
							<!-- 작성자 -->
							<td><%=boardBean.getMem_id() %></td>
							<%
								if(boardBean.getScope().equals("private")){	
							%>
							<!-- 비공개 -->
							<td class="lock"><span class="lock-icon"><i class="fas fa-lock"></span></i></td>
							<%}else{ %>
							<!-- 공개 -->
							<td class="lock"><span class="lock-icon"></span></td>
							<%}%>	
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				</div>
				<div class="btn_div pr-3">
					<button type="button" onclick="location.href='DrawUp.jsp?type=free'" class="btn btn-outline-secondary pr-4 pl-4">글쓰기</button>
					<button type="button" onclick="location.href='CommunityPage.jsp?type=myFree'" class="btn btn-outline-secondary mr-2">나의 게시글</button>
				</div>
			</section>
			<%
				}else{	
				// 나의 자유 게시글
				//로그인 유효성 검사
				if(mem_id == null){
						
					%><script>
					alert("로그인 후 사용가능합니다.");
					history.back();
					</script>
					<%
				}
				Vector myBoard = boardMgr.getBoardList(mem_id, "mem");
			%>
				<section class="main-content col-xl-8 mt-3">
				<!-- title -->
				<h1 class="main-title mb-2">
					<i class="far fa-square"></i>
					&nbsp;나의 게시글
				</h1>
				<div class="table_div">
				<table class="table contents mb-4" id="freeTable">
					<thead>
						<tr>
							<th scope="col">번호</th>
							<th scope="col">제목</th>
							<th scope="col">작성자</th>
							<th scope="col" class="lock"><span class="hide-text">공개</span></th>
						</tr>
					</thead>
					<tbody>
						<%
							for(int i=0;i<myBoard.size();i++){
								BoardBean boardBean = (BoardBean)myBoard.get(i);
						%>
						<tr>
							<td><%=i+1 %></td>
							<!-- 제목 및 링크 -->
							<td class="alink"><a href="GoDetailProc.jsp?board_id=<%=boardBean.getBoard_id()%>"><%=boardBean.getTitle() %></a></td>
							<!-- 작성자 -->
							<td><%=boardBean.getMem_id() %></td>	
							<%

								if(boardBean.getScope().equals("private")){
									
							%>
							<!-- 비공개 -->
							<td class="lock"><span class="lock-icon"><i class="fas fa-lock"></span></i></td>
							<%}else{ %>
							<!-- 공개 -->
							<td class="lock"><span class="lock-icon"></span></td>
							<%}%>
						</tr>
						<%
							}
						%>
					</tbody>
				</table>
				</div>
				<div class="btn_div pr-3">
					<button type="button" onclick="location.href='DrawUp.jsp?type=free'" class="btn btn-outline-secondary pr-4 pl-4">글쓰기</button>
					<button type="button" onclick="location.href='CommunityPage.jsp'" class="btn btn-outline-secondary mr-2">자유게시판</button>
				</div>
			</section>
			<%
				}
			%>
		</div>
	</div>
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
	$jq('#freeTable').DataTable({
    	// 표시 건수기능 숨기기 select로 몇개씩 표출할지
    	lengthChange: false,
    	
    	// 검색 기능 숨기기
    	searching: true,
    	
    	// 정렬 기능 숨기기
    	ordering: false,
    	
    	// 정보 표시 숨기기
    	info: false,
    	oLanguage: {
  	      sZeroRecords: "일치하는 독후감이 없습니다."
  	    },
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
<jsp:include page="/Footer.jsp" flush="false" />
</body>
</html>