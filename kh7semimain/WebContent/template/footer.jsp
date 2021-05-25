<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	// 테스트를 위하여 세션에 들어있는 정보들을 확인하는 작업을 수행
	// 1. 세션의 고유 번호 (Session ID)
	// 2. 세션의 회원 번호 (session.getAttribute("memberNo"))
%>

		</section>
		
		<footer>
			<h5>KHAcademy 취업반 수업자료 &copy; </h5>
			<hr>
				세션 ID: <%=session.getId()%>
				회원 번호 : <%=session.getAttribute("clientNo")%>
		</footer>
	</main>
</body>
</html>