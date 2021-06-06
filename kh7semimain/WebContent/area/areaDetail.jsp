<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");

	String root = request.getContextPath();

	int areaNo = Integer.parseInt(request.getParameter("areaNo"));
	AreaDao areaDao = new AreaDao();
	AreaDto areaDto = areaDao.detail(areaNo);
	
	String title = "지점 정보";
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 목표 : 삭제버튼을 누르면 확인창 출력 후 확인을 누르면 전송
	$(function(){
		$("#areaDeleteBtn").click(function(){
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (choice) {
				return true;
			} else {
				return false;
			}
		});
	});
</script>


	<div class="main">
	
		<div class="header">
			<div class="row">
				<span class="title">지점 정보</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 전체관리자 > 지점 정보</span>
			</div>
		</div>
		
		<div class="row">
			<form action="areaEdit.kh" method="post">
				<input type=hidden name="areaNo" required value="<%=areaDto.getAreaNo()%>">
				<div class="row">
					<label>지점명 : </label><input type="text" name="areaName" required
					value = "<%=areaDto.getAreaName()%>">
				</div>
				<div class="row">
					<label>지점 위치 : </label><input type="text" name="areaLocation" required
					value = "<%=areaDto.getAreaLocation()%>">
				</div>
				<div class="row">
					<label>지점 전화번호 : </label><input type="text" name="areaCall" required
					value = "<%=areaDto.getAreaCall()%>">
				</div>
				<div class="row">
					<input class="board-btn" type="submit" value="수정">
				</form>
					<button class="board-btn"><a class="btn-text" href="areaList.jsp">취소</a></button>
					<button class="board-btn" id="areaDeleteBtn"><a class="btn-text" href="areaDelete.kh?areaNo=<%=areaDto.getAreaNo() %>">삭제</a></button>
				</div>
			</div>
		
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>