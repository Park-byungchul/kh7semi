<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
String root = request.getContextPath();
request.setCharacterEncoding("UTF-8");
RoleAreaDao roleAreaDao = new RoleAreaDao();
ClientDao clientDao = new ClientDao();

String search = request.getParameter("search");
boolean isSearch = search != null;

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "권한관리자 목록";

//////////페이지네이션
int pageNo;
try{
pageNo = Integer.parseInt(request.getParameter("pageNo"));
}
catch (Exception e){
pageNo = 1;
}

int pageSize = 10; // 1페이지에 보여줄 개수

//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
int strNum = pageSize * pageNo - (pageSize-1);
int endNum = pageSize * pageNo;


List<ClientDto> adminPermissionList;
int count;

if(!isSearch){
	adminPermissionList = clientDao.adminPermissionList(strNum, endNum);
	count = clientDao.getAdminPermissionCount();
}
else{
	adminPermissionList = clientDao.adminPermissionList(search, strNum, endNum);
	count = clientDao.getAdminPermissionCount(search);
}

int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){ // 범위를 벗어나면
endBlock = lastBlock; // 범위를 수정
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

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
					<span class="title">권한관리자 목록</span>
				</div>
				
				<div class="row">
					<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 권한관리자 목록</span>
				</div>
			</div>

	<div class="row text-right">
		<button class="board-btn"><a class="btn-text" href="roleInsert.jsp">권한 등록</a></button>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="20%">관리자</th>
					<th>지점</th>
				</tr>
			</thead>
			<tbody>
					<tr>
						<th width="20%">관리자</th>
						<th>지점</th>
					</tr>
				</thead>
				<tbody>
					<%for(ClientDto clientDto : adminPermissionList){ %>
						<tr>
							<td>
								<a href="<%=root%>/client/clientInfo.jsp?clientNo=<%=clientDto.getClientNo()%>">[<%=clientDto.getClientNo() %>]<%=clientDto.getClientName() %>[<%=clientDto.getClientId() %>]</a>
							</td>
							<td>
								<%List<RoleAreaDto> roleList = roleAreaDao.areaListByClient(clientDto.getClientNo()); %>
								
								<%for (RoleAreaDto roleAreaDto : roleList){ %>
									<a href="roleDetail.jsp?roleClientNo=<%=roleAreaDto.getClientNo()%>&roleAreaNo=<%=roleAreaDto.getAreaNo()%>">[<%=roleAreaDto.getAreaNo() %>]<%=roleAreaDto.getAreaName() %></a>
								<%} %>
							</td>
						</tr>
					<%} %>
				</tbody>
			</table>
		</div>
		
		<div class="text-center pagination">
		<%if(startBlock > 1){ %>
			<a class="move-link">이전</a>
			<%} %>
			<%for(int i = startBlock ; i <= endBlock ; i++){ %>
				<%if(i == pageNo){ %>
					<a href="roleList.jsp?pageNo=<%=i %>
						<%if(isSearch){ %>
							&search=<%=search %>
						<%} %>
					" class="on"><%=i %></a>
				<%}else{ %>
					<a href="roleList.jsp?pageNo=<%=i %>
						<%if(isSearch){ %>
							&search=<%=search %>
						<%} %>
					"><%=i %></a>
				<%} %>
			<%} %>
			<%if(endBlock < lastBlock){ %>
			<a class="move-link">다음</a>
			<%} %>
			
		</div>
		
		<div class="row text-center">
		<form action="roleList.jsp" method="post">
			<input type="hidden" value="1" name="pageNo">
			<input type="text" class="text-search-form" name="search" id="search" required>
			<input type="submit" class="form-btn form-btn-inline" value="검색">
		</form>
	</div>
		
		</div>

<jsp:include page="/template/footer.jsp"></jsp:include>