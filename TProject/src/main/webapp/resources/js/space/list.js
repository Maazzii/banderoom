
	function searchLiked() {
		if (liked == 0) {
			liked = 1;
			$("input[name=liked]").val(1);
			$(".liked-button img").attr("src", "/banderoom/images/heart-filled.png");
		} else {
			liked = 0;
			$("input[name=liked]").val(0);
			$(".liked-button img").attr("src", "/banderoom/images/heart-empty.png");
		}
	}
	
	function addList() {
		if (loading || allLoaded) {
			return;
		}
		
		var loadingDiv = $('<div class="spinner-border" role="status"></div>');
		$('#wrapper').append(loadingDiv);
		
		loading = true;
		page++;
		var searchData = 'page=' + page + '&';
		
		if (searchParam == 1) {
			searchData += $('form#search-form').serialize();
		}
		
		$.ajax({
			type: "get",
			url: "addlist.do",
			data: searchData,
			success: function(data) {
				
				var html = $("<div>").html(data);
				var spacecol = $(html).find(".spacecol");
				
				$(spacecol).css("opacity", "0%");
				
				$(".spacerow").append(spacecol);
				
				$(spacecol).animate({opacity: "100%"}, 200);
				
				if (spacecol.length < 12) {
					
					allLoaded = true;
				}
				
				drawMap();
				$(loadingDiv).remove();
				loading = false;
				
				
			}
		})
	}
	
	$(function() {
		
		
		window.onscroll = function(e) {
			if ((window.innerHeight + window.scrollY) >= document.body.offsetHeight) {
				addList();
			}
		}
		
		$.ajax({
			type: "get",
			url: "getlocations.do",
			success: function(data) {
				locations = data;
				var addr1 = [];
				
				for (var i = 0; i < data.length ; i++) {
					addr1[i] = data[i].addr1;
				}
				
				addr1 = addr1.filter((v, i) => addr1.indexOf(v) === i);
				
				$("#addr1-loading").remove();
				
				for (var i = 0; i < addr1.length ; i++) {
					var html = "<option>" + addr1[i] + "</option>"
					$("#addr1").append(html);
				}
				

				$("select[name=addr1]").val(param.addr1);
				
				if ($("select[name=addr1]").val() != '') {
					showAddr2();
				}
				
				$("select[name=addr2]").val(param.addr2);
				$("select[name=type]").val(param.type);
				$("input[name=name]").val(param.name);
				$("select[name=orderType]").val(orderType);
				if (liked == 1) {
					$("input[name=liked]").val(1);
					$(".liked-button img").attr("src", "/banderoom/images/heart-filled.png");
				} else {
					$("input[name=liked]").val(0);
					$(".liked-button img").attr("src", "/banderoom/images/heart-empty.png");
				}

				drawMap();
			}
		})
		

		
	})
	
	function showAddr2() {
		
		
		if ($("#addr1").val() == "") {
			$("#addr2").css("display", "none");
			$("#addr2").val("");
			return;
		}
		
		$("#addr2").children().each(function() {
			$(this).remove();
		});
	
		
		$("#addr2").append("<option value=''>?????? ?????????</option>")	;
		
		for (var i = 0; i < locations.length; i++) {
			if (locations[i].addr1 == $("#addr1").val()) {
				var html = "<option>" + locations[i].addr2 + "</option>";
				$("#addr2").append(html);
			}
		}
		$("#addr2").css("display", "block");
		
	}

	var mapContainer;
	
	function drawMap() {
		
		$("#map").children().remove();
		
		var level = 9;
		
		if ($("select[name=addr1]").val() != '') {
			level = 6;
		}
	
		mapContainer = document.getElementById('map'), // ????????? ????????? div 
		    mapOption = {
		        center: new kakao.maps.LatLng(33.450701, 126.570667), // ????????? ????????????
		        level: level // ????????? ?????? ??????
		    };  
		
		// ????????? ???????????????    
		var map = new kakao.maps.Map(mapContainer, mapOption); 
		

		// ?????? ????????? ??????????????? ?????? ????????? ????????? ??? ?????? ???????????? ???????????? ???????????????
		var mapTypeControl = new kakao.maps.MapTypeControl();

		// ????????? ???????????? ???????????? ???????????? ???????????????
		// kakao.maps.ControlPosition??? ???????????? ????????? ????????? ??????????????? TOPRIGHT??? ????????? ?????? ???????????????
		map.addControl(mapTypeControl, kakao.maps.ControlPosition.TOPRIGHT);

		// ?????? ?????? ????????? ????????? ??? ??????  ??? ???????????? ???????????????
		var zoomControl = new kakao.maps.ZoomControl();
		map.addControl(zoomControl, kakao.maps.ControlPosition.RIGHT);
		
		
		// ??????-?????? ?????? ????????? ???????????????
		var geocoder = new kakao.maps.services.Geocoder();
		
		$(".spacebox").each(function(idx, item) {
			

			geocoder.addressSearch($(item).children('input[name=address]').val(), function(result, status) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		
		        // ??????????????? ?????? ????????? ????????? ???????????????
		        var marker = new kakao.maps.Marker({
		            map: map,
		            position: coords
		        });
		
		        // ?????????????????? ????????? ?????? ????????? ???????????????
		        var infowindow = new kakao.maps.InfoWindow({
		            content: '<div class="map-popup" onclick="location.href=\'details.do?idx=' + $(item).children('input[name=idx]').val() + '\'">' + $(item).find('.space-name').text() + '</div>'
		        });
		        infowindow.open(map, marker);
		
			});
			
		})
		
		
		// ????????? ????????? ???????????????
    
		if ($("select[name=addr1]").val() != "") {
			myAddress = $("select[name=addr1]").val() + " " + $("select[name=addr2]").val();
		}
		
		geocoder.addressSearch(myAddress, function(result, status) {
		
		    // ??????????????? ????????? ??????????????? 
		     if (status === kakao.maps.services.Status.OK) {

		        var coords = new kakao.maps.LatLng(result[0].y, result[0].x);
		        
		        // ????????? ????????? ??????????????? ?????? ????????? ??????????????????
		        setTimeout(function() {
			        map.setCenter(coords);
		        }, 500)
		    } 
		});

	}
	
	function showMap() {
		//$("#map").children().remove();
	    //drawMap();
		$("#mapBackOveray").css("visibility", "visible");
		$("#mapBackOveray").animate({opacity: "100%"}, 200);
    // ????????? ????????? ??????????????? ?????? ????????? ??????????????????
	}
	
	function closeMap() {
		$("#mapBackOveray").animate({opacity: "0%"}, 200);
		setTimeout(() => {
			$("#mapBackOveray").css("visibility", "hidden");			
		}, 200);
	}