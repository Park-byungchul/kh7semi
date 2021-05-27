<%@page import="library.beans.AreaDto"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int areaNo = Integer.parseInt(request.getParameter("areaNo"));
	AreaDao areaDao = new AreaDao();
	AreaDto areaDto = areaDao.detail(areaNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

	<h2>관리자 메뉴</h2>
	<ul>
		<li><a href="<%=request.getContextPath() %>/client/clientList.jsp">회원목록</a></li>
		<li><a href="<%=request.getContextPath() %>/area/areaList.jsp">지점목록</a></li>
	</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>

		<div class="row text-left">
			<h2>지점 정보</h2>
		</div>
		
		<div class="row">
				<div class="row">
					<label>지점명 : </label><span><%=areaDto.getAreaName() %></span>
				</div>
				<div class="row">
					<label>지점 위치 : </label><input type="text" name="areaLocation">
				</div>
				<div class="row">
					<label>지점 전화번호 : </label><input type="text" name="areaCall">
				</div>
				<div class="row">
					<input type="submit" value="등록">
				</div>
			</form>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>