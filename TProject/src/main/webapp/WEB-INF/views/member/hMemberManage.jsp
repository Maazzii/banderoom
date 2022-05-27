<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>Insert title here</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<style>
table{
	width:100%;
	text-align: center;
}
tr{
	border-bottom: 1px solid lightgray;
	height:40px;
}
#page-nav, #app-page-nav {
	border-top: 1px solid lightgray;
	width: 100%;
	height: 80px;
	display: flex;
	justify-content: center;
	align-items: center;
}
.page-nav-button {
	width: 40px;
	height: 40px;
	border-radius: 20px;
	margin: 7.5px;
	box-shadow: 0px 0px 5px rgba(0,0,0,0.2);
	display: flex;
	justify-content: center;
	align-items: center;
}
.page-nav-button:not(.current-page) {
	cursor: pointer;
}
.page-nav-button.current-page {
	background-color: #fbe6b2;
	font-weight: bold;
}
#title{
	height: 50px;
    font-size: 18px;
    font-weight: bold;
}
.detail{
	width:45px;
	height:30px;
	box-shadow: 0px 0px 3px rgb(0 0 0 / 20%);
	font-size:14px;
}
.accent-button{
	width:60px;
}
.form-select{
    margin-bottom:10px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
    width: 140px;
}
.form-control{
	margin-right:6px;
	width:200px;
	height: 35px;
	border-radius:17.5px;
	border: none;
    box-shadow: 0px 0px 5px rgb(0 0 0 / 20%);
}
select[name=searchField]{
	width:100px;
}

</style>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			일반회원 관리
		</div>
		<div id="page-content">
			
			<form action="reportedMember.do" id="search-form">
				<input type="hidden" name="search" value="1">
				<div class="d-flex justify-content-between">
					<div>
						<select class="form-select form-select-sm" name="sort" onchange="$('#search-form').submit()">
							<option value="all">전체</option>
							<option value="normal">일반회원 보기</option>
							<option value="block">차단회원 보기</option>
						</select>
					</div>
					<div class="d-flex">
						<select class="form-select form-select-sm" name="searchField">
							<option value="nickname">닉네임</option>
						</select>&nbsp;
						<input class="form-control form-control-sm" type="text" name="searchWord" placeholder="검색어를 입력해주세요.">
						<button type="submit" class="normal-button accent-button">검색</button> &nbsp;
					</div>
				</div>
			</form>
			<div class="inner-box reglist-box">
				<div id="reglist">
					<table>
						<tr id="title">
							<td style="width:10%;">회원번호</td>
							<td style="width:20%;">닉네임</td>
							<td>이메일</td>
							<td>사업자등록번호</td>
							<td style="width:20%;">구분</td>
							<td style="width:10%;"></td>
						</tr>
						<c:forEach var="hMember" items="${hMember}">
						<tr>
							<td>${hMember.mIdx}</td>
							<td>${hMember.nickname}</td>
							<td>${hMember.email}</td>
							<td>${hMember.brn}</td>
							<td>
								<c:if test="${hMember.auth == 0}">일반</c:if>
								<c:if test="${hMember.auth == 1}">차단</c:if>
							</td>
							<td>
								<button class="normal-button detail">상세</button>
							</td>
						</tr>
						</c:forEach>
					</table>
				</div>
			</div>
			
			<div id="page-nav"><!-- 페이지 시작 -->					
				<c:if test="${PagingUtil.lastPage < 6}">
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == PagingUtil.nowPage}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
				</c:if>
				<c:if test="${PagingUtil.lastPage > 5}">
					<c:if test="${PagingUtil.startPage > 5}">
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=1'">1</div>
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.startPage - 1}'">◀</div>
					</c:if>
					
					<c:forEach var="i" begin="${PagingUtil.startPage}" end="${PagingUtil.endPage}">
						<c:choose>
							<c:when test="${i == 1}">
								<div class="page-nav-button current-page">${i}</div>
							</c:when>
							<c:otherwise>
								<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${i}'">${i}</div>
							</c:otherwise>
						</c:choose>
					</c:forEach>
					
					<c:if test="${PagingUtil.endPage < PagingUtil.lastPage}">
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.endPage + 1}">▶</div>
						<div class="page-nav-button" onclick="location.href='reportedMember.do?search=${param.search}&sort=${param.sort}&searchField=${param.searchField}&searchWord=${param.searchWord}&page=${PagingUtil.lastPage}">${PagingUtil.lastPage}</div>
					</c:if>
				</c:if>
			</div>
			
			
			
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 -->
		<div>
			위까지는 틀이고 밑에는 요소 공통사항
			<br><br><br>
			버튼 세로 크기 수정시 border-radius도 수정해야함<br>
			<br>
			<button class="normal-button">버튼</button> 
			일반 버튼 (button class="normal-button") (버튼이 여러개 줄줄이 배치될 시 하나만 강조 컬러 넣을것)<br><br>
			<button class="normal-button accent-button">버튼</button> 강조 버튼 (button class="normal-button accent-button")<br><br>
			<br><br><br>
			내부 박스 틀과 예시
			<div class="inner-box">
				<div class="inner-box-content">
				박스에 들어갈 내용
				</div>
				<div class="inner-box-button-wrap">
					<button class="normal-button">일반버튼</button>
					<button class="normal-button accent-button" style="margin-left: 15px;">강조버튼</button>
				</div>
			</div>
			<br><br>
		</div>
		<!-- 여기까지 -->
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>