<%@page import="java.util.List"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	AreaDao areaDao = new AreaDao();
	List<AreaDto> areaList = areaDao.list();
%>
	</article>
		</div>
		<footer>
		<hr>
		<span>개인정보처리방침 | 이메일무단수집거부</span><br>
		<span>이용한 api : kakao map geocoder / book search open api</span><hr>
		<div class="float-container">
			<div class="left">
				<h1 class="text-left">KH메인도서관</h1>
			</div>
			<div class="left text-left">
			<%for(AreaDto areaDto : areaList) {%>
				<label><%=areaDto.getAreaName()%> : <%=areaDto.getAreaLocation()%> | ☎<%=areaDto.getAreaCall()%></label><br>
			<%} %>
			</div>	
		</div>
			<h5>KH정보도서관 &copy;</h5>
<!-- 			<h5>KHAcademy 취업반 수업자료 &copy; </h5> -->
<!-- 			<hr> -->
<%-- 				세션 ID: <%=session.getId()%> --%>
<%-- 				회원 번호 : <%=session.getAttribute("clientNo")%> --%>
<!-- 				<br> -->
<%-- 				지점 번호 : <%=session.getAttribute("areaNo")%> --%>
		</footer>
	</main>
</body>
</html>