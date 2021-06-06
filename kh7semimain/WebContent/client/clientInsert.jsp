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

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	$(function(){
		var ck = [/^[a-zA-Z0-9]{8,20}$/, /^[a-zA-Z0-9!@#$]{8,20}$/, /^[가-힣]{2,7}$/,/^.*@.*\..*$/ , /^010-[0-9]{4}-[0-9]{4}$/];
		
		$(".board-btn").click(function(evt){
			$(".login-form").each(function(index, data){
				if(!ck[index].test($(data).val())){
					$(data).next("span").text("잘못된 형식입니다.");
					$(data).next("span").css("color", "red");
					$(data).next("span").css("font-size", "10px");
					$(data).next("span").css("font-weight", "bold");
					$(data).focus();
					evt.preventDefault();
					return false;
				} else{
					$(data).next("span").text("");
				}
			});
		});
	});
</script>

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
								<input type="text" name="clientId" class="login-form" required placeholder="아이디는 8~20자의 영문자, 숫자로 작성하세요"><span></span>
							</td>
						</tr>
						
						<tr>
							<th>비밀번호</th>
							<td>
								<input type="password" name="clientPw" class="login-form" required placeholder="비밀번호는 8~20자의 영문자, 숫자, 특수문자(!@#$)로 작성하세요"><span></span>
							</td>
						</tr>
						
						<tr>
							<th>이름</th>
							<td>
								<input type="text" name="clientName" class="login-form" required placeholder="이름은 2~7자의 한글로 작성하세요"><span></span>
							</td>
						</tr>
						
						<tr>
							<th>이메일</th>
							<td>
								<input type="text" name="clientEmail" class="login-form" required placeholder="sample@sample.sample의 형태로 작성하세요"><span></span>
							</td>
						</tr>
						
						<tr>
							<th>휴대폰번호</th>
							<td>
								<input type="text" name="clientPhone" class="login-form" required placeholder="휴대폰 번호는 010-xxxx-xxxx의 형태로 작성하세요"><span></span>
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