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

<title>${spacesVO.name}</title>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/base.css">
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/calendar.css">

<script src="https://cdn.jsdelivr.net/npm/moment@2.29.3/moment.min.js"></script>
<link rel="stylesheet" type="text/css" href="<%=request.getContextPath() %>/css/space/details.css">

	<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=a8d83e76596a6e93d144575566c3d5ae&libraries=services"></script>
	
	<script>
	
	var liked;
	var mIdx = 0;
	var spacesVO = {
			addr1: '${spacesVO.addr1}',
			addr2: '${spacesVO.addr2}',
			address: '${spacesVO.address}',
			addressDetail: '${spacesVO.addressDetail}',
			capacity: ${spacesVO.capacity},
			cost: ${spacesVO.cost},
			hostIdx: ${spacesVO.hostIdx},
			idx: ${spacesVO.idx},
			liked: ${spacesVO.liked},
			name: '${spacesVO.name}',
			regDate: new Date('<fmt:formatDate value="${spacesVO.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />'),
			reviewAvg: ${spacesVO.reviewAvg},
			reviewCnt: ${spacesVO.reviewCnt},
			status: ${spacesVO.status},
			thumb: '${spacesVO.thumb}',
			type: '${spacesVO.type}'
	}
	
	var scoreColor = ${reviewCntAvg.get("avg") * 30};
	
	<c:if test="${login != null}">	//????????? ?????????????????? mIdx = 0 ?????? ?????????
	mIdx = ${login.getmIdx()};
	</c:if>
	
	
	var reviewPage = 1;
	var reviewLastPage = ${reviewLastPage};
	var orderType = "regDateDesc";
	
	
	var qnaCurrentPage = 1;
	var qnaStartPage = ${qnaStartPage};
	var qnaEndPage = ${qnaEndPage};
	var qnaLastPage = ${qnaLastPage};
	
	
	</script>
	
	<script src="<%=request.getContextPath() %>/js/space/details.js"></script>
	
</head>

