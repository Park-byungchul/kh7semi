<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@page import="library.beans.LendBookDto"%>
<%@page import="library.beans.LendBookDao"%>
<%@page import="java.util.List"%>
<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	
<%
	String root = request.getContextPath();

	request.setCharacterEncoding("UTF-8");
	String keyword = request.getParameter("keyword");
	
	LendBookDao lendBookDao = new LendBookDao();
	List<LendBookDto> lendBookList;
 	if(keyword == null) {
 			lendBookList = lendBookDao.list();
 		}
 		else{
 			lendBookList = lendBookDao.list(Integer.parseInt(keyword));
 		}
%>

		<div class="row text-center">
			<h2>대여 목록</h2>
		</div>
		
		<div class="row text-center">
			<form action = "lendBookList.jsp" method="get">
				
				
				<input type="text" name="keyword" size="50" height="20" required>
				<input type="submit" value="검색">
			</form>
		</div> <br><br>
		
	<div class="row text-center">
		<table border = "1" width="800" class="row text-center">
			<thead>
				<tr>
					<th width="10%">회원번호</th>
					<th width="10%">입고번호</th>
					<th width="50%">책제목</th>
					<th width="15%">대출일</th>
					<th width="15%">반납기한</th>
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
	
<jsp:include page="/template/footer.jsp"></jsp:include>