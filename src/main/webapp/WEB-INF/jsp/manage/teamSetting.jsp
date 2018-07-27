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
	
	var keep_detail = "";
	var change_position = "";
	var selected_position = ["", "", "", "", "", "", "", "", "", "", ""];
	var sub_player = ["", "", "", "", "", "" ,""];
	
	$(".position_setting td").each(function(){
		var add = $(this).data("position");
		if(add != null && add != "")
			$(".position_select").append("<option value='" + add + "'>" + add + "</option>");
	});
	
	$(".position_select").each(function(){
		var selected = $(this).data("select");
		
		if(selected != null && selected != ""){
			var select_name = $(this).data("name");
			var select_key = $(this).data("key");
			$(this).val(selected).attr("selected", "selected");
			
			refreshMap();
		}
	});
	
	$(".position_select").on("click", function(){
		change_position = $(this).val();
	});
	
	$(".position_select").on("change", function(){
		this_select = $(this).val();
		select_name = $(this).data("name");
		select_key = $(this).data("key");
		
		var result = checkPosition(this_select);
		if(result == "already"){
			alert("Already Selected Position");
			$(this).val("none");
		}
		else if(result == "7"){
			alert("Sub player is Full");
			$(this).val("none");
		}
		else if(result == "11"){
			alert("Player is Full");
			$(this).val("none");
		}
		refreshMap();
	});
	
	$("#player_list tr").on("mouseout", function(){
		$("#detail_info").empty();
		$("#detail_info").append(keep_detail);
	});
	
	$("#player_list tr").on("mouseover", function(){
		$.ajax({
	        type : "POST"
	        , url : "/fg/manage/getPlayerInfoDetail.do"
	        , data : {
	        	player_key : $(this).data("key")
	        }
	        , success : function(data) {
	    		var rtvHtml = "";
	    		rtvHtml += "<table style='width:100%; height:100%'>";
	    		rtvHtml += "<colgroup>";
	    		rtvHtml += "<col width='25%'/>";
	    		rtvHtml += "<col width='25%'/>";
	    		rtvHtml += "<col width='25%'/>";
	    		rtvHtml += "<col width='25%'/>";
	    		rtvHtml += "</colgroup>";
	    		rtvHtml += "<tbody>";
	    		rtvHtml += "<tr>";
				rtvHtml += "<td><b>이름</b></td><td colspan='3'>" + data.name + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
	    		rtvHtml += "<td><b>나이</b></td><td>" + data.age + "</td>";
	    		rtvHtml += "<td><b>주발</b></td><td>" + data.foot + "</td>";
				rtvHtml += "</tr>";
	    		rtvHtml += "<tr>";
				rtvHtml += "<td><b>몸무게</b></td><td>" + data.weight + "</td>";
	    		rtvHtml += "<td><b>키</b></td><td>" + data.height + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>포지션</b></td><td>" + data.player_position + "</td>";
				var detail_position = data.position_detail;
				rtvHtml += "<td><b>추천 포지션</b></td><td>";
				if(detail_position == "0_MF")
					rtvHtml += "" + data.foot + "M";
				else if(detail_position == "1_MF")
					rtvHtml += "CAM";
				else if(detail_position == "2_MF")
					rtvHtml += "CM";
				else if(detail_position == "3_MF")
					rtvHtml += "CDM";
				else if(detail_position == "0_FW")
					rtvHtml += "" + data.foot + "W";
				else if(detail_position == "1_FW")
					rtvHtml += "ST / CF";
				else if(detail_position == "0_DF")
					rtvHtml += "" + data.foot + "B / " + data.foot + "WB";
				else if(detail_position == "1_DF")
					rtvHtml += "CB / SW";
				else if(detail_position == "0_GK")
					rtvHtml += "GK";
				rtvHtml += "" + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>가속도</b></td><td>" + data.acc + "</td>";
				rtvHtml += "<td><b>속도</b></td><td>" + data.speed + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>점프</b></td><td>" + data.jump + "</td>";
				rtvHtml += "<td><b>헤딩</b></td><td>" + data.heading + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>컨트롤</b></td><td>" + data.controll + "</td>";
				rtvHtml += "<td><b>개인기</b></td><td>" + data.skill + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>킥</b></td><td>" + data.kick + "</td>";
				rtvHtml += "<td><b>시야</b></td><td>" + data.eyesight + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>슛 정확도</b></td><td>" + data.shoot_accuracy + "</td>";
				rtvHtml += "<td><b>크로스</b></td><td>" + data.cross_stat + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>짧은 패스</b></td><td>" + data.short_pass + "</td>";
				rtvHtml += "<td><b>롱패스</b></td><td>" + data.long_pass + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>슬라이딩 태클</b></td><td>" + data.sliding_tackle + "</td>";
				rtvHtml += "<td><b>스탠딩 태클</b></td><td>" + data.standing_tackle + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>체력</b></td><td>" + data.health + "</td>";
				rtvHtml += "<td><b>몸싸움</b></td><td>" + data.struggle + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>유연성</b></td><td>" + data.flexibility + "</td>";
				rtvHtml += "<td><b>침착성</b></td><td>" + data.restlessness + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>반사신경</b></td><td>" + data.reflex + "</td>";
				rtvHtml += "<td><b>액션</b></td><td>" + data.action_stat + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>다이빙</b></td><td>" + data.diving + "</td>";
				rtvHtml += "<td><b>핸들링</b></td><td>" + data.handling + "</td>";
				rtvHtml += "</tr>";
				rtvHtml += "<tr>";
				rtvHtml += "<td><b>위치선정</b></td><td>" + data.positioning + "</td>";
				rtvHtml += "</tr>";
	    		rtvHtml += "</tbody>";
	    		rtvHtml += "</table>";

	    		$("#detail_info").empty();
	    		$("#detail_info").append(rtvHtml);
	    		$("#detail_info table td").css("border", "1px solid");
	    		$("#detail_info table td").css("text-align", "center");
	    		$("#detail_info table td:first-child").css("background-color", "aqua");
	    		$("#detail_info table td:nth-child(3)").css("background-color", "aqua");
	        }
	        , error : function(e) {
	        	console.log(e.result);
	        }
	    });
	});
	
	$("#player_list tr").on("click", function(){
		var valid = $(this).data("valid");
		$("#player_list tr").css("background-color", "");
		if(valid == "0"){
			$(this).css("background-color", "lightgray");
			keep_detail = $("#detail_info").html();
			$(this).data("valid", "1");
		}
		else{
			keep_detail = "";
			$(this).data("valid", "0");
		}
	});
	
	$("#save_team_setting").on("click", function(){
		checkPosition("");
		refreshMap();
		if($.inArray("", position_list) != -1){
			alert("Please select the position of 11 players.");
		}
		else if($.inArray("", sub_list) != -1){
			alert("Please select the position of 7 sub players.");
		}
		else{
			var select_position = position_list.join("/") + "/" + sub_list.join("/");
			var player_keys = position_list_key.join("/") + "/" + sub_list_key.join("/");

			console.log(select_position);
			console.log(player_keys);
			$.ajax({
		        type : "POST"
		        , url : "/fg/manage/saveSelectPosition.do"
		        , data : {
		        	player_key : player_keys,
		        	select_position : select_position
		        }
		        , success : function(data) {
		        	alert("Team Setup Complete!!");
		        }
		        , error : function(e) {
		        	console.log(e.result);
		        }
		    });
		}
	});
});

