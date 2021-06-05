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
String title = "찾아오는길";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>
<style>
	.content {
		text-align:left;
		padding: 0px 0px 0px 30px;
	}
	span {
	    margin-left: 35px;
	}
</style>
<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>도서관 소개</h2>
<ul>
	<li><a href="<%=root%>/location/location.jsp">찾아오는길</a></li>
	<li><a href="<%=root%>/dataStatus/dataStatus.jsp">자료현황</a></li>
	<li><a href="useInfo.jsp">이용 안내</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>

<div class="container-800">
	<h2>이용 안내</h2>
		<h3>이용시간 및 휴관일 안내</h3>
			<table class="table table-border table-hover text-center">
				<tr>
					<th>도서관</th>
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
