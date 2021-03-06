<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
<link rel="shortcut icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<link rel="icon" href="<%=request.getContextPath() %>/images/favicon.ico" type="image/x-icon">
<script src="<%=request.getContextPath() %>/js/jquery-3.6.0.min.js"></script>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>포인트 내역</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link href="<%=request.getContextPath() %>/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/mypoint.css">

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<script>
	
	var currentPage = 1;
	var startPage = ${startPage};
	var endPage = ${endPage};
	var lastPage = ${lastPage};
	var dateRange = "";
	
	if (${param.dateRange != null}) {
		dateRange = "${param.dateRange}";
	}
	
</script>
<script src="<%=request.getContextPath() %>/js/space/mypoint.js"></script>

</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			포인트 내역
		</div>
		<div id="page-content">
			<div class="point-title-wrap">
				<div class="point-info inner-box">
					<div class="small-title">현재 포인트</div>
					<div class="total-point">
						<fmt:formatNumber value="${login.point}" pattern="#,###" />
					</div>
				</div>
				<div class="filters-wrap">
					<form action="mypoint.do">
						<input class="datepicker-here dateInput" name="dateRange"
							data-language="ko" data-range="true" data-multiple-dates-separator=" ~ "
							type="text" id="dateRange" autocomplete="false" placeholder="기간 선택" value="${param.dateRange}" readonly>
						<button type="button" class="normal-button dateInput-button" onclick="location.href='mypoint.do'">전체보기</button>
						<button class="normal-button accent-button dateInput-button">검색</button>
					</form>
				</div>
			</div>
			<div id="point-box" class="inner-box">
				<div id="point-wrap">
					<c:forEach var="pointVO" items="${pointVO}">
					<div class="elements-wrap">
						<div class="point-content-wrap">
							<div class="point-content">
								<a href="rsvdetails.do?resIdx=${pointVO.resIdx}">${pointVO.content}</a>
							</div>
							<div class="point-resDate">
								<fmt:formatDate value="${pointVO.resDate}" pattern="yyyy.MM.dd HH:mm:ss"/>
							</div>
						</div>
						<div class="point-amount-wrap point-display">
						<c:choose>
							<c:when test="${pointVO.amount > 0}">
								<div class="small-title">획득</div>
								<div class="point-amount acheieved">
								  <fmt:formatNumber value="${pointVO.amount}" pattern="#,###" />
								</div>
							</c:when>
							<c:otherwise>
								<div class="small-title">사용</div>
								<div class="point-amount used">
								  <fmt:formatNumber value="${pointVO.amount}" pattern="#,###" />
								</div>
							</c:otherwise>
						</c:choose>
						</div>
						<div class="point-balance-wrap point-display">
							<div class="small-title">잔액</div>
							<div class="point-amount balance">
							  <fmt:formatNumber value="${pointVO.balance}" pattern="#,###" />
							</div>
						</div>
					</div>
					</c:forEach>
				</div>
				<div id="page-nav">
					<c:if test="${lastPage < 6}">
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == 1}">
									<div class="page-nav-button current-page">${i}</div>
								</c:when>
								<c:otherwise>
									<div class="page-nav-button" onclick="loadMyPoint(${i})">${i}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
					</c:if>
					<c:if test="${lastPage > 5}">
						<c:if test="${startPage > 5}">
							<div class="page-nav-button" onclick="loadMyPoint(1)">1</div>
							<div class="page-nav-button" onclick="loadMyPoint(${startPage - 1})">◀</div>
						</c:if>
						
						<c:forEach var="i" begin="${startPage}" end="${endPage}">
							<c:choose>
								<c:when test="${i == param.page}">
									<div class="page-nav-button current-page">${i}</div>
								</c:when>
								<c:otherwise>
									<div class="page-nav-button" onclick="loadMyPoint(${i})">${i}</div>
								</c:otherwise>
							</c:choose>
						</c:forEach>
						
						<c:if test="${endPage < lastPage}">
							<div class="page-nav-button" onclick="loadMyPoint(${endPage + 1})">▶</div>&nbsp;
							<div class="page-nav-button" onclick="loadMyPoint(${lastPage})">${lastPage}</div>&nbsp;
						</c:if>
					</c:if>
				</div>
			</div>
		</div>
		
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>