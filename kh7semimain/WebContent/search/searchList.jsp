<%@page import="library.beans.GetBookDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.GetBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	String root = request.getContextPath();

	//목록을 구하는 서버단 코드(Java)
	request.setCharacterEncoding("UTF-8");
	String type = request.getParameter("type");
	String keyword = request.getParameter("keyword");
		
	
 	GetBookDao getBookDao = new GetBookDao();
 		List<GetBookDto> getBookList;
 		//select값이 기본 -> '전체' 값을 null로 주고 keyword만 전송
 		if(type == null && keyword == null) {
 			getBookList = getBookDao.list();
 		}
 		else if(type.equals("all") || type.equals(null)){
 			getBookList = getBookDao.searchList(keyword);
 		}
 		else{ //select가 '전체'가 아니면 type과 keyword 같이 전송
 			getBookList = getBookDao.searchList(type, keyword);
 		}
%>

<jsp:include page="/service/serviceSidebar.jsp"></jsp:include>
	
		<div class="row text-center">
			<h2>자료 검색</h2>
		</div>
		
		<div class="row text-center">
			<table border = "1" width="800" class="row text-center">
				<thead>
					<tr>
						<th width="10%">책번호</th>
						<th width="10%">지점번호</th>
						<th width="50%">책제목</th>
						<th width="20%">저자</th>						
						<th>상태</th>
					</tr>
				</thead>
				<tbody>
<!-- 					검색메소드가 실행되면 list가 펼쳐지게 코드 구현해야함 -->
					<%for(GetBookDto getBookDto : getBookList) {%>
					<tr>
						<td><%=getBookDto.getBookIsbn() %></td>
						<td><%=getBookDto.getAreaNo() %></td>					
						<td><%=getBookDto.getGetBookTitle()%></td>
						<td><%=getBookDto.getGetBookAuthor() %></td>
						<td><%=getBookDto.getGetBookStatus() %></td>
					</tr>
					<%} %>
				</tbody>
			</table>
		</div>	

<jsp:include page="/template/footer.jsp"></jsp:include>