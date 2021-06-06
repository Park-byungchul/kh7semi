<%@page import="library.beans.PromotionInfoDto"%>
<%@page import="java.util.List"%>
<%@page import="library.beans.PromotionInfoDao"%>
<%@page import="library.beans.AreaDao"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
request.setCharacterEncoding("UTF-8");
String root = request.getContextPath();

AreaDao areaDao = new AreaDao();
int areaNo;
try {
	areaNo = (int) session.getAttribute("areaNo");
} catch (Exception e) {
	areaNo = 0;
}
String title = "배너 등록";
if (areaNo > 0) {
	title += " : " + areaDao.detail(areaNo).getAreaName();
}
%>
<jsp:include page="/admin/adminMenuSidebar.jsp">
	<jsp:param value="<%=title%>" name="title" />
</jsp:include>
<style>

.input-file [type="file"] {
	position: absolute;
	width: 1px;
	height: 1px;
	padding: 0;
	margin: -1px;
	overflow: hidden;
	clip: rect(0, 0, 0, 0);
	border: 0 none;
}

.input-file .file-name {
	width: 70%;
	background: #f5f5f5;
	height: 34px;
	line-height: 26px;
	text-indent: 5px;
	border: 1px solid #bbb;
}
</style>
<script>
	$(function() {
		var $fileBox = null;
		$(function() {
			init();
		})
		function init() {
			$fileBox = $('.input-file');
			fileLoad();
		}
		function fileLoad() {
			$.each($fileBox, function(idx) {
				var $this = $fileBox.eq(idx), 
						$btnUpload = $this.find('[type="file"]'), 
						$label = $this.find('.file-label');
				$btnUpload.on('change',function() {
					var $target = $(this), 
					fileName = $target.val(), 
					$fileText = $target.siblings('.file-name');
					$fileText.val(fileName);
				})
			})
		}
	});
</script>
<div class="main" style="min-height: 800px;">

	<div class="header">
		<div class="row">
			<span class="title">배너 등록</span>
		</div>

		<div class="row">
			<span class="path"><a class="imgArea" href="<%=root%>"><img
					alt="home" src="<%=root%>/image/home.png"></a> > 권한관리자 > 배너 등록</span>
		</div>
	</div>
	<form id="promotionInsert" action="promotionInsert.kh" method="post" enctype="multipart/form-data">
		<input type="hidden" name="areaNo" value="<%=areaNo%>">
		<div class="input-file">
			<input type="text" readonly="readonly" class="file-name"> 
			<label for="upload" class="form-btn form-btn-inline" style="font-size:13.3333px;">파일 업로드</label> 
			<input type="file" name="promotionFile" id="upload" class="file-upload">
			<input type="submit" value="등록하기" class="form-btn form-btn-inline">
			<button class="form-btn form-btn-inline">목록으로</button>
		</div>
		
	</form>
</div>
<jsp:include page="/template/footer.jsp"></jsp:include>