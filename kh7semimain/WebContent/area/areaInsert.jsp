<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="/template/header.jsp"></jsp:include>

<jsp:include page="/template/sidebar1.jsp"></jsp:include>

	<h2>관리자 메뉴</h2>
	<ul>
		<li><a href="<%=request.getContextPath() %>/client/clientList.jsp">회원목록</a></li>
		<li><a href="<%=request.getContextPath() %>/area/areaList.jsp">지점목록</a></li>
	</ul>

<jsp:include page="/template/sidebar2.jsp"></jsp:include>

		<div class="row text-left">
			<h2>지점 등록</h2>
		</div>
		
		<div class="row">
			<form action="areaInsert.kh" method="post">
				<div class="row">
					<label>지점명 : </label><input type="text" name="areaName" required>
				</div>
				<div class="row">
					<label>지점 위치 : </label><input type="text" name="areaLocation" required>
				</div>
				<div class="row">
					<label>지점 전화번호 : </label><input type="text" name="areaCall" required>
				</div>
				<div class="row">
					<input type="submit" value="등록">
				</div>
			</form>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>