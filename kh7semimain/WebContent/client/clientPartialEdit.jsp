<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
ClientDao clientDao = new ClientDao();
int clientNo = Integer.parseInt(request.getParameter("clientNo"));
String currentType = clientDao.get(clientNo).getClientType();

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

//rownum의 시작번호(startRow)와 종료번호(endRow)를 계산
int strNum = pageSize * pageNo - (pageSize-1);
int endNum = pageSize * pageNo;

List<ClientDto> list;
int count = clientDao.getCount();
if(!isSearch){
	list = clientDao.partialList(strNum, endNum);
	count = clientDao.getPartialCount();
} else{
	list = clientDao.partialSearch(search, strNum, endNum);
	count = clientDao.getPartialCount(search);
}

int blockSize = 10;
int lastBlock = (count + pageSize - 1) / pageSize;
int startBlock = (pageNo - 1) / blockSize * blockSize + 1;
int endBlock = startBlock + blockSize - 1;

if(endBlock > lastBlock){ // 범위를 벗어나면
endBlock = lastBlock; // 범위를 수정
}

AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "회원 목록";
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$("#clientType").val("<%=currentType%>");
		var currentType = $("#clientType").val();
		
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

	<div class="main">
		
			<div class="header">
				<div class="row">
					<span class="title">회원 목록</span>
				</div>
				
				<div class="row">
					<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 권한관리자 > 회원 목록</span>
				</div>
			</div>

	<div class="row">
		<table class="table table-border table-hover">
			<thead>
				<tr>
					<th width="15%">아이디</th>
					<th width="15%">이름</th>
					<th width="20%">이메일</th>
					<th width="20%">대출가능일</th>
					<th width="13%">등급</th>
					<th width="17%">관리</th>
				</tr>
			</thead>
			<tbody>
				<%
				for (ClientDto clientDto : list) {
				%>
				<%
				boolean isEdit = clientNo == clientDto.getClientNo();
				%>
				<tr>
					<td><%=clientDto.getClientId()%></td>
					<td><%=clientDto.getClientName()%></td>
					<td><%=clientDto.getClientEmail() %></td>
					<td><%=clientDto.getClientPossible() %></td>
					<%
					if (isEdit) {
					%>
					<form action="clientEdit.kh?type=partial" method="post">
						<%if(isSearch){ %>
							<input type="hidden" name="search" value="<%=search %>">
						<%} %>
						<input type="hidden" name="pageNo" value="<%=pageNo %>">
						<input type="hidden" name="clientNo"
							value="<%=clientDto.getClientNo()%>">
						<input type="hidden" name="clientName" 
							value="<%=clientDto.getClientName()%>">
						<input type="hidden" name="clientEmail" 
							value="<%=clientDto.getClientEmail()%>">
						<input type="hidden" name="clientPossible"
							value="<%=clientDto.getClientPossible()%>">
						<td><select id="clientType" name="clientType">
								<option>일반사용자</option>
								<option>일반관리자</option>
						</select></td>
						<td><input type="submit" class="board-btn" value="완료">
						<button class="board-btn"><a class="btn-text"
							href="clientPartialList.jsp?pageNo=<%=pageNo %>
								<%if(isSearch){ %>
									&search=<%=search %>
								<%}%>
							">취소</a></button></td>
					</form>
					<%
					} else {
					%>
						<td><%=clientDto.getClientType()%></td>
						<td>
						<%if(clientDto.getClientType().equals("일반관리자") || clientDto.getClientType().equals("일반사용자")){ %>
						<button class="board-btn"><a class="btn-text" href="clientPartialEdit.jsp?clientNo=<%=clientDto.getClientNo()%>&pageNo=<%=pageNo %>
							<%if(isSearch){ %>
								&search=<%=search %>
							<%} %>
						">수정</a></button>
						<button class="clientDelete board-btn"><a class="btn-text" href="clientDelete.kh?clientNo=<%=clientDto.getClientNo()%>">삭제</a></button>
						<%} %>
						</td>
					<%
					}
					%>
				</tr>
				<%
				}
				%>
			</tbody>
		</table>
	</div>

	<div class="text-center pagination">
	<%if(startBlock > 1){ %>
		<a href="clientPartialList.jsp?pageNo=<%=startBlock - 1 %>
			<%if(isSearch){ %>
				&search=<%=search %>
			<%} %>
		" class="move-link">이전</a>
		<%} %>
		<%for(int i = startBlock ; i <= endBlock ; i++){ %>
			<%if(i == pageNo){ %>
				<a href="clientPartialList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%} %>
				" class="on"><%=i %></a>
			<%}else{ %>
				<a href="clientPartialList.jsp?pageNo=<%=i %>
					<%if(isSearch){ %>
						&search=<%=search %>
					<%} %>
				"><%=i %></a>
			<%} %>
		<%} %>
		<%if(endBlock < lastBlock){ %>
		<a href="clientPartialList.jsp?pageNo=<%=endBlock + 1 %>
			<%if(isSearch){ %>
				&search=<%=search %>
			<%} %>
		" class="move-link">다음</a>
		<%} %>
	</div>
	
	<div class="row text-center">
		<form action="clientPartialList.jsp" method="post">
			<input type="hidden" value="1" name="pageNo">
			<input type="text" class="text-search-form" name="search" id="search"  required autocomplete="off">
			<input type="submit" class="form-btn form-btn-inline" value="검색">
		</form>
	</div>
</div>

</div>
<jsp:include page="/template/footer.jsp"></jsp:include>