<body>
<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/js/bootstrap.bundle.min.js" integrity="sha384-ka7Sk0Gln4gmtz2MlQnikT1wXgYsOg+OMhuP+IlRH9sENBO0LRn5q+8nbTov4+1p" crossorigin="anonymous"></script>
	<c:import url="/header.do" />
	<div id="wrapper">
		<c:if test="${spacesVO.getStatus() == 0}">
			<div class="inner-box space-status space-status-waiting">
				<span class="space-status-content">?????? ???????????? ???????????????.</span>
				
				<c:if test="${login.getAuth() == 3}">
				<div class="space-accept-buttons">
					<button class="normal-button" onclick="location.href='refuseSpace.do?idx=${spacesVO.getIdx()}'">?????? ??????</button>
					<button class="normal-button accent-button" onclick="location.href='acceptSpace.do?idx=${spacesVO.getIdx()}'">?????? ??????</button>
				</div>
				</c:if>
				
			</div>
		</c:if>
		<c:if test="${spacesVO.getStatus() == 2}">
			<div class="inner-box space-status space-status-refused">
				<div>
					<span class="space-status-content" style="color: white;">?????? ????????? ???????????????.<br></span>
					<span style="color: white; font-size: 17px;">?????? ??? ?????? ???????????? ???????????????.</span>
				</div>
				
				<c:if test="${spacesVO.getHostIdx() == hlogin.getmIdx()}">
				<div class="space-accept-buttons">
					<button class="normal-button" style="width: 120px;" onclick="location.href='requestaccept.do?idx=${spacesVO.getIdx()}'">?????? ?????????</button>
				</div>
				</c:if>
				
			</div>
		</c:if>
		<c:if test="${spacesVO.getStatus() == 3}">
			<div class="inner-box space-status space-status-deleted">
				<span class="space-status-content" style="color: white;">????????? ???????????????.</span>
			</div>
		</c:if>
		
		<c:if test="${spacesVO.getStatus() != 3}"> <!-- ????????? ????????? ???????????? ???????????? ?????? -->
		
		<div id="page-content">
		<c:if test="${spacePicturesVOs.size() != 0}">
			<div class="inner-box pictures">
				
				<div id="carouselExampleIndicators" class="carousel slide" data-bs-ride="carousel">
				  <div class="carousel-indicators">
				    <button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="0" class="active" aria-current="true" aria-label="Slide 1"></button>
						<c:forEach var="i" begin="1" end="${spacePicturesVOs.size() - 1}">
				    	<button type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide-to="${i}" aria-label="Slide ${i}"></button>
						</c:forEach>
				  </div>
				  <div class="carousel-inner">
				  	<c:forEach var="i" begin="0" end="${spacePicturesVOs.size() - 1}" varStatus="status">
				  		<c:if test="${status.first}">
						    <div class="carousel-item active">
						      <img src="<%=request.getContextPath() %>${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage('<%=request.getContextPath() %>${spacePicturesVOs[i].getSrc()}')">
						    </div>
				  		</c:if>
				  		<c:if test="${!status.first}">
				  			<div class="carousel-item">
						      <img src="<%=request.getContextPath() %>${spacePicturesVOs[i].getSrc()}" class="d-block w-100" onclick="drawImage('<%=request.getContextPath() %>${spacePicturesVOs[i].getSrc()}')">
						    </div>
				  		</c:if>
				    </c:forEach>
				  </div>
				  <button class="carousel-control-prev" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="prev">
				    <span class="carousel-control-prev-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Previous</span>
				  </button>
				  <button class="carousel-control-next" type="button" data-bs-target="#carouselExampleIndicators" data-bs-slide="next">
				    <span class="carousel-control-next-icon" aria-hidden="true"></span>
				    <span class="visually-hidden">Next</span>
				  </button>
				</div>
			</div>
			</c:if>
			
			<div class="title">
				<div class="space-type">
					${spacesVO.getType()}
				</div>
				<div class="space-name">
					<span>${spacesVO.getName()}</span>
					<c:if test="${login != null}">
					<div class="like-space" onclick="likeSpace()">
						<img src="<%=request.getContextPath() %>/images/heart-empty.png">
					</div>
					</c:if>
				</div>
				<div class="address">
					<div class="addressDetail">
						${spacesVO.getAddress()} ${spacesVO.getAddressDetail()}
					</div>
					<button class="normal-button map-button" onclick="showMap()">&nbsp;??????<img src="<%=request.getContextPath() %>/images/map_pin.png" style="height: 20px; margin-left: 0px;"></button>
				</div>
			</div>
			
			<div class="menu">
				<button class="normal-button" onclick="document.querySelector('#scroll-to-info').scrollIntoView({behavior: 'smooth', block: 'center'});">??????</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-review').scrollIntoView({behavior: 'smooth', block: 'center'});">??????</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-qna').scrollIntoView({behavior: 'smooth', block: 'center'});">Q&amp;A</button>
				<button class="normal-button" onclick="document.querySelector('#scroll-to-rsv').scrollIntoView({behavior: 'smooth', block: 'center'});">??????</button>
			</div>
			<div class="container space-content">
				<div class="row">
					<div class="col-sm-8 colleft">
						<div class="inner-box space-info">
							<div class="inner-box-content">
									<div class="space-info-subject">????????????</div>
					
									<div id="scroll-to-info"></div>
			
								
									${spacesVO.getInfo()}
									<div class="space-info-subject">?????? ?????? / ??????</div>
									${spacesVO.getFacility()}
								
									<div class="space-info-subject">????????????</div>
									${spacesVO.getCaution()}
								
							</div>
						</div>
						
						<div class="inner-box space-info">
							<div class="inner-box-content">
								<div class="space-info-subject">?????? ${reviewCntAvg.get("count")}???</div>
								<div id="scroll-to-review"></div>
								
								<c:if test="${reviewCntAvg.get('count') != 0}">
								
								<div class="score-wrap">
									<div class="score-stars">
										<div class="score-color"></div>
										<img src="<%=request.getContextPath() %>/images/score-star.png">
										<img src="<%=request.getContextPath() %>/images/score-star.png">
										<img src="<%=request.getContextPath() %>/images/score-star.png">
										<img src="<%=request.getContextPath() %>/images/score-star.png">
										<img src="<%=request.getContextPath() %>/images/score-star.png">
									</div>
									<div class="score-avg"><fmt:formatNumber value="${reviewCntAvg.get('avg')}" pattern="#.0" /> </div>
								</div>
								<div class="review-orders">
									<button id="regDateDesc" class="normal-button accent-button review-order-button" onclick="loadReview(1, 'regDateDesc')">?????? ?????? ???</button>
									<button id="scoreDesc" class="normal-button review-order-button" onclick="loadReview(1, 'scoreDesc')">?????? ?????? ???</button>
									<button id="scoreAsc" class="normal-button review-order-button" onclick="loadReview(1, 'scoreAsc')">?????? ?????? ???</button>
								</div>
								<div id="reviewList">
								<c:forEach var="review" items="${reviewList}">
									<div class="review-wrap">
										<div class="review-header">
											<div class="review-member">
												<div class="review-profile-img">
													<img src="${review.profileSrc}">
												</div>
												<div class="review-nickname" onclick="profileOpen(${review.mIdx})">
													${review.mNickname}
												</div>
											</div>
											<div class="review-score-wrap">
												<fmt:formatDate value="${review.regDate}" pattern="yyyy.MM.dd HH:mm" />
												<div class="review-score-stars">
													<div class="review-score-color" style="width: ${review.score * 24}px"></div>
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
													<img src="<%=request.getContextPath() %>/images/score-star.png">
												</div>
											</div>
										</div>
										<div class="review-body">
											<div class="review-content">
												${review.content}
											</div>
											<c:if test="${review.pictureSrc != null}">
												<img class="review-thumb" src="<%=request.getContextPath() %>${review.thumbSrc}" onclick="drawImage('<%=request.getContextPath() %>${review.pictureSrc}')">
											</c:if>
										</div>
										<c:if test="${review.mIdx == login.mIdx}">
										<div class="review-footer">
											<button class="normal-button" onclick="updateReview(${review.resIdx})">??????</button>
											<button class="normal-button" onclick="deleteReview(${review.resIdx})">??????</button>
										</div>
										</c:if>
									</div>
								</c:forEach>
								</div>
								
								<div class="review-nav">
									<div class="review-page-prev" onclick="loadReview(1, orderType, this)">
										<img src="<%=request.getContextPath() %>/images/page-first.png">
									</div>
									<div class="review-page-prev" onclick="loadReview((reviewPage - 1), orderType, this)">
										<img src="<%=request.getContextPath() %>/images/page-prev.png">
									</div>
									<div class="review-page-next" onclick="loadReview((reviewPage + 1), orderType, this)">
										<img src="<%=request.getContextPath() %>/images/page-next.png">
									</div>
									<div class="review-page-next" onclick="loadReview(reviewLastPage, orderType, this)">
										<img src="<%=request.getContextPath() %>/images/page-last.png">
									</div>
								</div>
								
								
								</c:if>
							</div>
						</div>
						
						<div class="inner-box space-info">
							<div class="inner-box-content">
								<div class="space-info-subject">Q&amp;A</div>
								<div id="scroll-to-qna"></div>
								
								<div id="qna-list">
									<c:if test="${qnaList.size() == 0}">
									<div>????????? Q&amp;A??? ????????????.</div>
									</c:if>
									<div id="qna-elements">
									<c:forEach var="qnaVO" items="${qnaList}">
									<div class="review-wrap">
										<div class="review-header">
											<div class="review-member">
												<div class="review-profile-img">
													<img src="${qnaVO.profileSrc}">
												</div>
												<div class="review-nickname" onclick="profileOpen(${qnaVO.mIdx})">
													${qnaVO.mNickname}
												</div>
											</div>
											<div class="review-score-wrap">
												<fmt:formatDate value="${qnaVO.regDate}" pattern="yyyy.MM.dd HH:mm" />
											</div>
										</div>
										<div class="review-body">
											<div class="review-content">
												<c:if test="${qnaVO.publicYN == 'N'}">
												<img src="<%=request.getContextPath() %>/images/lock.png" style="margin-bottom: 4px; height: 16px;">
												</c:if>${qnaVO.content}
											</div>
										</div>
										<div class="qna-buttons">
											<div class="qna-answer-button">
												<c:if test="${hlogin.mIdx == spacesVO.hostIdx && qnaVO.answer == null}">
												<button class="normal-button show-answer-button" onclick="qnaAnswer(${qnaVO.qnaIdx}, ${param.idx}, this)">????????????</button>
												</c:if>
											</div>
											<div class="qna-modify-buttons">
												<c:if test="${qnaVO.mIdx == login.mIdx}">
												<button class="normal-button qna-update-button" onclick="qnaUpdate(${qnaVO.qnaIdx}, this)">??????</button>
												<button class="normal-button" onclick="qnaDelete(${qnaVO.qnaIdx})">??????</button>
												</c:if>
											</div>
										</div>
										<c:if test="${qnaVO.answer != null}">
										<div class="qna-answer-wrap">
											<div class="qna-answer-title-wrap">
												<div class="qna-answer-title">
													???????????? ??????
												</div>
												<div class="qna-answer-date">
													<fmt:formatDate value="${qnaVO.answerDate}" pattern="yyyy.MM.dd HH:mm"/>
												</div>
											</div>
											<div class="qna-answer-content">
												<c:if test="${qnaVO.publicYN == 'N'}">
												<img src="<%=request.getContextPath() %>/images/lock.png" style="margin-bottom: 4px; height: 16px;">
												</c:if>${qnaVO.answer}
											</div>
											<c:if test="${hlogin.mIdx == spacesVO.hostIdx}">
											<div class="qna-answer-buttons">
												<button class="normal-button qna-answer-modify-button" onclick="qnaAnswerModify(${qnaVO.qnaIdx}, ${param.idx}, this)">??????</button>
												<button class="normal-button qna-answer-modify-button" onclick="qnaAnswerDelete(${qnaVO.qnaIdx}, ${param.idx})">??????</button>
											</div>
											</c:if>
										</div>
										</c:if>
									</div>
									</c:forEach>
									</div>
								</div>
								
								
								<div id="qna-page-nav">
									<c:if test="${qnaLastPage < 6}">
										<c:forEach var="i" begin="${qnaStartPage}" end="${qnaEndPage}">
											<c:choose>
												<c:when test="${i == 1}">
													<div class="qna-page-nav-button qna-current-page">${i}</div>
												</c:when>
												<c:otherwise>
													<div class="qna-page-nav-button" onclick="qnaList(${i})">${i}</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
									</c:if>
									<c:if test="${qnaLastPage > 5}">
										<c:if test="${qnaStartPage > 5}">
											<div class="qna-page-nav-button" onclick="qnaList(1)">1</div>
											<div class="qna-page-nav-button" onclick="qnaList(${qnaStartPage - 1})">???</div>
										</c:if>
										
										<c:forEach var="i" begin="${qnaStartPage}" end="${qnaEndPage}">
											<c:choose>
												<c:when test="${i == 1}">
													<div class="qna-page-nav-button qna-current-page">${i}</div>
												</c:when>
												<c:otherwise>
													<div class="qna-page-nav-button" onclick="qnaList(${i})">${i}</div>
												</c:otherwise>
											</c:choose>
										</c:forEach>
										
										<c:if test="${qnaEndPage < qnaLastPage}">
											<div class="qna-page-nav-button" onclick="qnaList(${qnaEndPage + 1})">???</div>
											<div class="qna-page-nav-button" onclick="qnaList(${qnaLastPage})">${qnaLastPage}</div>
										</c:if>
									</c:if>
								</div>
								
								
								<c:if test="${login != null}">
									<form id="qna-form">
										<input type="hidden" name="spaceIdx" value="${param.idx}">
										
										<div class="qna-input-wrap">
											<textarea id="qna-textarea" class="qna-textarea" name="content" placeholder="??????????????? ????????? ????????????????"></textarea>
											<div class="qna-input-button-wrap">
												<div class="form-check">
												  <input class="form-check-input" name="privateChecked" type="checkbox" value="1" id="public_check">
												  <label class="form-check-label" for="public_check">
												  	?????????  
												  </label>
												</div>
												<button type="button" class="normal-button accent-button" onclick="qnaQSubmit()">??????</button>
											</div>
										</div>
									</form>
								</c:if>
								
							</div>
						</div>
					</div>
					
					
					<div class="col-sm colright">
						<div class="inner-box space-rsv">
							<div class="inner-box-content">
								<div class="space-info-subject">??????</div>
								<div id="scroll-to-rsv"></div>
								<div class="rsv-info">
									????????? ?????? ???????????? ??? ?????? ???????????????.
								</div>
								<div class="rsv-cal-info">
									<div class="day current today dayex"></div>
									<div class="dayinfo">??????</div>
									<div class="day current rsv-full dayex"></div>
									<div class="dayinfo">?????? ??????</div>
								</div>
								
								<div class="calendar">
									<div class="sec_cal">
									  <div class="cal_nav">
									    <a href="javascript:;" class="nav-btn go-prev">prev</a>
									    <div class="year-month"></div>
									    <a href="javascript:;" class="nav-btn go-next">next</a>
									  </div>
									  <div class="cal_wrap">
									    <div class="days">
									      <div class="day">???</div>
									      <div class="day">???</div>
									      <div class="day">???</div>
									      <div class="day">???</div>
									      <div class="day">???</div>
									      <div class="day">???</div>
									      <div class="day">???</div>
									    </div>
									    <div class="dates"></div>
									  </div>
									</div>
									
									<div id="timeselect">
										<div class="space-rsv-subject">
										?????? ??????
										</div>
										<div id="timetable">
											<c:forEach var="i" begin="9" end="23">
											<div class="timeselector" data-starttime="${i}" data-endtime="${i + 1}"
													onclick="selectTime(this)">
												<c:if test="${i == 9}">0</c:if>${i}??? ~ ${i + 1}???
											</div>
											</c:forEach>
											<div class="timeselector-blank"></div>
										</div>
									</div>
								</div>
								
								<div id="rsv-form-wrap">
									<div class="space-rsv-subject">
										?????? ????????? ??????
									</div> 
									<div id="rsv-date">
									
									</div>
									<div id="rsv-time">
										
									</div>
									<div id="rsv-peopleNum">
										<div class="space-rsv-subject">
											?????? ??????
										</div>
										<div class="peopleNum-buttons-wrap">
											???&nbsp;&nbsp;
											<div class="peopleNum-buttons">
												<button class="peopleNum-button" onclick="changePeopleNum(-1)">-</button>
												<input id="rsv-input-peopleNum" type="number" name="peopleNum" min="1" max="${spacesVO.capacity}" value="1" onchange="checkPeopleNum()">
												<button class="peopleNum-button" onclick="changePeopleNum(1)">+</button>
											</div>
											&nbsp;&nbsp;???
										</div>
									</div>
								</div>
							
								<div class="rsv-costs-wrap">
									<div class="space-rsv-subject">
										????????? ?????????
									</div>					
									<div class="space-cost">
										<span><fmt:formatNumber value="${spacesVO.cost}" pattern="#,###"/></span>
										 ??? / ??????
									</div>
									<div class="space-rsv-subject">
										??? ?????????
									</div>
									<div class="rsv-cost">
										<span>0</span>
										 ??? / ??????
									</div>
								</div>
								
							<c:if test="${login != null}">
								<div class="submit-button-wrap">
									<button class="normal-button accent-button rsv-submit" onclick="rsvSubmit()">????????????</button>
								</div>
							</c:if>
							<c:if test="${login == null}">
								<div class="login-info">
									?????? ????????? ??? ????????? ???????????????.
								</div>
							</c:if>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
				
			<c:if test="${spacesVO.getHostIdx() == hlogin.getmIdx()}">
				<div class="outter-buttons">
					<button type="button" class="normal-button" onclick="deleteSpace()">??????</button>
					<button class="normal-button accent-button" style="margin-left: 20px;" onclick="location.href='update.do?idx=${spacesVO.getIdx()}'">??????</button>
				</div>
			</c:if>
		
		</c:if>
		</div>
		
		
	<div id="imgBackOveray">
		<div id="imgBackground" onclick="closeImage()"></div>
		<div id="img"></div>
	</div>
	
	<div id="mapBackOveray">
		<div id="mapBackground" onclick="closeMap()"></div>
		<div id="map"></div>
	</div>
	
	
	<c:import url="/footer.do" />
</body>
</html>