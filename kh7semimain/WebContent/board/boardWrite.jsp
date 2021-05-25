<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<jsp:include page="/template/header.jsp"></jsp:include>
    
<h1>글쓰기</h1>

<div class="container-800">
	<form action="boardWrite.kh" method="post">
		<!-- 클릭할 때 게시판 번호 값을 가져와야 함.. -->
		<input type="hidden" name="boardTypeNo" value="">
		<input type="hidden" name="clientNo" value="">
		<table>
			<tbody>
				<tr>
					<th class="text-left" style="background-color:lightgray;">제목</th>
					<td>
						<input type="text" name="boardTitle" class="form-input" style="width:750px">
					</td>
				</tr>
					
				<!-- 작성자 이름 가운데 *처리해서 가져오기 -->
				<tr>
					<th class="text-left" style="background-color:lightgray;">작성자</th>
					<td>
						<p>작성자 이름 불러오기</p>
					</td>
				</tr>
				
				<tr>
					<th class="text-left" style="background-color:lightgray;">내용</th>
					<td>
						<textarea name="boardField" rows="15" class="text-right form-input"></textarea>
					</td>
				</tr>
			</tbody>
		</table>

		<div class="row">
			<button class="link-btn">등록</button>
			<a href="boardList.jsp" class="link-btn">목록</a>
		</div>
	</form>
</div>

<jsp:include page="/template/footer.jsp"></jsp:include>