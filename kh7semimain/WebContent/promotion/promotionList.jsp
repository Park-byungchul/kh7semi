<%@page import="library.beans.PromotionInfoDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.PromotionInfoDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
AreaDao areaDao = new AreaDao();
int areaNo;
try{
	areaNo = (int)session.getAttribute("areaNo");
}
catch (Exception e){
	areaNo = 0;
}

PromotionInfoDao promotionInfoDao = new PromotionInfoDao();
List<PromotionInfoDto> list = promotionInfoDao.list();

String title = "배너 목록";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>

<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title %>" name="title"/>
</jsp:include>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		$("#promotionDeleteBtn").click(function(evt) {
			var choice = window.confirm("정말 삭제하시겠습니까?");
			if (!choice) {
				evt.preventDefault();
			}
		});
	});
</script>

<div class="main">
		
			<div class="header">
				<div class="row">
					<span class="title">배너 목록</span>
				</div>
				
				<div class="row">
					<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 권한관리자 > 배너 목록</span>
				</div>
			</div>

		<div class="row text-right">
			<button><a href="<%=root %>/promotion/promotionInsert.jsp">배너 등록</a></button>
		</div>

<%for(PromotionInfoDto promotionInfoDto : list){ %>

	<%if(promotionInfoDto.getFileNo() > 0){ %>
		<img src="promotionFile.kh?fileNo=<%=promotionInfoDto.getFileNo() %>"  style="max-width: 200px; height:auto;">
		<a href="promotionFile.kh?fileNo=<%=promotionInfoDto.getFileNo() %>">다운로드</a>
		<a id="promotionDeleteBtn" href="promotionDelete.kh?promotionNo=<%=promotionInfoDto.getPromotionNo()%>">삭제</a>
		<h3><%=promotionInfoDto.getAreaNo() %></h3>
	<%} %>

<%} %>

<jsp:include page="/template/footer.jsp"></jsp:include>