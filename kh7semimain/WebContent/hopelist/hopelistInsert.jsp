<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<jsp:include page="/template/header.jsp"></jsp:include>
<%
// 	int clientNo = (int)session.getAttribute("clientNo");

// 	ClientDao clientDao = new clientDao();
// 	ClientDto clientDto = clientDao.find(clientNo);
%>
<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>
$(function(){	
		
	$(".bookSearch-btn").on("click",function(){
		var option = "width=700,height=900";
		window.name = "parentForm"
		window.open("","target",option);
		$(".bookSearchForm").submit();
	});
	
	
});
	
</script>
<style>
	.choice-library{
		margin-left:20px;
		margin-right:20px;
		width:150px;
	}
	.search-book{
		border:1px solid white;
		border-radius:20%;
		text-decoration:none;
		padding:0.5rem;
		background-color: green;
		color:white;
	}
</style>
<div class = "container-600">
	<h2>희망도서 신청 페이지</h2>
	
	<div class="row">
				<div class="row text-left">
					<label>신청자</label>
<!-- 					value값은 clientDao 의 find 기능 구현 후 
<%-- 						<%=clientDto.getClientName()%> 으로 설정 --%>
 -->
					<input type="text"  readonly id="clientName" value="" placeholder = "session으로 clientNo가져와서 처리" class="form-input form-input-underline">
				</div>
				<div class="row text-left">
					<label>휴대폰 번호</label>
<!-- 					value값은 clientDao 의 find 기능 구현 후 
<%-- 						<%=clientDto.getClientPhone()%> 으로 설정 --%>
 -->
					<input type="text"  readonly id="clientPhone" value="" placeholder = "위와 동일" class="form-input form-input-underline">
				</div>
			
		<div class="row">
			<form class="bookSearchForm" name="bookSearchForm" action="hopelistBookSearch.jsp" method="post" target="target">
				<select name="type" >
					<option value="bookTitle">제목</option>
					<option value="bookAuthor">저자</option>
				</select>
				<input type="text" name="keyword" placeholder="검색어" class="hopelist-bookSearch">
			</form>
			<button class="bookSearch-btn">검색</button>
		</div>	
		
			
			
			<div class="row text-left">
				<label>저자</label>
				<input type="text"  Id="bookAuthor"readonly placeholder = "도서detail-희망도서신청으로 들어오거나" class="form-input form-input-underline">
			</div>
			<div class="row text-left">
				<label>제목</label>
				<input type="text" Id ="bookTitle" readonly placeholder = "위의 검색버튼으로 검색 후 detail-도서신청" class="form-input form-input-underline">
			</div>
			
			
		<form action ="hopelistInsert.kh" method="post">
			<input type="hidden" name="clientNo">
			<div class="row text-left">
				<label>비치희망 도서관</label>
				<select class="choice-library">
					<option value="1번도서관">1번도서관</option>
					<option value="2번도서관">2번도서관</option>
					<option value="3번도서관">3번도서관</option>
				</select>
			</div>
			<div class="row text-left">
				<label>신청사유</label>
				<textarea name="hopelistReason" rows="10" class="form-input"></textarea> 
			</div>
			<div class="row text-center">
				<input type="button" value="신청" class="form-btn form-btn-positive"> <hr>
				<input type="button" value="목록" class="form-btn form-btn-normal">
			</div>
		</form>
	</div>
	
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>