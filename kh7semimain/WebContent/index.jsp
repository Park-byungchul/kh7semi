<%@page import="library.beans.BookDto"%>
<%@page import="library.beans.BookDao"%>
<%@page import="library.beans.RecommendDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.RecommendDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
int areaNo;
AreaDao areaDao = new AreaDao();
AreaDto areaDto;
try{
	areaNo = (int)session.getAttribute("areaNo");
	areaDto = areaDao.detail(areaNo);
}
catch (Exception e){
	areaNo = 0;
	areaDto = null;
}
boolean isChild = areaNo != 0;	

RecommendDao recommendDao = new RecommendDao();
List<RecommendDto> recommendRank = recommendDao.rank(1, 3);

request.setCharacterEncoding("UTF-8");

String title;
if(areaNo > 0){
	title =areaDao.detail(areaNo).getAreaName();
} else {
 title = "메인 도서관";
}
%>

<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<div>
	<article>
		<header>
			<form action="#" method="post">
				<input type="text" placeholder="통합 검색">
				<input type="submit" value="검색">
			</form>
		</header>
	
		<section>
			<%if(isChild){ %>
			<h1><%=areaDto.getAreaName() %> 메인</h1>
			<%}else{ %>
			<h1>통합도서관 메인</h1>
			<%} %>
		</section>
		<section>
			<p>추천도서-추천수순위 프로토타입</p>
			<%for(RecommendDto recommendDto : recommendRank) { %>
				<%
				int bookIsbn = recommendDto.getBookIsbn();
				BookDao bookDao = new BookDao();
				BookDto bookDto = bookDao.get(bookIsbn);
				%>
				
				isbn= <%=recommendDto.getBookIsbn()%>
				저자= <%=bookDto.getBookAuthor()%>
				제목= <%=bookDto.getBookTitle()%>
				장르= <%=bookDto.getGenreNo()%><br>
			<%} %>
		</section>
<jsp:include page="/template/footer.jsp"></jsp:include>