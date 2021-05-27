<%@page import="library.beans.GetBookDto"%>
<%@page import="library.beans.GetBookDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	int getBookNo = Integer.parseInt(request.getParameter("getBookNo"));
	GetBookDao getBookDao = new GetBookDao();
	GetBookDto getBookDto = getBookDao.get(getBookNo);
%>

<jsp:include page="/template/header.jsp"></jsp:include>

	<div class="container-800">
		<div class="row text-left">
			<h2>지점 정보</h2>
		</div>
		
		<div class="row">
				<div class="row">
					<label>입고번호 : </label><span><%=getBookDto.getGetBookNo() %></span>
				</div>
				<div class="row">
					<label>책번호 : </label><input type="text" name="bookIsbn">
				</div>
				<div class="row">
					<label>지점번호 : </label><input type="text" name="areaNo">
				</div>
				<div class="row">
					<label>입고일자 : </label><input type="text" name="getBookDate">
				</div>
				<div class="row">
					<label>상태 : </label><input type="text" name="getBookStatus">
				</div>
				<div class="row">
					<input type="submit" value="등록">
				</div>
			</form>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>