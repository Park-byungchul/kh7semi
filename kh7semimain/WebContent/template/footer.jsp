<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	String pageNow = request.getRequestURI();
	String root = request.getContextPath();
	
	AreaDao areaDao = new AreaDao();
	List<AreaDto> areaList = areaDao.list();
	
	int areaNo;
	try{
		areaNo = (int)session.getAttribute("areaNo");
	}
	catch (Exception e){
		areaNo = 0;
	}
	
	String currentAreaName;
	if(areaNo > 0){
		currentAreaName = areaDao.detail(areaNo).getAreaName();
	} else {
		currentAreaName = "메인 도서관";
	}
%>
<script>
$(function(){
	
	<%if(areaNo != 0){%>
		$("#currentArea-footer").text("<%=currentAreaName %>");
	<%}%>
	
	$(".activeAreaMenu-footer").click(function(){
		var areaMenu = $(".areaMenu-footer");
		if(areaMenu.css("display") == "block"){
			areaMenu.css("display", "none");
		} else{
			areaMenu.css("display", "block");
		}
	});
	
});	
</script>
	</article>
		</div>
		<footer>
		<div class="float-container" style="border-top:1px solid gray;border-bottom:1px solid gray;padding:1rem">
			<div class="left">
				<a>개인정보처리방침 </a> | <a> 이메일무단수집거부</a><br>
				<span>이용한 api : kakao map geocoder / book search open api</span>
			</div>
			<div class="right">
				<button class="activeAreaMenu-footer">
					<span id="currentArea-footer">도서관 바로가기 ▼</span>
				</button>
				
				<ul class="areaMenu-footer">
						<%for (AreaDto areaDto : areaList){ %>
							<li onclick="location.href='<%=root %>/areaSelect.kh?areaNo=<%=areaDto.getAreaNo()%>&back=<%=pageNow%>'"><%=areaDto.getAreaName() %></li>
						<%} %>
				</ul>
			</div>
		</div>
		<div class="float-container">
			<div class="left" style="padding:3rem;">
				<h1 style="margin-top:0;">KH메인도서관</h1>
			</div>
			<div class="left text-left" style="margin-top:50px;">
			<%for(AreaDto areaDto : areaList) {%>
				<label><%=areaDto.getAreaName()%> : <%=areaDto.getAreaLocation()%> | ☎<%=areaDto.getAreaCall()%></label><br>
			<%} %>
			</div>	
		</div>
		<div class="row text-center">
			<h5>KH정보도서관 &copy;</h5>
		</div>
<!-- 			<hr> -->
<%-- 				세션 ID: <%=session.getId()%> --%>
<%-- 				회원 번호 : <%=session.getAttribute("clientNo")%> --%>
<!-- 				<br> -->
<%-- 				지점 번호 : <%=session.getAttribute("areaNo")%> --%>
		</footer>
	</main>
</body>
</html>