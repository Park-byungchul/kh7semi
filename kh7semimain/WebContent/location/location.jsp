<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String area_name = request.getParameter("area_name");

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
int geocoderNo = areaNo-1;


String title = "찾아오는길";
if(areaNo > 0){
	title += " : " + areaDao.detail(areaNo).getAreaName();
}

List<AreaDto> areaList = areaDao.list();

%>

<style>
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>
<script>


	$(function(){
		$("#areaName").change(function(){
			var name = $("#areaName").children("option:selected").text();
			$(".library-areaName").text(name);
			this.form.submit();
			//test
		});
			

		
	});
	
</script>


<jsp:include page="/template/header.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

<h2>도서관 소개</h2>
<ul>
	<li><a href="location.jsp">찾아오는길</a></li>
	<li><a href="<%=root%>/dataStatus/dataStatus.jsp">자료현황</a></li>
	<li><a href="<%=root%>/useInfo/useInfo.jsp">이용 안내</a></li>
</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>
<%if(areaNo==0) { %>
<div class="float-container">
	<div class="left" id="map1" style="width:400px;height:400px;margin:20px 20px;display:inline-block;">
	</div>	
	<div class="left">
		<div class="row">
			<h2 class="library-areaName" style="display:inline-block;"><%=areaList.get(1).getAreaName()%></h2>
		</div>
		<div class="row">
			<h3>- 지점 위치</h3>
			<span><%=areaList.get(1).getAreaLocation()%></span>
		</div>
		
		<div class="row">
			<h3>- 전화번호</h3>
			<span><%=areaList.get(1).getAreaCall()%></span>
		</div>
	</div>
	
</div>

<div class="float-container">
	<div class="left" id="map2" style="width:400px;height:400px;margin:20px 20px;display:inline-block;">
	</div>	
	<div class="left">
		<div class="row">
			<h2 class="library-areaName" style="display:inline-block;"><%=areaList.get(2).getAreaName()%></h2>
		</div>
		<div class="row">
			<h3>- 지점 위치</h3>
			<span><%=areaList.get(2).getAreaLocation()%></span>
		</div>
		
		<div class="row">
			<h3>- 전화번호</h3>
			<span><%=areaList.get(2).getAreaCall()%></span>
		</div>
		
	</div>
</div>

<div class="float-container">
	<div class="left" id="map3" style="width:400px;height:400px;margin:20px 20px;display:inline-block;">
	</div>	
	<div class="left">
		<div class="row">
			<h2 class="library-areaName" style="display:inline-block;"><%=areaList.get(3).getAreaName()%></h2>
		</div>
		<div class="row">
			<h3>- 지점 위치</h3>
			<span><%=areaList.get(3).getAreaLocation()%></span>
		</div>
		
		<div class="row">
			<h3>- 전화번호</h3>
			<span><%=areaList.get(3).getAreaCall()%></span>
		</div>
		
	</div>
</div>
<%} else { %>
<div class="float-container">
	<div class="left" id="map" style="width:400px;height:400px;margin:20px 20px;display:inline-block;">
	</div>	
	<div class="left">
		<div class="row">
			<h2 class="library-areaName" style="display:inline-block;"><%=areaList.get(areaNo).getAreaName()%></h2>
		</div>
		<div class="row">
			<h3>- 지점 위치</h3>
			<span><%=areaList.get(areaNo).getAreaLocation()%></span>
		</div>
		
		<div class="row">
			<h3>- 전화번호</h3>
			<span><%=areaList.get(areaNo).getAreaCall()%></span>
		</div>
	</div>
	
</div>
<%} %>
<!-- 카카오 지도 api 스크립트 부분 -->
<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=1038b1ced14e22e17b2cd601ec877523&libraries=services"></script>
<script>
var num = <%=areaNo%>;
if(num == 0) {
	
	var container1 = document.getElementById('map1');
	var container2 = document.getElementById('map2');
	var container3 = document.getElementById('map3');
	var options = {
	center: new kakao.maps.LatLng(33.450701, 126.570667),
	level: 3
	};

	var map1 = new kakao.maps.Map(container1, options);
	var map2 = new kakao.maps.Map(container2, options);
	var map3 = new kakao.maps.Map(container3, options);

	// 주소-좌표 변환 객체를 생성합니다
	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('<%=areaList.get(1).getAreaLocation()%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords1 = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker1 = new kakao.maps.Marker({
            map: map1,
            position: coords1
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=areaList.get(1).getAreaName()%></div>'
        });
        infowindow.open(map1, marker1);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map1.setCenter(coords1);
    } 
}); 	    

geocoder.addressSearch('<%=areaList.get(2).getAreaLocation()%>', function(result, status) {
     if (status === kakao.maps.services.Status.OK) {
        var coords2 = new kakao.maps.LatLng(result[0].y, result[0].x);
       
        var marker2 = new kakao.maps.Marker({
            map: map2,
            position: coords2
        });

        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=areaList.get(2).getAreaName()%></div>'
        });
        infowindow.open(map2, marker2);

        map2.setCenter(coords2);
    } 
});

geocoder.addressSearch('<%=areaList.get(3).getAreaLocation()%>', function(result, status) {

     if (status === kakao.maps.services.Status.OK) {

        var coords3 = new kakao.maps.LatLng(result[0].y, result[0].x);

        var marker3 = new kakao.maps.Marker({
            map: map3,
            position: coords3
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=areaList.get(3).getAreaName()%></div>'
        });
        infowindow.open(map3, marker3);

        map3.setCenter(coords3);
    } 
});
}
else {
	var container = document.getElementById('map');
	var options = {
	center: new kakao.maps.LatLng(33.450701, 126.570667),
	level: 3
	};

	var map = new kakao.maps.Map(container, options);

	var geocoder = new kakao.maps.services.Geocoder();

	// 주소로 좌표를 검색합니다
	geocoder.addressSearch('<%=areaList.get(areaNo).getAreaLocation()%>', function(result, status) {

    // 정상적으로 검색이 완료됐으면 
     if (status === kakao.maps.services.Status.OK) {

        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);

        // 결과값으로 받은 위치를 마커로 표시합니다
        var marker = new kakao.maps.Marker({
            map: map,
            position: coords
        });

        // 인포윈도우로 장소에 대한 설명을 표시합니다
        var infowindow = new kakao.maps.InfoWindow({
            content: '<div style="width:150px;text-align:center;padding:6px 0;"><%=areaList.get(areaNo).getAreaName()%></div>'
        });
        infowindow.open(map, marker);

        // 지도의 중심을 결과값으로 받은 위치로 이동시킵니다
        map.setCenter(coords);
    } 
}); 	  
}
</script>

<jsp:include page="/template/footer.jsp"></jsp:include>