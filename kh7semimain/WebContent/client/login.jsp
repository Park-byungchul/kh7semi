<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();
%>

<jsp:include page="/client/clientSidebar.jsp">
	<jsp:param value="로그인" name="title" />
</jsp:include>


	<div class="main">
		<div class="header">
			<div class="row">
				<span class="title">로그인</span>
			</div>
			
			<div class="row">
				<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 로그인/회원가입 > 로그인</span>
			</div>
		</div>
		
		<div class="section">
			<div class="row text-center">
			
				<form action="login.kh" method="post">
					<table class="table table-border ">
						<tr>
							<td colspan="2">
								<input type="text" name="clientId" placeholder="아이디" class="form-input">
							</td>
							<td rowspan="2">
								<input type="submit" value="로그인" class="form-btn">
							</td>
						</tr>
						<tr>
							<td colspan="2">
								<input type="password" name="clientPw" placeholder="비밀번호" class="form-input">
							</td>
						</tr>
					</table>
				</form>
				
			</div>
		</div>
	</div>
		
<jsp:include page="/template/footer.jsp"></jsp:include>