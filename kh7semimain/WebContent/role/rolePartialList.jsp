
<%@page import="library.beans.RoleDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.RoleAreaDto"%>
<%@page import="library.beans.RoleAreaDao"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
request.setCharacterEncoding("UTF-8");
AreaDao areaDao = new AreaDao();

String root = request.getContextPath();

String search = request.getParameter("search");
boolean isSearch = search != null;

int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}


String title = "일반관리자 목록";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int clientNo = (int)session.getAttribute("clientNo");
ClientDao clientDao = new ClientDao();
ClientDto clientDto = clientDao.get(clientNo);
RoleAreaDao roleAreaDao = new RoleAreaDao();

RoleDao roleDao = new RoleDao();
boolean isAdmin = roleDao.isAdmin(clientNo, areaNo);

List<ClientDto> adminNormalList = clientDao.adminNormalList();

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


List<AreaDto> areaList;
int count;
if(clientDto.getClientType().equals("전체관리자")){
	if(isSearch){
		areaList = areaDao.searchAdmin(search, strNum, endNum);
		count = areaDao.getAdminCount(search);
	}else{
		areaList = areaDao.list(strNum, endNum);
		count = areaDao.getCount();
	}
} else{
	areaList = areaDao.list(strNum, endNum);
	count = areaDao.getCount();
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
					<span class="title">일반관리자 목록
					<%if(areaNo > 0){ %>
						(<%=areaDao.detail(areaNo).getAreaName() %>)
						<%} %>
					</span>
				</div>
				
				<div class="row">
					<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 권한관리자 > 일반관리자 목록</span>
				</div>
			</div>
	
	<div class="row text-right">
		<button class="board-btn"><a class="btn-text" href="rolePartialInsert.jsp">관리자 추가</a></button>
	</div>
	
	<div class="row text-center"">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="20%">
						<span>지점</span>
					</th>
					<th>
						<span>관리자</span>
					</th>
				</tr>
			</thead>
			</tbody>
				<%if(areaNo == 0){ %>
				<%for (AreaDto areaDto : areaList){ %>
					<tr>	
						<td>
							[<%=areaDto.getAreaNo() %>]<%=areaDto.getAreaName() %>
						</td>
						<td>
						<%for(ClientDto adminNormalDto : adminNormalList){ %>
							<%if(roleDao.isAdmin(adminNormalDto.getClientNo(), areaDto.getAreaNo())){ %>
								<a href="rolePartialDetail.jsp?rolePartialClientNo=<%=adminNormalDto.getClientNo()%>&rolePartialAreaNo=<%=areaDto.getAreaNo()%>">[<%=adminNormalDto.getClientNo() %>]<%=adminNormalDto.getClientName() %>[<%=adminNormalDto.getClientId() %>]</a>
							<%} %>
						<%} %>
						</td>
					</tr>
				<%} %>
				<%} else if(isAdmin || clientDto.getClientType().equals("전체관리자")){%>
					<tr>	
						<td>
							[<%=areaDao.detail(areaNo).getAreaNo() %>]<%=areaDao.detail(areaNo).getAreaName() %>
						</td>
						<td>
							<%for(ClientDto adminNormalDto : adminNormalList){ %>
								<%if(roleDao.isAdmin(adminNormalDto.getClientNo(), areaNo)){ %>
									<a href="rolePartialDetail.jsp?rolePartialClientNo=<%=adminNormalDto.getClientNo()%>&rolePartialAreaNo=<%=areaNo%>">[<%=adminNormalDto.getClientNo() %>]<%=adminNormalDto.getClientName() %>[<%=adminNormalDto.getClientId() %>]</a>
								<%} %>
							<%} %>
						</td>
					</tr>
				<%}else{ %>
					<tr>
						<td colspan="2"><span>해당 지점에 대한 관리자 권한이 없습니다</span></td>
					</tr>
				<%} %>
			</tbody>
		</table>
	</div>

	<%if(areaNo == 0){ %>
	<div class="text-center pagination">
	<%if(startBlock > 1){ %>
		<a href="rolePartialList.jsp?pageNo=<%=startBlock - 1 %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%}%>
				" class="move-link">이전</a>
		<%} %>
		<%for(int i = startBlock ; i <= endBlock ; i++){ %>
			<%if(i == pageNo){ %>
				<a href="rolePartialList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%} %>
				" class="on"><%=i %></a>
			<%}else{ %>
				<a href="rolePartialList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%} %>
				"><%=i %></a>
			<%} %>
		<%} %>
		<%if(endBlock < lastBlock){ %>
		<a href="rolePartialList.jsp?pageNo=<%=endBlock + 1 %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%}%>
				""class="move-link">다음</a>
		<%} %>
	</div>
	
	<div class="row text-center">
		<form action="rolePartialList.jsp" method="post">
			<input type="hidden" value="1" name="pageNo">
			<input type="text" class="text-search-form" name="search" id="search"  required autocomplete="off">
			<input type="submit" class="form-btn form-btn-inline" value="검색">
		</form>
	</div>
	<%} %>
	
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>