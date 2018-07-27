<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %> 
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/css/common.css">
	<script type="text/javascript" src="${pageContext.request.contextPath}/js/jquery-3.3.1.min.js"/></script>
	<title>Web Game FG - Create Team</title>
</head>
<body>
<script type="text/javascript">
function makePlayers(){
	$.ajax({
        type : "POST"
        , url : "/fg/login/createPlayer.do"
        , data : {}
        , success : function(data) {
    		var rtHtml = "";
    		var idx = 0;
    		var avg = 0;
    		var S_start = 90;
    		var A_start = 60;
    		var B_start = 45;
    		for(var i = 0;i < data.length;i++){
    			var rowData = data[i];
    			console.log(rowData);
        		rtHtml += "<tr>";
        		rtHtml += "<td>";
        		rtHtml += "<input type='text' class='edit_name' value='";
        		if(rowData.name != null && rowData.name != "")
        			rtHtml += rowData.name
        		else
        			rtHtml += "비기너 " + rowData.player_position + " 선수";
        		rtHtml += "'>";
        		rtHtml += "<input type='button' class='edit_bt' value='EDIT' data-key='"+rowData.player_key+"' style='float:right'>";
        		rtHtml += "</td>";
        		rtHtml += "<td>";
       			rtHtml += "" + rowData.position_detail;
        		rtHtml += "</td>";
        		rtHtml += "<td>";
       			rtHtml += "" + rowData.age;
        		rtHtml += "</td>";
        		rtHtml += "<td>";
       			rtHtml += "" + rowData.height;
        		rtHtml += "</td>";
        		rtHtml += "<td>";
       			rtHtml += "" + rowData.weight;
        		rtHtml += "</td>";
        		rtHtml += "<td>";
        		var position = rowData.position_detail.split("_");
        		if(position[1] == "GK"){
        			idx = parseInt(position[0]);
            		if(rowData.stat_gk[idx] >= S_start){
            			rtHtml += "<b style='color:red'>" + rowData.stat_gk[idx] + "</b>";
           			}
            		else if(rowData.stat_gk[idx] >= A_start){
            			rtHtml += "<b style='color:blue'>" + rowData.stat_gk[idx] + "</b>";
           			}
            		else if(rowData.stat_gk[idx] >= B_start){
            			rtHtml += "<b>" + rowData.stat_gk[idx] + "</b>";
           			}
        			else {
        				rtHtml += "" + rowData.stat_gk[idx];
        			}
        		}
        		else {
        			rtHtml += "" + rowData.stat_gk[0];
        		}
        		rtHtml += "</td>";
        		rtHtml += "<td>";
        		if(position[1] == "DF"){
        			idx = parseInt(position[0]);
            		if(rowData.stat_df[idx] >= S_start){
            			rtHtml += "<b style='color:red'>" + rowData.stat_df[idx] + "</b>";
           			}
            		else if(rowData.stat_df[idx] >= A_start){
            			rtHtml += "<b style='color:blue'>" + rowData.stat_df[idx] + "</b>";
           			}
            		else if(rowData.stat_df[idx] >= B_start){
            			rtHtml += "<b>" + rowData.stat_df[idx] + "</b>";
           			}
        			else {
        				rtHtml += "" + rowData.stat_df[idx];
        			}
        		}
        		else {
        			avg = (rowData.stat_df[0] + rowData.stat_df[1]) / 2
        			rtHtml += "" + parseInt(avg);
        		}
        		rtHtml += "</td>";
        		rtHtml += "<td>";
        		if(position[1] == "MF"){
        			idx = parseInt(position[0]);
            		if(rowData.stat_mf[idx] >= S_start){
            			rtHtml += "<b style='color:red'>" + rowData.stat_mf[idx] + "</b>";
           			}
            		else if(rowData.stat_mf[idx] >= A_start){
            			rtHtml += "<b style='color:blue'>" + rowData.stat_mf[idx] + "</b>";
           			}
            		else if(rowData.stat_mf[idx] >= B_start){
            			rtHtml += "<b>" + rowData.stat_mf[idx] + "</b>";
           			}
        			else {
        				rtHtml += "" + rowData.stat_mf[idx];
        			}
        		}
        		else {
        			avg = (rowData.stat_mf[0] + rowData.stat_mf[1] + rowData.stat_mf[2] + rowData.stat_mf[3]) / 4
        			rtHtml += "" + parseInt(avg);
        		}
        		rtHtml += "</td>";
        		rtHtml += "<td>";
        		if(position[1] == "FW"){
        			idx = parseInt(position[0]);
            		if(rowData.stat_fw[idx] >= S_start){
            			rtHtml += "<b style='color:red'>" + rowData.stat_fw[idx] + "</b>";
           			}
            		else if(rowData.stat_fw[idx] >= A_start){
            			rtHtml += "<b style='color:blue'>" + rowData.stat_fw[idx] + "</b>";
           			}
            		else if(rowData.stat_fw[idx] >= B_start){
            			rtHtml += "<b>" + rowData.stat_fw[idx] + "</b>";
           			}
        			else {
        				rtHtml += "" + rowData.stat_fw[idx];
        			}
        		}
        		else {
        			avg = (rowData.stat_fw[0] + rowData.stat_fw[1]) / 2
        			rtHtml += "" + parseInt(avg);
        		}
        		rtHtml += "</td>";
        		rtHtml += "</tr>"	
    		}
    		$("#player_list").append(rtHtml);
    		$("#waiting").text("");
        }
        , error : function(e) {
        	console.log(e.result);
        }
    });
}


