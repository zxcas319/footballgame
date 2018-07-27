<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/main.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js" /></script>
	<title>Web Game FG - Team Setting</title>
</head>
<body>
<script type="text/javascript">
$(document).ready(function(){
	$.ajax({
        type : "POST"
        , url : "/fg/start/getTeamInfo.do"
        , data : {}
        , success : function(data) {
        	$("#team_class").text(data.grade);
        	$("#team_money").text(data.money);
        }
        , error : function(e) {
        	console.log(e.result);
        }
    });

	$("body").on("mouseover",".left_sub_menu",function(){
		$(this).show();
	});

	$("body").on("mouseout",".left_sub_menu",function(){
		$(this).hide();
	});

	$("body").on("mouseover",".left_sub_menu p",function(){
		$(this).css("color","red");
	});

	$("body").on("mouseout",".left_sub_menu p",function(){
		$(this).css("color","black");
	});

	$("body").on("click",".left_sub_menu p",function(){
		alert($(this).text());
	});
	
	$(".left_menu").on("mouseover",function(){
		var _this = $(this);
		_this.children(".left_main_menu").css("background-color","silver");
		_this.children(".left_main_menu").css("border-bottom","1px solid");
		_this.children(".left_sub_menu").show();
	});
	
	$(".left_menu").on("mouseout",function(){
		var _this = $(this);
		_this.children(".left_main_menu").css("background-color","white");
		_this.children(".left_main_menu").css("border-bottom","0px");
		_this.children(".left_sub_menu").hide();
	});
	
	$(".main_banner").on("click", function(){
		var form = $("#send_form");
		form.attr('method', 'post');
		form.attr('action', "/fg/start/mainPage.do");
		form.submit();
	});
	
	$("#start_game").on("click",function(){
		alert("start_game");
	});
	
	$("#team_setting").on("click",function(){
		var form = $("#send_form");
		form.attr('method', 'post');
		form.attr('action', "/fg/manage/teamSetting.do");
		form.submit();
	});
	
	$("#move_market").on("click",function(){
		var form = $("#send_form");
		form.attr('method', 'post');
		form.attr('action', "/fg/transfer/transferPage.do");
		form.submit();
	});
	
	$("#league_record").on("click",function(){
		alert("league_record");
	});

	$("body").on("click","#player_list tr",function(){
		var _this = $(this);
		var player_key = _this.data("key");
		_this.css("background-color","lightgray");
		$.ajax({
			type : "POST"
			, url : "/fg/transfer/getPlayerInfo.do"
			, data : {
				send_key : player_key
			}
			, success : function(data) {
				console.log(data);
				var html = "";
				html += "<tr>";
				html += "<td><b>이름</b></td>";
				html += "<td colspan='3'>"+data.name+"</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>포지션</b></td>";
				html += "<td>"+data.player_position+"</td>";
				html += "<td><b>추천포지션</b></td>";
				html += "<td>"+data.position_detail+"</td>";
				html += "</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>등급</b></td>";
				html += "<td>"+data.grade+"</td>";
				html += "<td><b>나이</b></td>";
				html += "<td>"+data.age+"</td>";
				html += "</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>키</b></td>";
				html += "<td>"+data.height+"</td>";
				html += "<td><b>몸무게</b></td>";
				html += "<td>"+data.weight+"</td>";
				html += "</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>속력</b></td>";
				html += "<td>"+data.speed+"</td>";
				html += "<td><b>가속도</b></td>";
				html += "<td>"+data.acc+"</td>";
				html += "</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>킥</b></td>";
				html += "<td>"+data.kick+"</td>";
				html += "<td><b>체력</b></td>";
				html += "<td>"+data.health+"</td>";
				html += "</td>";
				html += "</tr>";

				html += "<tr>";
				html += "<td><b>몸싸움</b></td>";
				html += "<td>"+data.struggle+"</td>";
				html += "<td><b>시야</b></td>";
				html += "<td>"+data.eyesight+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>슬라이딩 태클</b></td>";
   				html += "<td>"+data.sliding_tackle+"</td>";
   				html += "<td><b>스탠딩 태클</b></td>";
   				html += "<td>"+data.standing_tackle+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>핸들링</b></td>";
   				html += "<td>"+data.handling+"</td>";
   				html += "<td><b>반사신경</b></td>";
   				html += "<td>"+data.reflex+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>다이빙</b></td>";
   				html += "<td>"+data.diving+"</td>";
   				html += "<td><b>롱패스</b></td>";
   				html += "<td>"+data.long_pass+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>숏패스</b></td>";
   				html += "<td>"+data.short_pass+"</td>";
   				html += "<td><b>헤딩</b></td>";
   				html += "<td>"+data.heading+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>점프</b></td>";
   				html += "<td>"+data.jump+"</td>";
   				html += "<td><b>개인기</b></td>";
   				html += "<td>"+data.skill+"</td>";
   				html += "</td>";
   				html += "</tr>";

				html += "<tr>";
				html += "<td><b>컨트롤</b></td>";
				html += "<td>"+data.controll+"</td>";
				html += "<td><b>크로스</b></td>";
				html += "<td>"+data.cross_stat+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>슛 정확도</b></td>";
   				html += "<td>"+data.shoot_accuracy+"</td>";
   				html += "<td><b>침착성</b></td>";
   				html += "<td>"+data.restlessness+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>유연성</b></td>";
   				html += "<td>"+data.flexibility+"</td>";
   				html += "<td><b>위치선정</b></td>";
   				html += "<td>"+data.positioning+"</td>";
   				html += "</td>";
   				html += "</tr>";

   				html += "<tr>";
   				html += "<td><b>액션</b></td>";
   				html += "<td>"+data.action_stat+"</td>";
   				html += "<td id='transfer_bt' data-key='"+data.player_key+"' colspan='2'>이적</td>";
   				html += "</tr>";

				$("#player_detail").empty();
				$("#player_detail").append(html);
				$("#player_detail td").css("border", "1px solid");
				$("#player_detail td").css("text-align", "center");
				$("#player_detail td:first-child").css("background-color", "aqua");
				$("#player_detail td:nth-child(3)").css("background-color", "aqua");
           }
           , error : function(e) {
              console.log(e.result);
           }
		});
   });
	
	$("body").on("click", "#transfer_bt", function(){
		var _this = $(this);
		var player_key = _this.data("key");
		$.ajax({
			type : "POST"
			, url : "/fg/transfer/insertTransfer.do"
			, data : {
				player_key : player_key
			}
			, success : function(data) {
				
			}
			, error : function(e) {
               console.log(e.result);
            }
 		});
	})
});
</script>
<form id="send_form"></form>
<div class='main_page_html'>
	<table class='main_table'>
		<tr>
			<td class='main_banner' rowspan='2' colspan='3'>main</td>
			<td class='top_txt'>가치</td>
			<td class='top_val' id='team_money'>1,000</td>
		</tr>
		<tr>
			<td class='top_txt'>등급</td>
			<td class='top_val' id='team_class'>S</td>
		</tr>
		<tr>
			<td class='left_menu'>
				<div class="left_main_menu" id='start_game'>1.경기시작</div>
				<div class='left_sub_menu'>
					<p>- test1</p>
					<p>- test2</p>
					<p>- test3</p>
					<p>- test4</p>
				</div>
			</td>
			<td rowspan='5' colspan='4' class='content_window' style='height: 750px;'>
				<table class='content_table' style='height: 750px;'>
					<tr class='content_tr'>
						<td class="content_700">
							<table style='width: 100%; height: 100%'>
								<colgroup>
									<col width='40%' />
									<col width='20%' />
									<col width='20%' />
									<col width='20%' />
								</colgroup>
								<thead>
									<tr>
										<th>Name</th>
										<th>Position</th>
										<th>Age</th>
										<th>Overall</th>
									</tr>
								</thead>
								<tbody id="player_list">
								<c:forEach var='player' items='${player_list}' varStatus='i'>
								<tr data-key='${player.player_key }' data-valid='0'>
									<td class='player_name'>${player.name }</td>
									<td class='player_position'>${player.player_position }</td>
									<td class='player_age'>${player.age }</td>
									<td class='player_overall'>${player.overall }</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
						</td>
						<td class="content_700">
							<table style='width: 100%; height: 100%'>
								<colgroup>
									<col width='25%' />
									<col width='25%' />
									<col width='25%' />
									<col width='25%' />
								</colgroup>
								<tbody id="player_detail">
								</tbody>
							</table>
						</td>
					</tr>
					<tr>
						<td class='notice_window' colspan='3'>notice</td>
					</tr>
				</table>
			</td>
		</tr>
		<tr>
			<td class='left_menu'>
				<div class="left_main_menu" id='team_setting'>2.구단 관리</div>
				<div class='left_sub_menu'>
					<p>- test1</p>
					<p>- test2</p>
					<p>- test3</p>
					<p>- test4</p>
				</div>
			</td>
		</tr>
		<tr>
			<td class='left_menu'>
				<div class="left_main_menu" id='move_market'>3.이적 시장</div>
				<div class='left_sub_menu'>
					<p>- test1</p>
					<p>- test2</p>
					<p>- test3</p>
					<p>- test4</p>
				</div>
			</td>
		</tr>
		<tr>
			<td class='left_menu'>
				<div class="left_main_menu" id='league_record'>4.리그 기록</div>
				<div class='left_sub_menu'>
					<p>- test1</p>
					<p>- test2</p>
					<p>- test3</p>
					<p>- test4</p>
				</div>
			</td>
		</tr>
		<tr>
			<td class='left_blank'>5</td>
		</tr>
	</table>
</div>
</body>
</html>