$(function() {
	$(".pagination > a").click(function() {
		var pageNo = $(this).text();
		
		if(pageNo == "이전") {
			pageNo = parseInt($(".pagination > a :not(.move-link)").first().text()) - 1;
			$("input[name=pageNo]").val(pageNo);
			$(".search-form").submit();//강제 submit 발생
		}
		else if(pageNo == "다음") {
			pageNo = parseInt($(".pagination > a:not(.move-link)").last().text()) + 1;
			$("input[name=pageNo]").val(pageNo);
			$(".search-form").submit();//강제 submit 발생
		}
		else {
			$("input[name=pageNo]").val(pageNo);
			$(".search-form").submit();//강제 submit 발생
		}
	});
});