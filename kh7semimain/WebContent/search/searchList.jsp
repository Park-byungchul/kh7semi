<%@page import="library.beans.GetBookSearchDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookSearchDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();

	//목록을 구하는 서버단 코드(Java)
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
		
	
 	GetBookSearchDao getBookSearchDao = new GetBookSearchDao();
 		List<GetBookSearchDto> getBookList;
 		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
 		if(type == null && keyword == null) {
 			getBookList = getBookSearchDao.list();
 		}
 		else if(type.equals("all") || type.equals(null)){
 			getBookList = getBookSearchDao.searchList(keyword);
 		}
 		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
 			getBookList = getBookSearchDao.searchList(type, keyword);
 		}
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>	
		<div class="row text-center">
			<h2>자료 검색</h2>
		</div>
		
		<div class="row text-center">
				<form action = "searchList.jsp" method="get">
					<select name="type">
						<option value="all">전체</option>
						<option value="book_title">서명</option>
						<option value= "book_author">저자</option>
					</select>
				
				<input type="text" name="keyword" size="50" height = "20" required>
				<input type="submit" value="검색">
				</form>					
			</div> <br><br>
		
		<div class="row text-center">
			<table border = "1" width="800" class="row text-center">
				<thead>
					<tr>
						<th width="10%">책번호</th>
						<th width="10%">지점명</th>
						<th width="50%">책제목</th>
						<th width="20%">저자</th>						
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
<!-- 					검색메소드가 실행되면 list가 펼쳐지게 코드 구현해야함 -->
					<%for(GetBookSearchDto getBookSearchDto : getBookList) {%>
					<tr>
						<td><%=getBookSearchDto.getBookIsbn() %></td>
						<td><%=getBookSearchDto.getAreaName() %></td>					
						<td><%=getBookSearchDto.getBookTitle()%></td>
						<td><%=getBookSearchDto.getBookAuthor() %></td>
						<td><%=getBookSearchDto.getGetBookStatus() %></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>	

<jsp:include page="/template/footer.jsp"></jsp:include>