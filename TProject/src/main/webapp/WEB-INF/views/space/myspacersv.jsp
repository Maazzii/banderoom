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
<title>공간 예약 내역</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link href="<%=request.getContextPath() %>/css/air-datepicker/datepicker.min.css" rel="stylesheet" type="text/css" media="all">
<!-- Air datepicker css -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.js"></script> <!-- Air datepicker js -->
<script src="<%=request.getContextPath() %>/js/air-datepicker/datepicker.ko.js"></script> <!-- 달력 한글 추가를 위해 커스텀 -->

<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/myspacersv.css">
<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<script>
	
	$(function() {
		if (${param.dateRange != null || param.dateAll != null}) {
			if (${param.dateAll == null}) {
				$("select[name=dateType]").val('${param.dateType}');
			}			
			var div = document.getElementById("scroll-here");
			div.scrollIntoView();
		}
	})
	
	var currentPage = 1;
	var startPage = ${startPage};
	var endPage = ${endPage};
	var lastPage = ${lastPage};
	var dateType = "";
	var dateRange = "";
	
	if (${param.dateType != null}) {
		dateType = "${param.dateType}";
	}
	if (${param.dateRange != null}) {
		dateRange = "${param.dateRange}";
	}
	
	var spaceIdx = "${param.idx}";
	

</script>	

<script src="<%=request.getContextPath() %>/js/space/myspacersv.js"></script>
</head>
<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<div id="page-title">
			공간 예약 내역
		</div>
		<div id="page-content">
			<div class="big-title">
			<div id="scroll-here"></div>
				예약 내역
			</div>
			<div class="filters-wrap">
				<form class="search-form" action="myspacersv.do">
					<input type="hidden" name="idx" value="${param.idx}">
					<select name="dateType" class="form-select normal-button">
						<option value="resDate">예약일</option>
						<option value="startDate">공간 사용일</option>
					</select>
					<input class="datepicker-here dateInput" name="dateRange"
						data-language="ko" data-range="true" data-multiple-dates-separator=" ~ "
						type="text" id="dateRange" autocomplete="false" placeholder="기간 선택" value="${param.dateRange}" readonly>
					<button type="button" class="normal-button dateInput-button" onclick="location.href='myspacersv.do?idx=${param.idx}&dateAll=1'">전체보기</button>
					<button class="normal-button accent-button dateInput-button">검색</button>
				</form>
			</div>
			<div>
				<div class="inner-box past-rsv-box">
					<div id="past-rsv">
					<c:forEach var="rsvVO" items="${pastRsv}">
						<div class="past-rsv-wrap">
							<div class="past-rsv-info-wrap">
								<div class="past-rsv-name">${gmVOList.get(rsvVO.getResIdx()).getName()}</div>
								<div class="past-rsv-info">
									<div class="past-rsv-info-items">
										<div class="small-title">공간 사용일</div>
										<div class="small-content">
											<fmt:formatDate value="${rsvVO.startDate}" pattern="yyyy/MM/dd H시~"/>
											<fmt:formatDate value="${rsvVO.endDate}" pattern="k시"/>, ${rsvVO.rsvHours}시간
										</div>
									</div>&nbsp;&nbsp;
									<div class="past-rsv-info-items">
										<div class="small-title">예약일</div>
										<div class="small-content">
											<fmt:formatDate value="${rsvVO.resDate}" pattern="yyyy/MM/dd"/>
										</div>
									</div>
								</div>
								<div class="past-rsv-info">
									<div class="past-rsv-info-items">
										<div class="small-title">연락처</div>
										<div class="small-content">${gmVOList.get(rsvVO.resIdx).tel}</div>
									</div>&nbsp;&nbsp;
									<div class="past-rsv-info-items">
										<div class="small-title">이용료</div>
										<div class="small-content">
											<fmt:formatNumber value="${rsvVO.cost}" pattern="#,###" />원
										</div>
									</div>&nbsp;&nbsp;
								</div>
							</div>
							<div class="past-rsv-buttons">
								<c:if test="${rsvVO.rsvStatus == 1}">
									<span class="cancelled">취소됨</span>
								</c:if>
								<button class="normal-button" onclick="location.href='rsvdetails.do?resIdx=${rsvVO.resIdx}'">예약 상세</button>
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
										<div class="page-nav-button" onclick="loadMyRsv(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
						</c:if>
						<c:if test="${lastPage > 5}">
							<c:if test="${startPage > 5}">
								<div class="page-nav-button" onclick="loadMyRsv(1)">1</div>
								<div class="page-nav-button" onclick="loadMyRsv(${startPage - 1})">◀</div>
							</c:if>
							
							<c:forEach var="i" begin="${startPage}" end="${endPage}">
								<c:choose>
									<c:when test="${i == param.page}">
										<div class="page-nav-button current-page">${i}</div>
									</c:when>
									<c:otherwise>
										<div class="page-nav-button" onclick="loadMyRsv(${i})">${i}</div>
									</c:otherwise>
								</c:choose>
							</c:forEach>
							
							<c:if test="${endPage < lastPage}">
								<div class="page-nav-button" onclick="loadMyRsv(${endPage + 1})">▶</div>
								<div class="page-nav-button" onclick="loadMyRsv(${lastPage})">${lastPage}</div>
							</c:if>
						</c:if>
					</div>
				</div>
			</div>
			
			
		</div>
		
		<!-- 여기까지 틀이고 밑에는 요소 공통사항 
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
	
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="$(this).parent().css('visibility', 'hidden')"></div>
		<div id="map"></div>
	</div>
	
	<c:import url="/footer.do" />
</body>
</html>