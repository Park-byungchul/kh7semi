<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String root = request.getContextPath();

AreaDao areaDao = new AreaDao();

String search = request.getParameter("search");
boolean isSearch = search != null;

//////////페이지네이션
int pageNo;
try{
pageNo = Integer.parseInt(request.getParameter("pageNo"));
}
catch (Exception e){
pageNo = 1;
}

int pageSize = 10; // 1페이지에 보여줄 개수

// rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
int strNum = pageSize * pageNo - (pageSize-1);
int endNum = pageSize * pageNo;

List<AreaDto> list;
int count;

if(!isSearch){
	list = areaDao.list(strNum, endNum);
	count = areaDao.getCount();
} else{
	list = areaDao.search(search, strNum, endNum);
	count = areaDao.getCount(search);
}

int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){ // 범위를 벗어나면
endBlock = lastBlock; // 범위를 수정
}

int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "지점 목록";
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<%if(isSearch){ %>

<script>
	$(function(){
		$("#search").val("<%=search %>");
	});
</script>

<%} %>

	<div class="main">
	
		<div class="header">
			<div class="row">
				<span class="title">지점 목록</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 지점 목록</span>
			</div>
		</div>

	<div class="row text-right">
		<button><a href="areaInsert.jsp">지점 등록</a></button>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th>지점명</th>
					<th>지점 전화번호</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (AreaDto areaDto : list) {
				%>
				<tr>
					<td><a href="areaDetail.jsp?areaNo=<%=areaDto.getAreaNo()%>">[<%=areaDto.getAreaNo()%>]<%=areaDto.getAreaName()%></a></td>
					<td><%=areaDto.getAreaCall() %></td>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>
	
	<div class="text-center pagination">
	<%if(startBlock > 1){ %>
		<a class="move-link">이전</a>
		<%} %>
		<%for(int i = startBlock ; i <= endBlock ; i++){ %>
			<%if(i == pageNo){ %>
				<a href="areaList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%}%>
				" class="on"><%=i %></a>
			<%}else{ %>
				<a href="areaList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%}%>
				"><%=i %></a>
			<%} %>
		<%} %>
		<%if(endBlock < lastBlock){ %>
		<a class="move-link">다음</a>
		<%} %>
	</div>
	
	<div class="row text-center">
		<form action="areaList.jsp" method="post">
			<input type="hidden" value="1" name="pageNo">
			<input type="text" name="search" id="search" required>
			<input type="submit" value="검색">
		</form>
	</div>

</div>
<jsp:include page="/template/footer.jsp"></jsp:include>