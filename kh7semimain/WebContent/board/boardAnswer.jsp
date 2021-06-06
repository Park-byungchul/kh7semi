<%@page import="library.beans.AreaDao"%>
<%@page import="library.beans.AreaDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.ClientDto"%>
<%@page import="library.beans.ClientDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%
	request.setCharacterEncoding("UTF-8");

	int boardNo = Integer.parseInt(request.getParameter("boardNo"));

	Integer clientNo = (Integer)session.getAttribute("clientNo");

	ClientDao clientDao = new ClientDao();
	ClientDto clientDto = clientDao.get(clientNo);
	
	String root = request.getContextPath();
	
	String title = "답변하기";
%>
    
<jsp:include page="/board/boardMenuSidebar.jsp">
	<jsp:param value="<%=title%>" name="title"/>
</jsp:include>

<style>
	th {
		width:15%;
	}
</style>

<script src="https://code.jquery.com/jquery-3.6.0.js"></script>

<script>
	// 높이 자동 설정
	function resize(obj) {
			obj.style.height = "1px";
			obj.style.height = (12+obj.scrollHeight)+"px";
	}
</script>

<div class="main">
	<div class="header">
		<div class="row">
			<span class="title">질문 답변</span>
		</div>
				
		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root %>"><img alt="home" src="<%=root %>/image/home.png"></a> > 열린 공간 > 질문 답변</span>
		</div>
	</div>
	
	<form action="boardAnswer.kh" method="post">
		<input type="hidden" name="boardNo" value="<%=boardNo%>">
		<table class="table table-border table-hover board-table">
			<tbody>
				<tr>
					<th>작성자</th>
					<td>
						<p><%=clientDto.getClientName()%></p>
					</td>
				</tr>
				
				<tr>
					<th>내용</th>
					<td>
						<textarea name="answerContent" rows="15" maxlength="4000" class="board-write-area" onkeydown="resize(this)" onkeyup="resize(this)"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row text-right">
			<button class="board-btn">등록</button>
			<a href="qnaDetail.jsp?boardNo=<%=boardNo %>" class="link-btn">취소</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>