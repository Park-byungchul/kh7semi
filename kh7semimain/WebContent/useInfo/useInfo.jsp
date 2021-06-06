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
String title = "이용 안내";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>
<style>
	.content {
		text-align:left;
		padding: 0px 0px 0px 30px;
	}
</style>

<jsp:include page="/location/locationSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

	<div class="header">
		<div class="row">
			<span class="title">이용 안내</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 도서관 소개 > 이용 안내</span>
		</div>
	</div>
<div class="container-800">
	
		<h3>이용시간 및 휴관일 안내</h3>
			<table class="table table-border table-hover text-center">
				<tr>
					<th style="width:150px;">도서관</th>
					<th style="width:450px;">자료실/열람실 이용시간</th>
					<th style="width:250px;">휴관일</th>
				</tr>
				<tr>
				
					<td>강남도서관</td>
					<td class="content">
						<span>※ 자료실 : (월~금)9시~21시 / (토~일)9시~17시</span><br>
						<span>※ 학습실 : (월~금)9시~21시 / (토~일)9시~17시</span>	
					</td>
					<td class="content">
						<span>※ 매월 마지막 월요일</span><br>
						<span>※ 법정공휴일, 근로자의날</span>	
					</td>
				</tr>
				<tr>	
					<td>종로도서관</td>
					<td class="content">
						<span>※ 자료실 : (월~금)9시~19시30분 / (토~일)9시~17시</span><br>
						<span>※ 학습실 : (월~금)9시~19시30분 / (토~일)9시~17시</span>	
					</td>
					<td class="content">
						<span>※ 매월 마지막 월요일</span><br>
						<span>※ 법정공휴일, 근로자의날</span>	
					</td>
				</tr>
				<tr>	
					<td>당산도서관</td>
					<td class="content">
						<span>※ 자료실 : (월~금)9시~21시 / (토~일)9시~17시</span><br>
						<span>※ 학습실 : (월~금)9시~21시 / (토~일)9시~17시</span>	
					</td>
					<td class="content">
						<span>※ 매월 마지막 월요일</span><br>
						<span>※ 법정공휴일, 근로자의날</span>	
					</td>			
				</tr>
			</table>	
</div>


<jsp:include page="/template/footer.jsp"></jsp:include>
