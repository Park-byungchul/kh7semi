<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");

String search = request.getParameter("search");
boolean isSearch = search != null;

String root = request.getContextPath();
ClientDao clientDao = new ClientDao();

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "회원 목록";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

////////// 페이지네이션
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
	
	List<ClientDto> list;
	int count;
	if(!isSearch){
		list = clientDao.list(strNum, endNum);
		count = clientDao.getCount();
	} else{
		list = clientDao.search(search, strNum, endNum);
		count = clientDao.getCount(search);
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

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$(".clientDelete").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
	});
</script>

<%if(isSearch){ %>

<script>
	$(function(){
		$("#search").val("<%=search %>");
	});
</script>

<%} %>
	<div class="row text-left">
		<h2>회원 목록</h2>
	</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="15%">아이디</th>
					<th width="20%">이름</th>
					<th width="20%">이메일</th>
					<th width="20%">대출가능일</th>
					<th width="12%">등급</th>
					<th width="13%">관리</th>
				</tr>
			</thead>
			<tbody>
				<%for (ClientDto clientDto : list) { %>
				<tr>
					<td><a href=<%=root%>/client/clientInfo.jsp?clientNo=<%=clientDto.getClientNo()%>><%=clientDto.getClientId()%></a></td>
					<td><%=clientDto.getClientName()%></td>
					<td><%=clientDto.getClientEmail()%></td>
					<td><%=clientDto.getClientPossible()%></td>
					<td><%=clientDto.getClientType()%></td>
					<td>
					<button><a href="clientEdit.jsp?clientNo=<%=clientDto.getClientNo()%>&pageNo=<%=pageNo %>
						<%if(isSearch){ %>
							&search=<%=search %>
						<%}%>
					">수정</a></button>
					<button class="clientDelete"><a href="clientDelete.kh?clientNo=<%=clientDto.getClientNo()%>">삭제</a></button>
					</td>
				</tr>
				<%}%>
			</tbody>
		</table>
	</div>
	
	<div class="text-center pagination">
	<%if(startBlock > 1){ %>
		<a class="move-link">이전</a>
		<%} %>
		<%for(int i = startBlock ; i <= endBlock ; i++){ %>
			<%if(i == pageNo){ %>
				<a href="clientList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%} %>
				" class="on"><%=i %></a>
			<%}else{ %>
				<a href="clientList.jsp?pageNo=<%=i %>
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
		<form action="clientList.jsp" method="post">
			<input type="hidden" value="1" name="pageNo">
			<input type="text" name="search" id="search">
			<input type="submit" value="검색">
		</form>
	</div>
	
<jsp:include page="/template/footer.jsp"></jsp:include>