$(document).ready(function(){
	makePlayers();
	
	$("#reload").on("click", function(){
		$("#player_list").empty();
		$("#waiting").text("Making Player...");
		makePlayers();
	});
	
	$("#save").on("click", function(){
		$.ajax({
	        type : "POST"
	        , url : "/fg/login/saveTeam.do"
	        , data : {
	        	team_name : $("#team_name").val()
	        	, tendency : $("#tendency option:selected").val()
	        	, rating : "0"
        	}
	        , success : function(data) {
	        	console.log(data);
    			var form = $("#send_form");
    			form.attr('method', "POST");
    			form.attr('action', "/fg/start/mainPage.do");
    			form.submit();
	        }
	        , error : function(e) {
	        	console.log(e.result);
	        }
	    });
	})
	
	$("body").on("click", ".edit_bt", function(){
		var _this = $(this);
		var key = _this.data("key");
		var name = _this.prev(".edit_name").val();
		$.ajax({
	        type : "POST"
	        , url : "/fg/login/editPlayerName.do"
	        , data : { 
	        	player_key : key
	        	, name : name
        	}
	        , success : function() {
	        	alert("Edit player name " + name);
	        }
        	, error : function(e) {
	        	console.log(e.result);
	        }
	    });
	});
});
</script>
<form id="send_form"></form>
<div class="html_part">
	<div class="div_center_table" style="width: 90%; margin: auto; margin-top: 50px;">
		<span>Team Name : </span>
		<input type="text" id="team_name" value="">
		<div class="div_right"><a href="#none" id="reload"><input type="button" value="REGENERATION"></a></div>
		<table id="player_list_table">
			<colgroup>
				<col width="36%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
				<col width="8%"/>
			</colgroup>
			<thead id="player_list_head">
				<tr>
					<th>Name</th>
					<th>Position</th>
					<th>Age</th>
					<th>Height</th>
					<th>Weight</th>
					<th>GK</th>
					<th>DF</th>
					<th>MF</th>
					<th>FW</th>
				</tr>
			</thead>
			<tbody id="player_list">
			</tbody>
		</table>
		<p class="center_p">Grade [ <b style="color:red">S : 90 ~ </b> / <b style="color:blue">A : 60 ~ </b> / <b>B : 45 ~ </b> / C : ~ 45 ]</p>
		<p class="center_p"><span id="waiting">Making Player...</span></p>
		<span>Coach Tendency</span>
		<select name="select_tendency" id="tendency">
		  <option value="" selected="selected"></option>
		  <option value="0">pass</option>
		  <option value="1">counter attack</option>
		  <option value="2">Shut up and attack</option>
		  <option value="3">2-line bus</option>
		</select>
		<div class="div_right"><input type="button" id="save" value="S A V E"></div>
	</div>
</div>
</body>
</html>