var position_list = ["","","","","","","","","","",""];
var sub_list = ["","","","","","",""];
var position_list_name = ["","","","","","","","","","",""];
var sub_list_name = ["","","","","","",""];
var position_list_key = ["","","","","","","","","","",""];
var sub_list_key = ["","","","","","",""];


function checkPosition(change_position){
	if($.inArray(change_position, sub_list) != -1 || $.inArray(change_position, position_list) != -1)
		return "already";

	var idx = 0;
	var sub_idx = 0;
	
	$(".position_select").each(function(){
		var this_select = $(this).val();
		var this_key = $(this).data("key");
		var this_name = $(this).data("name");
		if(this_select.indexOf("SUB") != -1) {
			sub_idx++;
		}
		else if(this_select != "none"){
			idx++;
		}
	});
	if(idx > 11) return "11";
	if(sub_idx > 7) return "7";
}

function refreshMap() {
	position_list = ["","","","","","","","","","",""];
	sub_list = ["","","","","","",""];
	position_list_name = ["","","","","","","","","","",""];
	sub_list_name = ["","","","","","",""];
	position_list_key = ["","","","","","","","","","",""];
	sub_list_key = ["","","","","","",""];

	var idx = 0;
	var sub_idx = 0;
	
	$(".position_select").each(function(){
		var this_select = $(this).val();
		var this_key = $(this).data("key");
		var this_name = $(this).data("name");
		if(this_select.indexOf("SUB") != -1) {
			sub_list[sub_idx] = this_select;
			sub_list_name[sub_idx] = this_name;
			sub_list_key[sub_idx] = this_key;
			sub_idx++;
		}
		else if(this_select != "none"){
			position_list[idx] = this_select;
			position_list_name[idx] = this_name;
			position_list_key[idx] = this_key;
			idx++;
		}
	});
	
	$(".position_setting td").each(function(){
		var this_position = $(this).data("position");
		var player_idx = $.inArray(this_position, position_list);
		var sub_player_idx = $.inArray(this_position, sub_list);
		if(player_idx != -1){
			$(this).text(position_list_name[player_idx]);
			
		}
		else if(sub_player_idx != -1){
			$(this).text(sub_list_name[sub_player_idx]);
			
		}
		else if(this_position != null){
			$(this).text("");
		}
	});
	
	return true;
}

