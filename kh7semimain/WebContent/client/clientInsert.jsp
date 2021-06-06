<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	request.setCharacterEncoding("UTF-8");
	String root = request.getContextPath();
%>

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
		
		<div class="section">
			<form action="insert.kh" method="post">
				<table class="login-wrap">
					<tbody>
						<tr>
							<td>
								<div>
									<input type="text" name="clientId" required placeholder="아이디">
								</div>
								<div>
									<input type="password" name="clientPw" required placeholder="비밀번호">
								</div>
								<div>
									<input type="text" name="clientName" required placeholder="이름">
								</div>
								<div>
									<input type="text" name="clientEmail" required placeholder="이메일">
								</div>
								<div>
									<input type="text" name="clientPhone" required placeholder="휴대폰번호">
								</div>
								<div>
									<input type="submit" value="가입하기" >
								</div>
							</td>
						</tr>
					</tbody>
				</table>
			</form>
		</div>
	</div>

<jsp:include page="/template/footer.jsp"></jsp:include>