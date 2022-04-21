<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
	.freeBoard-list{
		width:70%;
		align:center;
	}
	.freeBoard-list-table{
		width:100%;
	}
	td{
		text-align:center;
	}
</style>
</head>
<body>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			자유게시판
		</div>
		<div id="page-content" style="align:center;">
			<input type="text">
			<button class="accent-button" style="margin-left: 15px;">검색</button>
		<div class="freeBoard-list">
			<table class="freeBoard-list-table">
				<tr>
					<th width="10%">번호</th>
					<th width="40%">제목</th>
					<th width="20%">작성자</th>
					<th width="10%">작성일</th>
					<th width="10%">조회수</th>
					<th width="10%">추천수</th>
				</tr>
				<tr>
					<td>1</td>
					<td>2</td>
					<td>3</td>
					<td>4</td>
					<td>5</td>
					<td>6</td>
				</tr>
			</table>
		</div>
		</div>
		
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 -->
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button>버튼</button> 
			일반 버튼 (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="accent-button">버튼</button> 강조 버튼 (button class="accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button>일반버튼</button>
					<button class="accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
</body>
</html>