</script>
<form id='send_form'>
	<input name='position' id='position' type='hidden' value=''>
	<input name='define_match_time' id='define_match_time' type='hidden' value='3'>
	<input name='define_tactical_time' id='define_tactical_time' type='hidden' value='1'>
	<input name='define_break_time' id='define_break_time' type='hidden' value='10'> 
</form>
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
					<!-- content start -->
						<td class='content_400'>
							<table class='position_setting'>
								<colgroup>
									<col width='20%'/>
									<col width='20%'/>
									<col width='20%'/>
									<col width='20%'/>
									<col width='20%'/>
								</colgroup>
								<tbody class='position_map'>
								<tr>
									<td colspan='5' style='width: 400px;border:1px solid;background-color:lightblue;'>Field Player(11)</td>
								</tr>
								<tr>
									<td rowspan='2' style='height: 100px;' data-position='LW'></td>
									<td data-position='LS'></td>
									<td data-position='ST'></td>
									<td data-position='RS'></td>
									<td rowspan='2' style='height: 100px;' data-position='RW'></td>
								</tr>
								<tr>
									<td data-position='LCF'></td>
									<td data-position='CF'></td>
									<td data-position='RCF'></td>
								</tr>
								<tr>
									<td rowspan='3' style='height: 150px;' data-position='LM'></td>
									<td data-position='LCAM'></td>
									<td data-position='CAM'></td>
									<td data-position='RCAM'></td>
									<td rowspan='3' style='height: 150px;' data-position='RM'></td>
								</tr>
								<tr>
									<td data-position='LCM'></td>
									<td data-position='CM'></td>
									<td data-position='RCM'></td>
								</tr>
								<tr>
									<td data-position='LCDM'></td>
									<td data-position='CDM'></td>
									<td data-position='RCDM'></td>
								</tr>
								<tr>
									<td data-position='LWB'></td>
									<td rowspan='2' style='height: 100px;' data-position='LCB'></td>
									<td data-position='CB'></td>
									<td rowspan='2' style='height: 100px;' data-position='RCB'></td>
									<td data-position='RWB'></td>
								</tr>
								<tr>
									<td data-position='LB'></td>
									<td data-position='SW'></td>
									<td data-position='RB'></td>
								</tr>
								<tr>
									<td colspan='5' style='width: 400px;' data-position='GK'></td>
								</tr>
								<tr>
									<td style='width: 400px;border:1px solid;background-color:lightblue;' colspan='5'>SUB(7)</td>
								</tr>
								<tr>
									<td data-position='SUB1'></td>
									<td data-position='SUB2'></td>
									<td data-position='SUB3'></td>
									<td data-position='SUB4'></td>
									<td data-position='SUB5'></td>
								</tr>
								<tr>
									<td data-position='SUB6'></td>
									<td data-position='SUB7'></td>
								</tr>
								<tr>
									<td colspan='5' style='width: 400px;border:1px solid;background-color:silver;' id='save_team_setting'>
										SAVE TEAM SETTING
									</td>
								</tr>
								</tbody>
							</table>
						</td>
						
						<td class='content_500'>
							<table class='player_list_table'>
								<colgroup>
									<col width='15%'/>
									<col width='40%'/>
									<col width='15%'/>
									<col width='15%'/>
									<col width='15%'/>
								</colgroup>
								<thead>
									<tr>
										<th></th>
										<th>Name</th>
										<th>Position</th>
										<th>Age</th>
										<th>Overall</th>
									</tr>
								</thead>
								<tbody id='player_list'>
								<c:forEach var='player' items='${player_list}' varStatus='i'>
								<tr data-key='${player.player_key }' data-valid='0'>
									<td class='player_position'>
										<select class='position_select' data-select='${player.select_position }' data-name='${player.name }' data-key='${player.player_key }'>
										  <option value='none' selected></option>
										</select>
									</td>
									<td class='player_name'>${player.name }</td>
									<td class='player_position'>${player.player_position }</td>
									<td class='player_age'>${player.age }</td>
									<td class='player_overall'>${player.overall }</td>
								</tr>
								</c:forEach>
								</tbody>
							</table>
						</td>
						
						<td class='content_500' id='detail_info'>
						</td>
					<!-- content end -->
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
					<p> - test1</p>
					<p> - test2</p>
					<p> - test3</p>
					<p> - test4</p>
				</div>
			</td>
		</tr>
		<tr>
			<td class='left_menu'>
				<div class="left_main_menu" id='league_record'>4.리그 기록</div>
				<div class='left_sub_menu'>
					<p> - test1</p>
					<p> - test2</p>
					<p> - test3</p>
					<p> - test4</p>
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