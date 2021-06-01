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
request.setCharacterEncoding("UTF-8");
RoleAreaDao roleAreaDao = new RoleAreaDao();
ClientDao clientDao = new ClientDao();
List<ClientDto> adminList = clientDao.adminPermmisionList();
AreaDao areaDao = new AreaDao();
List<AreaDto> areaList = areaDao.list();

int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

String title = "권한수정";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

int roleClientNo = Integer.parseInt(request.getParameter("roleClientNo"));
int roleAreaNo = Integer.parseInt(request.getParameter("roleAreaNo"));
RoleAreaDto roleAreaDto = roleAreaDao.get(roleClientNo, roleAreaNo);
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$("#roleDeleteBtn").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
		
		$("#roleClient").val("<%=roleAreaDto.getClientNo()%>");
		$("#roleArea").val("<%=roleAreaDto.getAreaNo()%>");
	});
</script>

	<div class="row text-left">
		<h2>권한 수정</h2>
	</div>

	<div class="row">
			<form action="roleEdit.kh" method="post">
				<input type="hidden" value="<%=roleClientNo%>" name="roleClientNo">
				<input type="hidden" value="<%=roleAreaNo%>" name="roleAreaNo">
				<div class="row">
					<label>관리자 이름 : </label>
					<select name="clientNo" required id="roleClient">
						<option value="">관리자를 선택하세요</option>
						<%for(ClientDto clientDto : adminList){ %>
							<option value="<%=clientDto.getClientNo() %>">[<%=clientDto.getClientNo() %>]<%=clientDto.getClientName() %>[<%=clientDto.getClientId() %>]</option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<label>지점 이름 : </label>
					<select name="areaNo" required id="roleArea">
						<option value="">지점을 선택하세요</option>
						<%for(AreaDto areaDto : areaList){ %>
							<option value="<%=areaDto.getAreaNo()%>">[<%=areaDto.getAreaNo() %>]<%=areaDto.getAreaName() %></option>
						<%} %>
					</select>
				</div>
				<div class="row">
					<input type="submit" value="수정">
				</form>
					<button><a href="roleList.jsp">취소</a></button>
					<button id="roleDeleteBtn"><a href="roleDelete.kh?roleClientNo=<%=roleAreaDto.getClientNo() %>&roleAreaNo=<%=roleAreaDto.getAreaNo()%>">삭제</a></button>
				</div>
			
		</div>


<jsp:include page="/template/footer.jsp"></jsp:include>