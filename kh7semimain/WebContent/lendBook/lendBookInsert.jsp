<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.LendBookDto"%>
<%@page import="library.beans.LendBookDao"%>
<%@page import="java.util.List"%>
<%
	String root = request.getContextPath();
	LendBookDao lendBookDao = new LendBookDao();

	request.setCharacterEncoding("UTF-8");
	String clientNo = request.getParameter("clientNo");
	boolean isSearch = clientNo != null;


int areaNo;
try{
	areaNo=(int)request.getSession().getAttribute("areaNo");
}
	catch (Exception e){
		areaNo=0;
	}
	List<LendBookDto> lendBookList;
	if(clientNo == null) {
		lendBookList = null;
	}
	else{
		lendBookList = lendBookDao.list(Integer.parseInt(clientNo));
	}
	
	String title = "대여 접수";
%>
<%if(isSearch){ %>
<script>
$(function(){
  $("#clientNo").val("<%=clientNo %>");
});
</script>
<%} %>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>


	
	<script>
	var is_empty = false;
	
		function insertOnClick(){
			is_empty = false;
			$('.form').find('input[type="text"]').each(function(){
			    if(!$(this).val()) {
			        is_empty = true;
			    }
			});
			if(is_empty) {
			    alert('값을 전부 입력하시오');
			    return false;
			}
			
		}
		function onSubmit(){
			if (<%=areaNo%> == null || <%=areaNo%> == 0) {
				alert('도서관페이지가 아닌 메인페이지에서는 대여가 불가능합니다.')
				return false;	
			}
			else{
				alert('대여 접수가 완료되었습니다.');
				return true;
			}
		}
	</script>
	
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title" />
</jsp:include>

<style>
	input[type="button"]{
		width: 150px;
		height: 50px;
	}
</style>			


	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">대여 접수</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 서비스 > 회원가입</span>
			</div>
		</div>

		<section>
			<div class="row text-right">
				<input class="form-btn form-btn-inline"
				 type="button" onclick="location.href='<%=root%>/lendBook/lendBookUpdate.jsp'" value="대여 반납">
			</div>
			<div class= "float-container">
				<aside class="multi-container">
				
				</aside>
				<div class="multi-container" style="width:80%;">
			
				
			<!-- 	대여 접수 입력창 구현 -->
				<div>
					<form action = "lendBookInsert.kh" method="post" class = "form" onsubmit="return onSubmit()">		
						회원번호 : <input type="text" name="clientNo" size="50" height = "20" required id = "clientNo">
<%--  						회원번호 : <input type="text" name="clientNo" size="50" height = "20" value = <%=clientNo%> required> --%>
						 <br><br>
						입고번호 : <input type="text" name="getBookNo" size="50" height = "20" required>
						 <br><br>
						 <input type="hidden" name="areaNo" size="50" height = "20" value="<%=areaNo %>"required>
						 <br><br>						
						<input type="submit" onclick="insertOnClick()"value="대여 접수" class="form-btn form-btn-inline">			
					</form>	
									
				</div> <br><br>
				
			</div>
		</div>		
			<div class="row text-right">
						<input class="form-btn form-btn-inline"
						 type="button" onclick="location.href='<%=root%>/lendBook/lendBookList.jsp'" value="대출목록 조회">
					</div>
		</section>
		
	
	<%if(isSearch){ %>
	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>회원번호</th>
					<th>입고번호</th>
					<th>책제목</th>
					<th>대출일</th>
					<th>반납기한</th>
				</tr>
			</thead>
			<tbody>
				<%for(LendBookDto lendBookDto : lendBookList) {%>
					<tr>
						<td><%=lendBookDto.getClientNo() %></td>					
						<td><%=lendBookDto.getGetBookNo() %></td>
						<td> <a href = "<%=root%>/getBook/getBookDetail.jsp?getBookNo=<%=lendBookDto.getGetBookNo()%>"><%=lendBookDto.getBookTitle()%></a></td>
						<td><%=lendBookDto.getLendBookDate() %></td>
						<td><%=lendBookDto.getLendBookLimit() %></td>
					</tr>
					<%} %>
			</tbody>
		</table>
	</div>
	
	
	<%} %>
		<jsp:include page="/template/footer.jsp"></jsp:include>