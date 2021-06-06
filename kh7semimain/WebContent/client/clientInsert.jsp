<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
%>

<style>
	th {
		width:15%;
	}
</style>

<jsp:include page="/client/clientSidebar.jsp">
	<jsp:param value="회원가입" name="title" />
</jsp:include>

	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">회원가입</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 로그인/회원가입 > 회원가입</span>
			</div>
		</div>
		
		<div>
			<form action="insert.kh" method="post">
				<table class="table table-border table-hover board-table">
					<tbody>
						<tr>
							<th>아이디</th>
							<td>
								<input type="text" name="clientId" class="login-form" required>
							</td>
						</tr>
						
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="clientPw" class="login-form" required>
							</td>
						</tr>
						
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="clientName" class="login-form" required>
							</td>
						</tr>
						
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="clientEmail" class="login-form" required>
							</td>
						</tr>
						
						<tr>
							<th>휴대폰번호</th>
							<td>
								<input type="text" name="clientPhone" class="login-form" required>
							</td>
						</tr>
					</tbody>
				</table>
				
				<div class="row text-center">
					<input type="submit" class="board-btn" value="가입하기">
					<a href="<%=root %>/index.jsp" class="link-btn">취소</a>
				</div>
			</form>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>